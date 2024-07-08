import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:homify_haven/user%20panel/bottom_nav_bar/bottom_page.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: width * 0.25,
                color: Colors.green,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                currentUser!.displayName!,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                'Your order will be delievered in 3 to 5 working days.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              InkWell(
                onTap: () => Get.offAll(() => const BottomPage()),
                child: Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Go to Home Page',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
