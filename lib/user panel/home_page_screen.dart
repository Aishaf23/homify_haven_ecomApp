import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/user%20panel/screens/cart/favorite_screen.dart';
import 'package:homify_haven/user%20panel/screens/order/orders_screen.dart';
import 'package:sizer/sizer.dart';

import 'package:homify_haven/widgets/discount_offers.dart';

import '../model/products.dart';
import '../widgets/pop_up.dart';
import '../widgets/banner_widget.dart';
import 'screens/product/product_detail_screen.dart';
import '../widgets/category_homeboxes.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Product> allProducts = [];

  getData() {
    FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((QuerySnapshot? snapshot) => {
              // ignore: avoid_function_literals_in_foreach_calls
              snapshot!.docs.forEach((e) {
                if (e.exists) {
                  setState(() {
                    allProducts.add(
                      Product(
                        category: e['category'],
                        id: e['id'],
                        productName: e['productName'],
                        detail: e['detail'],
                        description: e['description'],
                        price: e['price'],
                        discountPrice: e['discountPrice'],
                        serialCode: e['serialCode'],
                        imagesUrls: e['imagesUrls'],
                        isOnSale: e['isOnSale'],
                        isPopular: e['isPopular'],
                        isFavorite: e['isFavorite'],
                      ),
                    );
                  });
                }
              })
            });
    if (kDebugMode) {
      print(allProducts);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shop Furniture \nwith us in ease',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.to(() => FavouriteScreen);
                                },
                                icon:
                                    const Icon(Icons.shopping_basket_rounded)),
                            IconButton(
                              onPressed: () {
                                Get.to(() => OrdersScreen());
                              },
                              icon: const Icon(Icons.checklist),
                            ),
                            const CircleAvatarWithPopup(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Text-Field
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height * 0.063,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: width * 0.04),
                            const Text(
                              'Search',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 69.5.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.005,
                        ),
                        const Text(
                          'Most Featured Ones',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const CategoryHomeBoxes(),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        const Text(
                          'Recommended Ones',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        // images slideshow
                        const BannerWidget(),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        const Text(
                          'Popular',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        allProducts.isEmpty
                            ? const CircularProgressIndicator()
                            : PopularItem(allProducts: allProducts),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      'HOT \nSALES',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      'NEW \nARRIVAL',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        const Text(
                          'Discount Items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        DiscountItems(allProducts: allProducts),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PopularItem extends StatelessWidget {
  const PopularItem({
    super.key,
    required this.allProducts,
  });

  final List<Product> allProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(
                                          id: e.id,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.network(
                                e.imagesUrls![0],
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Text(e.productName!)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
