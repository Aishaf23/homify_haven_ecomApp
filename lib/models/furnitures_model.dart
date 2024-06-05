import 'package:flutter/material.dart';

class Furniture {
  final int id;
  final String title;
  final double price;
  final String name;
  final String product;
  final List<String> imageurl;
  final String description;
  final String productDetails;
  final String measurement;
  final String category;
  // final String quantity;

  Furniture({
    required this.id,
    required this.title,
    required this.price,
    required this.name,
    required this.product,
    required this.imageurl,
    required this.description,
    required this.productDetails,
    required this.measurement,
    required this.category,
    // required this.quantity,
  });

  // Convert a map into a Furniture object
  factory Furniture.fromMap(Map<String, dynamic> map) {
    return Furniture(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      name: map['name'],
      product: map['product'],
      imageurl: List<String>.from(map['imageurl']),
      description: map['description'],
      productDetails: map['product_details'],
      measurement: map['measurement'],
      category: map['category'],
      // quantity: map['quantity'],
    );
  }

  // Convert a Furniture object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'name': name,
      'product': product,
      'imageurl': imageurl,
      'description': description,
      'product_details': productDetails,
      'measurement': measurement,
      'category': category,
      // 'quantity': quantity,
    };
  }
}
// 