import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // Data maintain
  List<Map<String, dynamic>> cartList = [];

  // Add product
  void addProduct(Map<String, dynamic> furniture) {
    // int index = cartList.indexWhere((item) => item['id'] == furniture['id']);
    // if (index != -1) {
    //   cartList[index]['quantity'] += 1;
    // } else {
    //   furniture['quantity'] = 1;
    cartList.add(furniture);
    // }
    notifyListeners();
  }

  // Remove product
  void removeProduct(Map<String, dynamic> furniture) {
    // cartList.removeWhere((item) => item['id'] == furniture['id']);
    cartList.remove(furniture);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    cartList.clear();
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(Map<String, dynamic> furniture) {
    int index = cartList.indexWhere((item) => item['id'] == furniture['id']);
    if (index != -1) {
      cartList[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(Map<String, dynamic> furniture) {
    int index = cartList.indexWhere((item) => item['id'] == furniture['id']);
    if (index != -1 && cartList[index]['quantity'] > 1) {
      cartList[index]['quantity'] -= 1;
      notifyListeners();
    } else if (index != -1 && cartList[index]['quantity'] == 1) {
      removeProduct(furniture);
    }
  }
}
