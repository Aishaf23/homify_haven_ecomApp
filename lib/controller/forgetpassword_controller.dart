// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homify_haven/user%20panel/screens/auth_screens/login_screen.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//for password visibility
  var isPasswordsVisible = false.obs;

  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait');

      await _auth.sendPasswordResetEmail(email: userEmail);

      Get.snackbar(
        "Request Sent Successfully",
        "Password reset link sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 209, 32, 0),
        colorText: const Color(0xfff5f5f5),
      );

      Get.offAll(() => const LoginPage());

      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

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
