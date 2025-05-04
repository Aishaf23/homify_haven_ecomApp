import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/services/firebase_services.dart';
import 'package:homify_haven/admin_panel/screens/main/web_main.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/snackbar_widget.dart';

class AdminScreen extends StatefulWidget {
  static const String id = "adminMain";

  const AdminScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool formStateLoading = false;

  final formKey = GlobalKey<FormState>();
  submit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });

      try {
        final value =
            await FirebaseServices.adminSignIn(usernameController.text);
        if (value['username'] == usernameController.text &&
            value['password'] == passwordController.text) {
          // Sign in the admin anonymously
          UserCredential user = await FirebaseAuth.instance.signInAnonymously();
          // ignore: unnecessary_null_comparison
          if (user != null) {
            SnackbarService.showSuccess(
                context, "Admin signed in successfully");

            // Navigate to the admin panel or dashboard
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, WebMainScreen.id);
          }
        } else {
          SnackbarService.showError(context, "Invalid username or password");

          setState(() {
            formStateLoading = false;
          });
        }
      } catch (error) {
        SnackbarService.showError(context, "Error signing in: $error");
      } finally {
        setState(() {
          formStateLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Login to continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Address is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.mail),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          icon: isPasswordHidden
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: formStateLoading ? null : submit,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(150, 55)),
                      child: formStateLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.tealAccent,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
