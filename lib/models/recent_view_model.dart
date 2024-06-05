import 'package:flutter/material.dart';

class RecentlyViewedModel with ChangeNotifier {
  String name;
  String price;
  String image;

  RecentlyViewedModel({
    required this.name,
    required this.price,
    required this.image,
  });
}
