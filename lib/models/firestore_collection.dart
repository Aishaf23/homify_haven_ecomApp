import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/screens/order/thankyou.dart';

Future<void> addProductsToFirestore(
    List<Map<String, dynamic>> furnitures) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (var furniture in furnitures) {
    await firestore.collection('products').add(furniture).then((docRef) {
      print("Product added with ID: ${docRef.id}");
      // navigateToThankYouScreen();
    }).catchError((error) {
      print("Error adding product: $error");
    });
  }
}


  // void showFlushbar(BuildContext context, String message) {
  //   Flushbar(
  //     flushbarPosition: FlushbarPosition.TOP,
  //     message: message,
  //     duration: Duration(seconds: 2),
  //     backgroundColor: Colors.amber.shade300,
  //     messageText: Text(
  //       message,
  //       style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
  //     ),
  //     margin: EdgeInsets.all(12),
  //     borderRadius: BorderRadius.circular(20),
  //   ).show(context);
  // }
