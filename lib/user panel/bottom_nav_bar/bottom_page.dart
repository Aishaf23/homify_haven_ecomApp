import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/user%20panel/home_page_screen.dart';
import 'package:homify_haven/user%20panel/screens/cart/favorite_screen.dart';
import 'package:homify_haven/user%20panel/screens/product/product_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/settings.dart';

import '../screens/cart/cart_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  // const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;

  void cartItemsLength() {
    FirebaseFirestore.instance.collection('cart').get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        setState(() {
          length = 0;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cartItemsLength();
  }

  @override
  Widget build(BuildContext context) {
    cartItemsLength();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shop), label: 'Products'),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.add_shopping_cart),
                  Positioned(
                      right: -2,
                      top: -2,
                      child: length == 0
                          ? Container()
                          : Stack(
                              children: [
                                const Icon(
                                  Icons.brightness_1,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$length",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )))
                              ],
                            ))
                ],
              ),
              label: 'Cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favorite'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: HomePageScreen());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProductScreen());
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: CartScreen());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: FavouriteScreen());
              }));

            case 4:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: SettingsPage());
              }));

            default:
          }
          return const HomePageScreen();
        });
  }
}
