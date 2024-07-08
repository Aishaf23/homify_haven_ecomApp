import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';


// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({required this.text, required this.onTap, super.key});

  final String text;

  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: width * 0.3,
        decoration: const BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.tealAccent,
            ]),
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
