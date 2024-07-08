import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});

  static const String id = "deleteProduct";

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text("Delete Product"),
      ),
    );
  }
}
