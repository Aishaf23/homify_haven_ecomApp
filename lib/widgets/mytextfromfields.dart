import 'package:flutter/material.dart';

class MyPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPress;
  final Icon icon;
  final bool obscureText;

  const MyPasswordTextField(
      {super.key,
      required this.controller,
      required this.onPress,
      required this.obscureText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width * 0.75,
      margin: const EdgeInsets.only(left: 10),
      child: Center(
        child: TextFormField(
          controller: controller,
          validator: (value) =>
              value == null || value.isEmpty ? "Password is required" : null,
          textInputAction: TextInputAction.done,
          obscureText: obscureText,
          cursorColor: Colors.tealAccent,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.tealAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.password,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: icon,
                color: Colors.white,
                onPressed: onPress,
              )),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    required this.labelTextt,
    required this.controller,
    this.validator,
    required this.prefixIcon,
    required this.keyboardType,
    super.key,
  });

  final TextEditingController controller;
  String? Function(String?)? validator;

  final String labelTextt;
  final IconData prefixIcon;

  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      // height: validator != null && validator!(controller.text) != null
      //     ? height * 0.065
      //     : height * 0.065,
      width: width * 0.75,
      margin: const EdgeInsets.only(left: 10),
      child: Center(
        child: TextFormField(
          controller: controller,
          validator: validator,
          cursorColor: Colors.tealAccent,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.red,
            //   ),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(100),
            //   ),
            //   gapPadding: height * 0.1,
            // ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.tealAccent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            labelText: labelTextt,
            labelStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
