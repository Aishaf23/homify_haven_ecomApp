import 'package:flutter/material.dart';
import 'package:homify_haven/admin_panel/screens/admin_main.dart';
import 'package:homify_haven/splash_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 600) {
        return const AdminScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
