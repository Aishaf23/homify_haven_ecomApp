import 'package:flutter/material.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:homify_haven/screens/login/login_screen.dart';
import 'package:homify_haven/menu_page.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({super.key});

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
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
              // left: 0,
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
                          onPressed: () {
                            Get.offAll(() => MainMenu());
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
              )),
          // Positioned(
          //   bottom: 6,
          //   right: 2,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         'Don\'t have an account?',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       TextButton(
          //           onPressed: () {
          //             navigateToLoginScreen();
          //           },
          //           child: Text(
          //             'Sign Up',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold, color: Colors.black),
          //           ))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  // navigateToMainMenu() {
  //   Future.delayed(const Duration(milliseconds: 0), () {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return const MainMenu();
  //     }));
  //   });
  // }

  // navigateToLoginScreen() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LoginPage();
  //   }));
  // }
}
