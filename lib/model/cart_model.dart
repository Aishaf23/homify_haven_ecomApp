import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? id;
  String? name;
  int? quantity;
  int? price;
  String? image;

  CartModel({
    this.id,
    this.image,
    this.name,
    this.price,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': name,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: data['id'],
      image: data['image'],
      name: data['productName'],
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
}
