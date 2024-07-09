import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:homify_haven/admin_panel/screens/dashboard/add_product.dart';
// import 'package:homify_haven/admin_panel/screens/dashboard/cart_screen.dart';
import 'package:homify_haven/admin_panel/screens/dashboard/dashboard.dart';
import 'package:homify_haven/admin_panel/screens/dashboard/delete_product.dart';
import 'package:homify_haven/admin_panel/screens/dashboard/update_product.dart';
import 'package:homify_haven/admin_panel/layout.dart';
import 'package:homify_haven/admin_panel/screens/main/web_main.dart';

import 'admin_panel/screens/admin_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAwDbDCanDB0bbaVJmwW8d07VDmTgfu4fA",
            authDomain: "homify-haven.firebaseapp.com",
            projectId: "homify-haven",
            storageBucket: "homify-haven.appspot.com",
            messagingSenderId: "769552251632",
            appId: "1:769552251632:web:01c16a0e04bc66fb93e035"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDoXaNBjmn7WxcHYS1vvsHVrQ5qE_fleyI",
      appId: "com.example.homifyhaven",
      messagingSenderId: '',
      storageBucket: "homify-haven.appspot.com",
      projectId: "homify-haven",
    ));
  }

  await FirebaseAppCheck.instance.activate(
    webProvider:
        ReCaptchaV3Provider('6LeezAEqAAAAAH957nYjbCwQ_3F7cnGrLCwqWkqR'),
    androidProvider: AndroidProvider.debug,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LayoutScreen(),
          builder: EasyLoading.init(),
          routes: {
            AdminScreen.id: (context) => const AdminScreen(),
            WebMainScreen.id: (context) => const WebMainScreen(),
            DashboardScreen.id: (context) => const DashboardScreen(),
            AddProductScreen.id: (context) => const AddProductScreen(),
            UpdateProductScreen.id: (context) => const UpdateProductScreen(),
            DeleteProductScreen.id: (context) => const DeleteProductScreen(),
            // CartScreen.id: (context) => const CartScreen(),
          },
        );
      },
    );
  }
}
