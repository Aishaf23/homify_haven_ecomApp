import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/menu_bottom_bar/profile/pick_image_widget.dart';
import 'package:homify_haven/services/my_app_methods.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  XFile? _pickedImage;

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();

    await MyAppMethods.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);

          setState(() {});
        },
        removeFCT: () {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 20,
                        )),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  content: const Text(
                                      'Do you want to save changes?'),
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
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Changes Saved')));
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
                        icon: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 22,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: CircleAvatar(
                //     radius: 60,
                //     child: Icon(Icons.person),
                //     backgroundColor: Colors.lightGreenAccent,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ImagePickerWidget(
                        pickedImage:
                            _pickedImage, // Provide a default non-null XFile or handle appropriately
                        function: () async {
                          await localImagePicker();
                        },
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Your Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  text: 'First Name',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                ),
                MyTextField(
                  text: 'Last Name',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                ),
                MyTextField(
                  text: 'Mobile no',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                ),
                MyTextField(
                  text: 'Email Address',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.textInputAction,
      required this.keyboardType,
      required this.text});

  String text;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            label: Text(text),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
