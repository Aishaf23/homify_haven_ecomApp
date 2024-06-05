import 'package:flutter/material.dart';

class MyPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  MyPasswordTextField({
    required this.controller,
    super.key,
  });

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool isPasswordHiddenNow = true;

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
          controller: widget.controller,
          validator: (value) =>
              value == null || value.isEmpty ? "Password is required" : null,
          textInputAction: TextInputAction.done,
          obscureText: isPasswordHiddenNow,
          cursorColor: Colors.tealAccent,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.tealAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordHiddenNow
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordHiddenNow = !isPasswordHiddenNow;
                  });
                },
              )),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.labelTextt,
    required this.controller,
    this.validator,
    required this.prefixIcon,
    required this.keyboardType,
    super.key,
  }   );

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
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
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
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.tealAccent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            labelText: labelTextt,
            labelStyle: TextStyle(color: Colors.white),
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
