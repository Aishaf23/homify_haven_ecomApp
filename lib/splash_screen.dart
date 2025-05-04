import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:homify_haven/admin_panel/screens/admin_main.dart';
import 'package:homify_haven/controller/get_user_data_controller.dart';
import 'package:homify_haven/user%20panel/screens/auth_screens/login_screen.dart';
import 'package:homify_haven/user%20panel/bottom_nav_bar/bottom_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> loggedIn(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      // if admin or not
      if (userData[0]['isAdmin'] == false) {
        Get.offAll(() => const BottomPage());
        Get.snackbar(
          'Welcome Back ${FirebaseAuth.instance.currentUser!.displayName}',
          "Login Successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(255, 181, 240, 211),
          colorText: Colors.black,
        );
      } else {
        Get.offAll(() => const AdminScreen());
      }
    }
    // user null
    else {
      Get.to(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: height * 1,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      child: ImageSlideshow(
                        indicatorColor: Colors.blue,
                        onPageChanged: (value) {
                          // debugPrint('Page changed: $value');
                        },
                        autoPlayInterval: 2800,
                        isLoop: true,
                        children: [
                          Image.asset(
                            'images/getstarted/greybed.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/getstarted/sofa.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/getstarted/outdoornight.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/getstarted/flowervase.jpg',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ), // Replace with your ImageSlideshow
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 500,
            child: Container(
              height: height * 0.5,
              width: width * 0.9,
              decoration: const BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(500),
                    bottomLeft: Radius.circular(0),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Looking for Comfort?',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0375,
                    ),
                    const Text(
                      'Well! You\'re at the right place. \nWe provide comfort seeking your opinions.',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(164, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          EasyLoading.show(status: 'Please wait...');
                          await loggedIn(context);
                          EasyLoading.dismiss();
                        },
                        label: const Text("Let's Get Started",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white60,
                            maximumSize: Size(width * 2, height * 45)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
