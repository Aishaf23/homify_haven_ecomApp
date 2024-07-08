import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user panel/screens/auth_screens/login_screen.dart';

class SignOutController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    Get.offAll(() => const LoginPage());
    notifyListeners();
  }
}
