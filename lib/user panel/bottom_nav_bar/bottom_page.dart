import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/user%20panel/home_page_screen.dart';
import 'package:homify_haven/user%20panel/screens/cart/favorite_screen.dart';
import 'package:homify_haven/user%20panel/screens/product/product_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/settings.dart';
import '../screens/cart/cart_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;
  StreamSubscription<QuerySnapshot>? _cartSubscription;

  @override
  void initState() {
    super.initState();
    _initCartListener();
  }

  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }

  void _initCartListener() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _cartSubscription = FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('cartItems')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        length = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shop), label: 'Products'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (length > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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
            return CupertinoTabView(
                builder: ((context) =>
                    CupertinoPageScaffold(child: HomePageScreen())));
        }
      },
    );
  }
}
