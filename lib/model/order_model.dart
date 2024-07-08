import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  OrderModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    return OrderModel(
      id: doc.id,
      name: doc['name'],
      image: doc['image'],
      price: doc['price'],
      quantity: doc['quantity'],
    );
  }
}
