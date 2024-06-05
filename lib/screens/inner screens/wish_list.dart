import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/menu_page.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/provider/wishlist_provider.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Map<String, dynamic>> filteredFurniture = furnitures;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final wishList = context.watch<WishlistProvider>().wishlistItems;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          Text(
            'WishList',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          if (wishList.isNotEmpty)
            TextButton(
              onPressed: () {
                context.read<WishlistProvider>().clearWishlist();
              },
              child: Text(
                'Clear WishList',
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.black54,
                ),
              ),
            ),
        ],
      ),
      body: wishList.isEmpty
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/empty_wishlist.png',
                        height: height * 0.55,
                        width: width * 0.55,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 100,
                      child: Column(
                        children: [
                          Text(
                            'Your wishlist is empty!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return MainMenu();
                              }));
                            },
                            child: Text(
                              'Explore',
                              style: TextStyle(
                                color: Colors.tealAccent,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize:
                                    Size(width * 0.130, height * 0.050)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 7,
                childAspectRatio: 0.72,
              ),
              itemCount: wishList.length,
              itemBuilder: (context, index) {
                final furniture = wishList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FurniiDetailPage(
                          furniture: furniture,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image.network(
                            furniture['imageurl'][0],
                            height: height * 0.18,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                furniture['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$ ${furniture['price']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<WishlistProvider>()
                                            .removeProduct(
                                                furniture); // Remove the furniture item from wishlist
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Item removed from wishlist'),
                                          duration: Duration(seconds: 1),
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors
                                            .red, // Change the color of the icon to indicate it's selected
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
