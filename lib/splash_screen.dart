import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/utils/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

import 'front_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => FrontScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF981206),
      body: Container(
        color: Colors.transparent, // Ensure the container is transparent
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                color:
                    Colors.transparent, // Ensure the container is transparent
                child: Lottie.asset(
                  'images/splash-icon.json',
                ),
              ),
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              color: Colors.transparent, // Ensure the container is transparent
              child: Text(
                AppConstants.appPoweredBy,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
