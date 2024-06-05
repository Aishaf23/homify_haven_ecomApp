import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/classes/popular_class.dart';
import 'package:homify_haven/screens/category_furniture_page..dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';
import 'package:homify_haven/screens/inner%20screens/search_screen.dart';
import 'package:homify_haven/screens/inner%20screens/wish_list.dart';
import 'package:homify_haven/screens/order/order_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    "All Categories",
    "Sofas",
    "Table",
    // "Chairs",
    "Beds",
    "Dining Furniture",
    "Shelving Furniture",
    "Plants",
    "Outdoor Furniture"
  ];

  List<Map<String, dynamic>> filteredFurniture = furnitures;

  // for drawer
  late int selectedIndex = 0;
  // for chip
  late int currentIndex = 0;

  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
    // dataStream = db.collection("products").snapshots();
  }

  List<Map<String, dynamic>> filterFurnitureByCategory(
      List<Map<String, dynamic>> items, String category) {
    return items.where((item) => item['title'] == category).toList();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> dataStream;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: height * 0.145,
              width: double.infinity,
              child: DrawerHeader(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.only(left: 4.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.03),
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final category = categories[index];
                List<Map<String, dynamic>> filteredItems;

                if (category == "All Categories") {
                  // Display all items if the category is "All Categories"
                  filteredItems = furnitures.toList();
                } else {
                  // Filter items based on the current category
                  filteredItems = furnitures
                      .where((item) =>
                          item['title'] == category ||
                          item['product'] == category)
                      .toList();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return CategoryFurniturePage(
                            category: category, furnitureItems: filteredItems);
                      }));
                    },
                    title: Text(
                      category,
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            onPressed: () {},
                            icon: const Icon(Icons.notification_add_rounded)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return WishListScreen();
                              }));
                            },
                            icon: const Icon(Icons.shopping_basket_rounded)),
                        Builder(
                          builder: (context) => IconButton(
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            icon: const Icon(Icons.more_vert_rounded),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // Text-Field
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: height * 0.063,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.025),

                Text(
                  'Most Featured Ones',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                // Most Featured Ones
                SizedBox(
                  height: height * 0.11,
                  child: ListView.builder(
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredFurniture.length,
                    itemBuilder: (context, index) {
                      final furniture = filteredFurniture[index];
                      if (furniture['feature'] != null &&
                          furniture['feature'] == 'Exclusive') {
                        return Container(
                          width: width * 0.275,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: Image.network(
                                      furniture['imageurl'][1].toString(),
                                      height: height * 0.09,
                                      // it is not changing properly
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(); // Return an empty container if the feature is not 'Exclusive'
                      }
                    },
                  ),
                ),

                Text(
                  'Popular',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                // image slideshow
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 0,
                      bottom: 0,
                    ),
                    child: SizedBox(
                      height: height * 0.275,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: ImageSlideshow(
                          indicatorColor: Colors.blue,
                          onPageChanged: (value) {
                            // debugPrint('Page changed: $value');
                          },
                          autoPlayInterval: 2000,
                          isLoop: true,
                          children: [
                            Image.network(
                              'https://www.ikea.com/ext/ingkadam/m/45818b92fa4bc9e/original/PH193370.jpg?f=m',
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              'https://www.ikea.com/us/en/images/products/tufjord-upholstered-bed-frame-tallmyra-black-blue__1259491_pe926696_s5.jpg?f=s',
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              'https://www.ikea.com/us/en/images/products/utter-childrens-table-indoor-outdoor-white__0925717_ph142081_s5.jpg?f=s',
                              fit: BoxFit.fill,
                            ),
                            Image.network(
                              'https://www.ikea.com/us/en/images/products/fejka-artificial-potted-plant-indoor-outdoor-magnolia__0965444_pe809428_s5.jpg?f=s',
                              fit: BoxFit.fill,
                            ),
                            Image.network(
                              'https://www.ikea.com/us/en/images/products/solig-net-white__0983773_ph176437_s5.jpg?f=s',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  'Furnitures',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                // Furitures
                SingleChildScrollView(
                  child: SizedBox(
                    height: height * 0.5,
                    child: GridView.builder(
                      itemCount: popular.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 0.85,
                        maxCrossAxisExtent:
                            200, // Set the max width for each item
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FurniiDetailPage(
                                  furniture: popular[index]);
                            }));
                          },
                          child: Card(
                            elevation: 0,
                            color: const Color.fromRGBO(0, 0, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      (popular[index]['imageurl']
                                              as List<dynamic>)[1]
                                          .toString(),
                                      width: double.infinity,
                                      height: height * 0.16,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    popular[index]['name'].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${popular[index]['price'].toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
