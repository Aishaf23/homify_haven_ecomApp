// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class OrdersModel {
//   String? id;
//   String? name;
//   int? quantity;
//   int? price;
//   String? image;
//   bool? status;
//   String? customerId;
//   dynamic createdAt;
//   dynamic updatedAt;
//   String? customerName;
//   String? customerPhone;
//   String? customerAddress;
//   // String? customerDeviceToken;

//   OrdersModel({
//     @required this.id,
//     @required this.image,
//     @required this.name,
//     @required this.price,
//     this.quantity,
//     required this.customerId,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.customerName,
//     required this.customerPhone,
//     required this.customerAddress,
//     // required this.customerDeviceToken,
//   });

//   static Future<void> addtoorders(OrdersModel orders) async {
//     CollectionReference db = FirebaseFirestore.instance.collection("orders");
//     Map<String, dynamic> data = {
//       "id": orders.id,
//       "productName": orders.name,
//       "image": orders.image,
//       "quantity": orders.quantity,
//       "price": orders.price,
//     };
//     await db.add(data);
//   }

//   factory OrdersModel.fromMap(Map<String, dynamic> json) {
//     return OrdersModel(
//       id: json['id'],
//       image: json['image'],
//       name: json['name'],
//       price: json['price'],
//       quantity: json['quantity'],
//       customerId: json['customerId'],
//       status: json['status'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       customerName: json['customerName'],
//       customerPhone: json['customerPhone'],
//       customerAddress: json['customerAddress'],
//       // customerDeviceToken: json['customerDeviceToken'],
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'image': image,
//       'name': name,
//       'price': price,
//       'quantity': quantity,
//       'status': status,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'customerId': customerId,
//       'customerName': customerName,
//       'customerPhone': customerPhone,
//       'customerAddress': customerAddress,
//       // 'customerDeviceToken': customerDeviceToken,
//     };
//   }
// }
