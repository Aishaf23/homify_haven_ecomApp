import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? category;
  String? productName;
  String? detail;
  String? description;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<dynamic>? imagesUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavorite;

  Product({
    this.category,
    this.id,
    this.productName,
    this.detail,
    this.description,
    this.price,
    this.discountPrice,
    this.serialCode,
    this.imagesUrls,
    this.isOnSale,
    this.isPopular,
    this.isFavorite,
  });

  static Future<void> addProducts(Product products) async {
    CollectionReference db = FirebaseFirestore.instance.collection('items');

    Map<String, dynamic> data = {
      "category": products.category,
      "id": products.id,
      "productName": products.productName,
      "detail": products.detail,
      "description": products.description,
      "price": products.price,
      "discountPrice": products.discountPrice,
      "serialCode": products.serialCode,
      "imagesUrls": products.imagesUrls,
      "isOnSale": products.isOnSale,
      "isPopular": products.isPopular,
      "isFavorite": products.isFavorite,
    };

    await db.add(data);
  }

  static Future<void> updateProduct(String id, Product updateProduct) async {
    CollectionReference db = FirebaseFirestore.instance.collection('items');

    Map<String, dynamic> data = {
      "category": updateProduct.category,
      "id": updateProduct.id,
      "productName": updateProduct.productName,
      "detail": updateProduct.detail,
      "description": updateProduct.description,
      "price": updateProduct.price,
      "discountPrice": updateProduct.discountPrice,
      "serialCode": updateProduct.serialCode,
      "imagesUrls": updateProduct.imagesUrls,
      "isOnSale": updateProduct.isOnSale,
      "isPopular": updateProduct.isPopular,
      "isFavorite": updateProduct.isFavorite,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection('items');

    await db.doc(id).delete();
  }
}
