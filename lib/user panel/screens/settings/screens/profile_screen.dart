import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homify_haven/widgets/homi_button.dart';
import 'package:homify_haven/widgets/homi_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? profilePic;
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool selection = false;
  bool isSaving = false;

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete profile firstly')),
        );
      } else {
        FirebaseFirestore.instance
            .collection('profileInfo')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snapshot) {
          if (snapshot.exists) {
            nameC.text = snapshot['name'];
            phoneC.text = snapshot['phone'];
            emailC.text = snapshot['email'];
            houseC.text = snapshot['house'];
            cityC.text = snapshot['city'];
            streetC.text = snapshot['street'];
            addressC.text = snapshot['address'];
            profilePic = snapshot['profilePic'];
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                      const SizedBox(
                        width: 100,
                      ),
                      const Text(
                        "PROFILE",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        if (pickImage != null) {
                          setState(() {
                            profilePic = pickImage.path;
                            selection = true;
                          });
                        }
                      },
                      child: Container(
                        child: profilePic == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.deepPurple,
                                child: Image.asset(
                                  'images/c_images/add_pic.png',
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : profilePic!.contains('http')
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(profilePic!),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        FileImage(File(profilePic!)),
                                  ),
                      ),
                    ),
                  ),
                  HomifyTextField(
                    hintText: "Enter Complete Name",
                    controller: nameC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter Phone Number",
                    controller: phoneC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter Email",
                    controller: emailC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter House no",
                    controller: houseC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter Street",
                    controller: streetC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter City",
                    controller: cityC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyTextField(
                    hintText: "Enter Complete Address",
                    controller: addressC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Should not be empty";
                      }
                      return null;
                    },
                  ),
                  HomifyButton(
                    title: nameC.text.isEmpty ? 'SAVE' : 'Update',
                    isLoginButton: true,
                    isLoading: isSaving,
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMapMethod(
                            'TextInput.hide'); // hides keyboard
                        profilePic == null
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Select profile pic')))
                            : /*nameC.text.isEmpty
                                ?*/
                            saveInfo();
                        // : update();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? downloadUrl;
  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // update() {
  //   setState(() {
  //     isSaving = true;
  //   });
  //   if (selection == true) {
  //     uploadImage(File(profilePic!), 'profile').whenComplete(() {
  //       Map<String, dynamic> data = {
  //         'userId': currentUser!.uid,
  //         'name': nameC.text,
  //         'phone': phoneC.text,
  //         'email': emailC.text,
  //         'house': houseC.text,
  //         'street': streetC.text,
  //         'city': cityC.text,
  //         'address': addressC.text,
  //         'profilePic': downloadUrl,
  //       };
  //       FirebaseFirestore.instance
  //           .collection('profileInfo')
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .update(data)
  //           .whenComplete(() {
  //         FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
  //         setState(() {
  //           isSaving = false;
  //         });
  //       }).catchError((error) {
  //         // Handle error if document doesn't exist
  //         FirebaseFirestore.instance
  //             .collection('profileInfo')
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .set(data)
  //             .whenComplete(() {
  //           FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
  //           setState(() {
  //             isSaving = false;
  //           });
  //         });
  //       });
  //     });
  //   } else {
  //     Map<String, dynamic> data = {
  //       'userId': currentUser!.uid,
  //       'name': nameC.text,
  //       'phone': phoneC.text,
  //       'email': emailC.text,
  //       'house': houseC.text,
  //       'street': streetC.text,
  //       'city': cityC.text,
  //       'address': addressC.text,
  //       'profilePic': profilePic,
  //     };
  //     FirebaseFirestore.instance
  //         .collection('profileInfo')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update(data)
  //         .whenComplete(() {
  //       FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Profile Updated')));
  //       print('Profile Updated');

  //       setState(() {
  //         isSaving = false;
  //       });
  //     }).catchError((error) {
  //       // Handle error if document doesn't exist
  //       FirebaseFirestore.instance
  //           .collection('profileInfo')
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .set(data)
  //           .whenComplete(() {
  //         FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(content: Text('Profile Updated')));
  //         print('Profile Updated');

  //         setState(() {
  //           isSaving = false;
  //         });
  //       });
  //     });
  //   }
  // }

  saveInfo() {
    setState(() {
      isSaving = true;
    });
    if (selection == true) {
      uploadImage(File(profilePic!), 'profile').whenComplete(() {
        Map<String, dynamic> data = {
          'userId': currentUser!.uid,
          'name': nameC.text,
          'phone': phoneC.text,
          'email': emailC.text,
          'house': houseC.text,
          'street': streetC.text,
          'city': cityC.text,
          'address': addressC.text,
          'profilePic': downloadUrl,
        };
        FirebaseFirestore.instance
            .collection('profileInfo')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(data)
            .whenComplete(() {
          FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile Information Saved')));
          if (kDebugMode) {
            print('Profile Information Saved');
          }
          setState(() {
            isSaving = false;
          });
        });
      });
    } else {
      Map<String, dynamic> data = {
        'userId': currentUser!.uid,
        'name': nameC.text,
        'phone': phoneC.text,
        'email': emailC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': profilePic,
      };
      FirebaseFirestore.instance
          .collection('profileInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Information Saved')));
        if (kDebugMode) {
          print('Profile Information Saved');
        }
        setState(() {
          isSaving = false;
        });
      });
    }
  }
}
