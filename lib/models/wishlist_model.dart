import 'package:flutter/material.dart';

class WishListModel with ChangeNotifier {
  String name;
  String price;
  String image;

  WishListModel({
    required this.name,
    required this.price,
    required this.image,
  });
}
