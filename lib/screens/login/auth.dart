import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homify_haven/menu_page.dart';
import 'package:homify_haven/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({
    required String emailLogin,
    required String passwordLogin,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailLogin,
        password: passwordLogin,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainMenu();
      }));
      print('${emailLogin} has Signed In');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String phone,
    required String emailRegister,
    required String passwordRegister,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailRegister,
        password: passwordRegister,
      );
      User? user = userCredential.user;

      UserModel newUser = UserModel(
        uid: user?.uid,
        name: name,
        phone: phone,
        email: emailRegister,
        password: passwordRegister,
      );

      // Add user to Firestore
      await _firestore.collection('Users').doc(user?.uid).set(newUser.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful')),
      );

      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainMenu();
      }));
      print('${emailRegister} has created an account');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> userSignOut(BuildContext context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Log Out Successful')),
      );
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainMenu()), (route) => false);
      print('User has Signed Out');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> userDelete(BuildContext context) async {
    try {
      User? user = _auth.currentUser;

      // Delete user from Firestore
      await _firestore.collection('Users').doc(user?.uid).delete();

      await user?.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User is deleted')),
      );
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainMenu()), (route) => false);
      print('${user} is deleted');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
