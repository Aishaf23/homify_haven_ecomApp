import 'package:flutter/material.dart';

import '../model/products.dart'; // Update this import according to your actual file structure

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: product.imagesUrls != null && product.imagesUrls!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imagesUrls![0],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(height: 80, width: 80, color: Colors.grey),
          title: Text(
            product.productName ?? 'No Name',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.category ?? 'No Category',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          trailing: Text(
            '\$${product.price ?? 0}',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
