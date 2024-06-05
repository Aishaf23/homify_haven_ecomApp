import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/provider/wishlist_provider.dart';
import 'package:homify_haven/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions options = const FirebaseOptions(
    apiKey: "AIzaSyDoXaNBjmn7WxcHYS1vvsHVrQ5qE_fleyI",
    appId: "com.example.homify_haven",
    messagingSenderId: '',
    projectId: "homify-haven",
  );

  await Firebase.initializeApp(
    options: options,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: GetMaterialApp(
        // theme: ThemeData(
        //   primarySwatch: Colors.teal,
        //   primaryColor: Colors.tealAccent,
        // ),
        home: SplashScreen(),
      ),
    );
  }
}
