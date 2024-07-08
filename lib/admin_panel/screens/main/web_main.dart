import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:homify_haven/admin_panel/screens/admin_main.dart';

import '../dashboard/add_product.dart';
import '../dashboard/dashboard.dart';
import '../dashboard/delete_product.dart';
import '../dashboard/update_product.dart';

class WebMainScreen extends StatefulWidget {
  static const String id = "webMain";

  const WebMainScreen({super.key});

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen = const DashboardScreen();

  chooseScreens(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = const DashboardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = const AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Notice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: const Text(
                  'Delete is available on the Update Product Screen.'),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "ADMIN PANEL",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(550, 50, 0, 0),
                  items: [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Log Out'),
                    ),
                  ],
                ).then((value) {
                  if (value == 1) {
                    // Handle logout here
                    showLogoutConfirmationDialog(context);
                  }
                });
              },
              child: Container(
                height: 40,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      sideBar: SideBar(
        iconColor: Colors.white,
        activeIconColor: Colors.white,
        backgroundColor: Colors.black,
        textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
        onSelected: (item) {
          chooseScreens(item);
        },
        items: const [
          AdminMenuItem(
            title: "DASHBOARD",
            icon: Icons.dashboard,
            route: DashboardScreen.id,
          ),
          AdminMenuItem(
            title: "ADD PRODUCTS",
            icon: Icons.add,
            route: AddProductScreen.id,
          ),
          AdminMenuItem(
            title: "UPDATE PRODUCTS",
            icon: Icons.update,
            route: UpdateProductScreen.id,
          ),
          AdminMenuItem(
            title: "DELETE PRODUCTS",
            icon: Icons.delete,
            route: DeleteProductScreen.id,
          ),
          // AdminMenuItem(
          //   title: "CART ITEMS",
          //   icon: Icons.shop,
          // ),
        ],
        selectedRoute: WebMainScreen.id,
      ),
      body: selectedScreen,
    );
  }

  showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                // For example, you can sign out the user here
                FirebaseAuth.instance.signOut();
                // Navigate to the login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminScreen(),
                  ),
                );

                Fluttertoast.showToast(
                  msg: "Admin has Signed Out",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: const Color.fromARGB(255, 5, 196, 202),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
