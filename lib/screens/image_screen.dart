import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FurnitureSlider extends StatelessWidget {
  final List<dynamic> furnitures;

  const FurnitureSlider({Key? key, required this.furnitures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: furnitures.map((furniture) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.network(
                furniture['imageurl'][0],
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
