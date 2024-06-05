import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:homify_haven/screens/collections/beds_cati.dart';
import 'package:homify_haven/screens/collections/shelves_col.dart';

import 'package:homify_haven/screens/collections/sofa_cati.dart';

class FurnitureCategory extends StatelessWidget {
  const FurnitureCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homify\'s Collection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dancing Script',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'image-1',
                      child: Image.asset(
                        'images/sofas/kivik_pink_3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'EXCLUSIVE OFFERS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jersey'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    crossAxisCount: 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.3,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return SofaCategory();
                          // }));
                        },
                        child: const CategoryCard(
                          title: 'Sofa Collections',
                          subtitle: 'Exclusive For Comfort',
                          image: 'images/sofas/linanaes-main.jpg',
                          discount: '50% OFF',
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return BedsCategory();
                          // }));
                        },
                        child: const CategoryCard(
                          title: 'Bed Collections',
                          subtitle: 'Make Your \nSleep Better',
                          image: 'images/mainmenu/daybed.jpg',
                          discount: '30% OFF',
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return ShelfCollections();
                          // }));
                        },
                        child: const CategoryCard(
                          title: 'Shelves Categories',
                          subtitle: 'Exclusive For Books \n& Classic Look',
                          image: 'images/mainmenu/white_shelf.jpg',
                          discount: '25% OFF',
                        ),
                      ),
                      // Add more categories here
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String discount;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(85),
            bottomLeft: Radius.circular(85),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(85),
                bottomLeft: Radius.circular(85),
              ),
            ),
            child: Card(
              color: Colors.white,
              child: Image.asset(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 2,
          child: Container(
            height: 150,
            width: 180,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
              ),
              color: Colors.white54,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    discount,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
