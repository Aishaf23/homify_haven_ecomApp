import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String id = "cartScreen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
      body: Center(
        child: Text("CART SCREEN"),
      ),
    );
  }
}