import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:homify_haven/screens/login/mybutton.dart';
import 'package:homify_haven/screens/login/mytextfromfields.dart';
import 'package:homify_haven/menu_page.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController phoneRegisterController = TextEditingController();

  final GlobalKey<FormState> formLoginKey = GlobalKey();
  final GlobalKey<FormState> formRegisterKey = GlobalKey();

  bool isPasswordHidden = true;
  bool isPasswordHiddenNow = true;

  final AuthService _authService = AuthService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: height * 1,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      child: Image.network(
                        'https://hips.hearstapps.com/hmg-prod/images/green-living-rooms-michelle-1669649077.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 30,
            left: 30,
            top: 200,
            child: Card(
              elevation: 5,
              color: const Color.fromARGB(19, 51, 50, 50),
              child: Container(
                height: height * 0.585,
                width: width * 0.35,
                padding: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    Container(
                      width: width * 0.5,
                      height: height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.tealAccent,
                        unselectedLabelColor: Colors.white,
                        tabs: const [
                          Tab(
                            child: Text(
                              'Login',
                            ),
                          ),
                          Tab(
                            child: Text('Register'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    SizedBox(
                      width: double.maxFinite,
                      height: height * 0.5,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // ---------------- LOGIN ----------------------
                          Form(
                            key: formLoginKey,
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.035),
                                SingleChildScrollView(
                                    child: MyTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  labelTextt: 'Email',
                                  prefixIcon: Icons.mail,
                                  controller: emailLoginController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email Address is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                                SizedBox(height: height * 0.015),
                                MyPasswordTextField(
                                  controller: passwordLoginController,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forget Password?',
                                          style: TextStyle(
                                            color: Colors.tealAccent,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(height: 65),
                                MyButton(
                                  text: 'Login',
                                  onTap: () async {
                                    if (formLoginKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await _authService.login(
                                        emailLogin:
                                            emailLoginController.text.trim(),
                                        passwordLogin:
                                            passwordLoginController.text.trim(),
                                        context: context,
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => MainMenu(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an Account?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _tabController.animateTo(1);
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Or     Sign In With',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'images/google.png',
                                          height: height * 0.06,
                                          width: width * 0.50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // ------------------- REGISTER -------------------
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Form(
                              key: formRegisterKey,
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.009),
                                  MyTextField(
                                    keyboardType: TextInputType.name,
                                    labelTextt: 'Name',
                                    prefixIcon: Icons.person,
                                    controller: nameRegisterController,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? "Name is required"
                                            : null,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  MyTextField(
                                    keyboardType: TextInputType.number,
                                    labelTextt: 'Phone',
                                    prefixIcon: Icons.phone,
                                    controller: phoneRegisterController,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? "Phone is required"
                                            : null,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  MyTextField(
                                    keyboardType: TextInputType.emailAddress,
                                    labelTextt: 'Email',
                                    prefixIcon: Icons.mail,
                                    controller: emailRegisterController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email Address is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.01),
                                  MyPasswordTextField(
                                    controller: passwordRegisterController,
                                  ),
                                  SizedBox(height: height * 0.07),
                                  MyButton(
                                    text: 'Register',
                                    onTap: () async {
                                      //   if (formRegisterKey
                                      //       .currentState!
                                      //       .validate()) {
                                      //     setState(() {
                                      //       isLoading = true;
                                      //     });
                                      //     await _authService.register(
                                      //       emailRegister:
                                      //           emailRegisterController
                                      //               .text
                                      //               .trim(),
                                      //       passwordRegister:
                                      //           passwordRegisterController
                                      //               .text
                                      //               .trim(),
                                      //       context: context,
                                      //     );
                                      //     setState(() {
                                      //       isLoading = false;
                                      //     });
                                      //     if (FirebaseAuth.instance
                                      //             .currentUser !=
                                      //         null) {
                                      //       Navigator.of(context)
                                      //           .pushReplacement(
                                      //         MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               MainMenu(),
                                      //         ),
                                      //       );
                                      //     }

                                      //   }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Already have an Account!",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _tabController.animateTo(0);
                                        },
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
