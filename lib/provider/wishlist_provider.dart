import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  // Data maintain
  List<Map<String, dynamic>> wishlistItems = [];

  // Add product
  void addProduct(Map<String, dynamic> furniture, BuildContext context) {
    if (!wishlistItems.any((item) => item['id'] == furniture['id'])) {
      wishlistItems.add(furniture);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item added to wishlist'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item is already in the wishlist'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  // Remove product
  void removeProduct(Map<String, dynamic> furniture) {
    wishlistItems.removeWhere((item) => item['id'] == furniture['id']);
    notifyListeners();
  }

  // Clear cart
  void clearWishlist() {
    wishlistItems.clear();
    notifyListeners();
  }
}
