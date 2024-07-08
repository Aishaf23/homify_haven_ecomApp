import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/user%20panel/home_page_screen.dart';
import 'package:homify_haven/user%20panel/screens/cart/cart_screen.dart';
import 'package:homify_haven/user%20panel/screens/cart/favorite_screen.dart';
import 'package:homify_haven/user%20panel/screens/product/product_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/settings.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;

  void cartItemsLength() async {
    try {
      var snap = await FirebaseFirestore.instance.collection('cart').get();
      if (!mounted) return; // Check if widget is still mounted
      setState(() {
        length = snap.docs.length;
      });
    } catch (e) {
      if (!mounted) return; // Check if widget is still mounted
      setState(() {
        length = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cartItemsLength(); // Initial call to set the cart items length
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shop), label: 'Product'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                if (length >
                    0) // Show badge only if there are items in the cart
                  Positioned(
                    right: -3,
                    top: -2,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "$length",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: HomePageScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: ProductScreen());
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: CartScreen());
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: FavouriteScreen());
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: SettingsPage());
              },
            );
          default:
            return const HomePageScreen();
        }
      },
    );
  }
}
