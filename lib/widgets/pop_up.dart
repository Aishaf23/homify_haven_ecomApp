import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homify_haven/user%20panel/screens/auth_screens/login_screen.dart';
import 'package:homify_haven/user%20panel/screens/order/orders_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/screens/profile_screen.dart';

class CircleAvatarWithPopup extends StatefulWidget {
  const CircleAvatarWithPopup({super.key});

  @override
  State<CircleAvatarWithPopup> createState() => _CircleAvatarWithPopupState();
}

class _CircleAvatarWithPopupState extends State<CircleAvatarWithPopup> {
  String? profilePicUrl;

  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchUserProfile() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('profileInfo').doc(user.uid).get();

      if (docSnapshot.exists) {
        setState(() {
          profilePicUrl = docSnapshot['profilePic'];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text('Profile'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('View My Orders'),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text('Logout'),
        ),
      ],
      onSelected: (value) async {
        if (value == 1) {
          Get.to(() => const ProfileScreen());
        } else if (value == 2) {
          Get.to(() => OrdersScreen());
        } else if (value == 3) {
          _showLogoutConfirmationDialog();
        }
      },
      child: CircleAvatar(
        child: CircleAvatar(
          backgroundImage: profilePicUrl != null
              ? NetworkImage(profilePicUrl!)
              : const AssetImage('images/default_avatar.png') as ImageProvider,
          backgroundColor: const Color.fromARGB(255, 181, 240, 211),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                GoogleSignIn googleSignIn = GoogleSignIn();
                FirebaseAuth auth = FirebaseAuth.instance;

                await googleSignIn.signOut();
                await auth.signOut();
                Get.offAll(() => const LoginPage());

                if (kDebugMode) {
                  print('User has signed out');
                }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout Successful')),
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
