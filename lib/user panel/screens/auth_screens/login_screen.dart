import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/controller/get_user_data_controller.dart';

import 'package:homify_haven/controller/google_signin_controller.dart';
import 'package:homify_haven/controller/register_controller.dart';

import 'package:homify_haven/widgets/login_button.dart';
import 'package:homify_haven/widgets/mytextfromfields.dart';
import 'package:homify_haven/user%20panel/bottom_nav_bar/bottom_page.dart';

import '../../../admin_panel/screens/admin_main.dart';
import '../../../controller/login_controller.dart';
import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  final SignUpController signUpController = Get.put(
    SignUpController(),
  );

  final SignInController signInController = Get.put(
    SignInController(),
  );

  final GetUserDataController getUserDataController = Get.put(
    GetUserDataController(),
  );

  //Login Controller
  TextEditingController userEmailLoginController = TextEditingController();
  TextEditingController userPasswordLoginController = TextEditingController();

  //Registeration Controller
  TextEditingController userEmailRegisterController = TextEditingController();
  TextEditingController userPasswordRegisterController =
      TextEditingController();
  TextEditingController userNameRegisterController = TextEditingController();
  TextEditingController userPhoneRegisterController = TextEditingController();
  TextEditingController userCityRegisterController = TextEditingController();

  final GlobalKey<FormState> formLoginKey = GlobalKey();
  final GlobalKey<FormState> formRegisterKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
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
            top: 130,
            child: Card(
              elevation: 5,
              color: const Color.fromARGB(19, 51, 50, 50),
              child: Container(
                height: height * 0.7,
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
                      width: width * 0.55,
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
                      height: height * 0.55,
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
                                  controller: userEmailLoginController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email Address is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                                SizedBox(height: height * 0.015),
                                Obx(
                                  () => MyPasswordTextField(
                                    controller: userPasswordLoginController,
                                    obscureText: signInController
                                        .isPasswordsVisible.value,
                                    onPress: () {
                                      signInController.isPasswordsVisible
                                          .toggle();
                                    },
                                    icon: signInController
                                            .isPasswordsVisible.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: TextButton(
                                        onPressed: () {
                                          Get.to(() => const ForgetPassword());
                                        },
                                        child: const Text(
                                          'Forget Password?',
                                          style: TextStyle(
                                            color: Colors.tealAccent,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(height: height * 0.100),
                                MyButton(
                                  text: 'Login',
                                  onTap: () async {
                                    String email =
                                        userEmailLoginController.text.trim();
                                    String password =
                                        userPasswordLoginController.text.trim();

                                    if (email.isEmpty || password.isEmpty) {
                                      Get.snackbar(
                                          'Error', "Please enter all details");
                                    } else {
                                      UserCredential? userCredential =
                                          await signInController.signInMethod(
                                              email, password);

                                      var userData = await getUserDataController
                                          .getUserData(
                                              userCredential!.user!.uid);

                                      // ignore: unnecessary_null_comparison
                                      if (userCredential != null) {
                                        if (userCredential
                                            .user!.emailVerified) {
                                          //
                                          if (userData[0]['isAdmin'] == true) {
                                            Get.offAll(
                                                () => const AdminScreen());
                                            Get.snackbar(
                                              'Success Admin Login',
                                              "Login Successful",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: const Color.fromARGB(
                                                  255, 113, 230, 133),
                                              colorText:
                                                  const Color(0xfff5f5f5),
                                            );
                                          } else {
                                            Get.offAll(
                                                () => const BottomPage());
                                            Get.snackbar(
                                              'Welcome',
                                              "Login Successful",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: const Color.fromARGB(
                                                  255, 181, 240, 211),
                                              colorText: Colors.black,
                                            );
                                          }
                                        } else {
                                          Get.snackbar('Error',
                                              "Please verify your email before login");
                                        }
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Please try again",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: const Color.fromARGB(
                                              255, 209, 32, 0),
                                          colorText: const Color(0xfff5f5f5),
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
                                    // Text(
                                    //   'Sign In With',
                                    //   style: TextStyle(color: Colors.white),
                                    // ),
                                    // SizedBox(
                                    //   width: width * 0.05,
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        _googleSignInController
                                            .signInWithGoogle();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          child: Image.asset(
                                            'images/google.png',
                                            height: height * 0.06,
                                            width: width * 0.50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    const Text(
                                      'or as a',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          // Get.to(() => HomePageScreen());
                                        },
                                        child: const Text(
                                          'Guest',
                                          style: TextStyle(
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.white,
                                          ),
                                        ))
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
                                    controller: userNameRegisterController,
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
                                    controller: userPhoneRegisterController,
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
                                    controller: userEmailRegisterController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email Address is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.01),
                                  MyTextField(
                                    keyboardType: TextInputType.name,
                                    labelTextt: 'City',
                                    prefixIcon: Icons.location_pin,
                                    controller: userCityRegisterController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'City is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Obx(
                                    () => MyPasswordTextField(
                                      controller:
                                          userPasswordRegisterController,
                                      obscureText: signUpController
                                          .isPasswordsVisible.value,
                                      onPress: () {
                                        signUpController.isPasswordsVisible
                                            .toggle();
                                      },
                                      icon: signUpController
                                              .isPasswordsVisible.value
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  MyButton(
                                    text: 'Register',
                                    onTap: () async {
                                      String name = userNameRegisterController
                                          .text
                                          .trim();
                                      String email = userEmailRegisterController
                                          .text
                                          .trim();
                                      String phone = userPhoneRegisterController
                                          .text
                                          .trim();
                                      String city = userCityRegisterController
                                          .text
                                          .trim();
                                      String password =
                                          userPasswordRegisterController.text
                                              .trim();

                                      String userDeviceToken = '';

                                      if (name.isEmpty ||
                                          email.isEmpty ||
                                          phone.isEmpty ||
                                          city.isEmpty ||
                                          password.isEmpty) {
                                        Get.snackbar(
                                          "Error",
                                          "Please enter all details",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: const Color.fromARGB(
                                              255, 214, 176, 62),
                                          colorText: const Color(0xfff5f5f5),
                                        );
                                      } else {
                                        UserCredential? userCredential =
                                            await signUpController.signUpMethod(
                                                name,
                                                phone,
                                                email,
                                                city,
                                                password,
                                                userDeviceToken);

                                        if (userCredential != null) {
                                          Get.snackbar(
                                            "Verfication email sent",
                                            "Please check your email",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 214, 176, 62),
                                            colorText: const Color(0xfff5f5f5),
                                          );

                                          FirebaseAuth.instance.signOut();
                                          Get.offAll(() => const LoginPage());
                                        }
                                      }
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
  }
}
