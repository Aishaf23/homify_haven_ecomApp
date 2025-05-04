import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartModel {
  final String? id;
  final String? documentId;
  final String? productId;
  final String? productName;
  final String? image;
  final int? quantity;
  final int? price;
  final int? discountPrice;

  CartModel({
    this.id,
    this.documentId,
    this.productId,
    this.productName,
    this.image,
    this.quantity,
    this.price,
    this.discountPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: data['id'],
      productId: data['productId'],
      image: data['image'],
      productName: data['productName'],
      price: data['price'],
      quantity: data['quantity'],
    );
  }

  static Future<void> addtoCart(CartModel cart) async {
    CollectionReference db = FirebaseFirestore.instance.collection("cart");
    await db.add(cart.toMap());
  }

  static Future<void> addtoOrder(CartModel order) async {
    CollectionReference db = FirebaseFirestore.instance.collection("orders");
    await db.add(order.toMap());
  }

  static Future<void> addOrUpdateCartItem(CartModel cartItem) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final cartRef = FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartItems');

      // Check if item already exists
      final query = await cartRef
          .where('productId', isEqualTo: cartItem.productId)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        // Update existing item
        final existingDoc = query.docs.first;
        final currentQuantity = existingDoc['quantity'] ?? 1;
        final newQuantity = currentQuantity + (cartItem.quantity ?? 1);

        await cartRef.doc(existingDoc.id).update({
          'quantity': newQuantity,
          'price': cartItem.price! * newQuantity,
        });
      } else {
        // Add new item
        await cartRef.add({
          'productId': cartItem.productId,
          'productName': cartItem.productName,
          'image': cartItem.image,
          'quantity': cartItem.quantity,
          'price': cartItem.price,
          'discountPrice': cartItem.discountPrice,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error in addOrUpdateCartItem: $e');
      rethrow;
    }
  }

  static Future<void> removeFromCart(String documentId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartItems')
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error in removeFromCart: $e');
      rethrow;
    }
  }
}
