import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        deviceToken = token;
        if (kDebugMode) {
          print("Token retrieved: $deviceToken");
        }
        update();
      } else {
        if (kDebugMode) {
          print("Token is null");
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 209, 32, 0),
        colorText: const Color(0xfff5f5f5),
      );
    }
  }
}
