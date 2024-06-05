import 'package:flutter/material.dart';
import 'package:homify_haven/screens/login/auth.dart';
import 'package:homify_haven/screens/feedback.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEditingProfile = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 181, 240, 211),
                  child: Icon(Icons.person),
                ),
                title: const Text('User'),
                subtitle: const Text('Member since 4.3.24'),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              content: Container(
                                height: height * 0.45,
                                width: double.maxFinite,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Color.fromARGB(255, 40, 225, 235),
                                      child: Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        hintText: 'Name',
                                      ),
                                    ),
                                    SizedBox(height: height * 0.015),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        hintText: 'Email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color:
                                              Color.fromARGB(255, 40, 225, 235),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(221, 65, 62, 62),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Color.fromARGB(255, 181, 240, 211),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              Divider(
                indent: width * 0.035,
                endIndent: width * 0.035,
              ),
              SizedBox(
                height: height * 0.016,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Spread the word',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_2_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Invite Friends'),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: width * 0.045,
                ),
              ),
              SizedBox(
                height: height * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.reviews_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const FeedBack();
                  }));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: width * 0.045,
                ),
              ),
              Divider(
                indent: width * 0.035,
                endIndent: width * 0.035,
              ),
              ListTile(
                leading: Icon(
                  Icons.call_made_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Contact Us'),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: width * 0.045,
                ),
              ),
              SizedBox(
                height: height * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Legal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.security_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Privacy Policy'),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: width * 0.045,
                ),
              ),
              SizedBox(
                height: height * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Privacy and Sharing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_forever_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Delete Profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: width * 0.045,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            'Delete Profile',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          content:
                              const Text('Do you want to delete your profile?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                            TextButton(
                                onPressed: () =>
                                    _authService.userDelete(context),
                                child: const Text(
                                  'YES',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                          ],
                        );
                      });
                },
              ),
              Divider(
                indent: width * 0.035,
                endIndent: width * 0.035,
              ),
              TextButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            content: const Text('Do you want to logout?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () =>
                                      _authService.userSignOut(context),
                                  child: const Text(
                                    'YES',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  )),
                            ],
                          );
                        });
                  },
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                    ),
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      child: Image.asset(
                        'images/logos/homify_logo.png',
                        height: height * 0.2,
                        width: width * 0.3,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 25,
                    left: 25,
                    top: 125,
                    child: Center(
                      child: Text('Version 1.0.0.1'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
