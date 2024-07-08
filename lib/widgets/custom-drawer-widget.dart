// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homify_haven/user%20panel/screens/auth_screens/login_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 200),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 50, bottom: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Aisha",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: TextStyle(color: Colors.black54),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.greenAccent,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Products",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onTap: () {
                  // Get.back();
                  // Get.to(() => AllOrdersScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contact",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.help,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          content: const Text('Do you want to logout?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  GoogleSignIn googleSignIn = GoogleSignIn();
                                  FirebaseAuth _auth = FirebaseAuth.instance;
                                  await _auth.signOut();
                                  await googleSignIn.signOut();
                                  Get.offAll(() => LoginPage());
                                },
                                child: const Text(
                                  'YES',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        );
                      });
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
