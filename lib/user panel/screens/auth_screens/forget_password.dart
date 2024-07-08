import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:homify_haven/controller/forgetpassword_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordController forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );

  //Login Controller
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.6, // Adjust height as needed
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.network(
                      'https://hips.hearstapps.com/hmg-prod/images/green-living-rooms-michelle-1669649077.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.06),
                      TextFormField(
                        controller: userEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Address is required';
                          } else {
                            return null;
                          }
                        },
                        cursorColor: Colors.tealAccent,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.090),
                      InkWell(
                        onTap: () async {
                          String email = userEmail.text.trim();

                          if (email.isEmpty) {
                            Get.snackbar(
                              'Error',
                              "Please enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color.fromARGB(255, 209, 32, 0),
                              colorText: const Color(0xfff5f5f5),
                            );
                          } else {
                            String email = userEmail.text.trim();
                            forgetPasswordController
                                .forgetPasswordMethod(email);
                          }
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            border: GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                Colors.tealAccent,
                                Colors.tealAccent,
                              ]),
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: const Center(
                            child: Text(
                              'Forget',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.tealAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
