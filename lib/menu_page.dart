import 'package:flutter/material.dart';
import 'package:homify_haven/menu_bottom_bar/home_page.dart';
import 'package:homify_haven/menu_bottom_bar/profile/profile.dart';
import 'package:homify_haven/menu_bottom_bar/settings.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/screens/cart/cart_page.dart';

import 'package:homify_haven/screens/collections/furniture_category.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int currentPageIndex = 2;

  final List pages = [
    const ProfilePage(),
    const AddToCart(),
    const HomePage(),
    const FurnitureCategory(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: pages[currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: height * 0.0675,
        selectedIndex: currentPageIndex,
        indicatorColor: const Color.fromARGB(255, 181, 240, 211),
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        surfaceTintColor: const Color.fromARGB(246, 3, 218, 114),
        destinations: [
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        context
                            .watch<CartProvider>()
                            .cartList
                            .length
                            .toString(),
                        style: TextStyle(
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
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.category), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
