import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/menu_page.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ThankYouScreen extends StatefulWidget {
  final String name;
  final String mobile;
  final String email;
  final String city;
  final String address;

  const ThankYouScreen(
      {required this.name,
      required this.mobile,
      required this.email,
      required this.city,
      required this.address,
      super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
 
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: width * 0.25,
                color: Colors.green,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Your order will be delievered in 3 to 5 working days to city ${widget.city} at the address "${widget.address}"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().clearCart();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.tealAccent,
                ),
                child: const Text(
                  'Go to Main Page',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
