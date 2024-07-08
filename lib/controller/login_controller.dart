import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // For password visibility
  var isPasswordsVisible = false.obs;

  Future<UserCredential?> signInMethod(
    String userEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      EasyLoading.dismiss();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      String errorMessage = _mapFirebaseAuthExceptionMessage(e);

      Get.snackbar(
        "Sign-In Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 209, 32, 0),
        colorText: const Color(0xfff5f5f5),
      );
    }
    return null;
  }

  String _mapFirebaseAuthExceptionMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Sign-In failed. Please try again later.';
    }
  }
}
