import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homify_haven/controller/get_device_token_controller.dart';
import 'package:homify_haven/model/user_model.dart';
import 'package:homify_haven/user%20panel/bottom_nav_bar/bottom_page.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    final GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: 'Please wait..');
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        // Sign in with Google for user
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // User login --> his id store
        final User? user = userCredential.user;

        if (user != null) {
          // Wait for device token to be fetched
          await getDeviceTokenController.getDeviceToken();

          String? userDeviceToken = getDeviceTokenController.deviceToken;
          if (kDebugMode) {
            print("User Device Token: $userDeviceToken");
          }

          UserModel userModel = UserModel(
            uId: user.uid,
            username: user.displayName.toString(),
            email: user.email.toString(),
            phone: user.phoneNumber.toString(),
            userImg: user.photoURL.toString(),
            userDeviceToken: userDeviceToken ?? '',
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: '',
          );

          if (kDebugMode) {
            print("User Model: ${userModel.toMap()}");
          }

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap());

          EasyLoading.dismiss();

          Get.offAll(() => const BottomPage());
        } else {
          if (kDebugMode) {
            print("User is null after Google Sign-In");
          }
        }
      } else {
        if (kDebugMode) {
          print("Google Sign-In Account is null");
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
