import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/user%20panel/screens/auth_screens/login_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/screens/privacy_policy_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/screens/profile_screen.dart';

import '../../../controller/sign_out_controller.dart';
import 'screens/contact_us.dart';
import 'screens/feedback.dart';
import 'screens/invite_friends.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEditingProfile = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignOutController signOutController = Get.put(SignOutController());

  String? profilePicUrl;
  User? user = FirebaseAuth.instance.currentUser;
  String? time;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _fetchUserProfileTime();
  }

  Future<void> _fetchUserProfile() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('profileInfo').doc(user.uid).get();

      if (docSnapshot.exists) {
        setState(() {
          profilePicUrl = docSnapshot['profilePic'];
        });
      }
    }
  }


  Future<void> _fetchUserProfileTime() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (docSnapshot.exists) {
        Timestamp? createdOn = docSnapshot['createdOn'];
        if (createdOn != null) {
          // Convert timestamp to DateTime
          DateTime dateTime = createdOn.toDate();

          // Format DateTime as a readable string (e.g., "MM.dd.yyyy")
          String formattedDate =
              '${dateTime.month}.${dateTime.day}.${dateTime.year}';

          setState(() {
            time = formattedDate;
          });
        }
      }
    }
  }

  Future<void> deleteUserProfile() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Delete user data from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete user authentication record
        await user.delete();

        // Show success message and redirect to login page
        Get.snackbar('Success', 'Profile deleted successfully');
        Get.offAll(() => const LoginPage());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: profilePicUrl != null
                      ? NetworkImage(profilePicUrl!)
                      : const AssetImage('images/default_avatar.png')
                          as ImageProvider,
                  backgroundColor: const Color.fromARGB(255, 181, 240, 211),
                ),
                title: Text(user!.displayName!),
                subtitle: Text('Member since $time'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const ProfileScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(width * 0.080, height * 0.060)),
                  child: const Text(
                    'Edit \nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.tealAccent,
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
                onTap: () {
                  Get.to(() => const InviteFriendsScreen());
                },
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
                onTap: () {
                  Get.to(() => const FeedbackScreen());
                },
                leading: Icon(
                  Icons.reviews_outlined,
                  size: width * 0.055,
                ),
                title: const Text('Feedback'),
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
                onTap: () {
                  Get.to(() => const ContactUsScreen());
                },
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
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
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
                                  Get.back();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await deleteUserProfile();
                                },
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
                              onPressed: () {
                                signOutController.signOut().then((_) {
                                  Get.offAll(() => const LoginPage());
                                }).catchError((error) {
                                  Get.snackbar(
                                      'Error', 'Failed to log out: $error');
                                });
                              },
                              child: const Text(
                                'YES',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      );
                    },
                  );
                
                },
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 0.01,
                            left: width * 0.01,
                            right: width * 0.01),
                        child: const Text(
                          'Our home is your haven!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
