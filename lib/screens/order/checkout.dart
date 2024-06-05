import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/screens/order/order_confirmation.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key, required double totalPrice});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final cities = [
    'Multan',
    'Lahore',
    'Islamabad',
    'Karachi',
    'Pindi Gheb',
    'Kohat'
  ];

  String? selectedCity;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emailController.text = currentUser.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CheckOut',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(228, 9, 241, 187),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.016,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: mobileController,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? "Please enter mobile number"
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                    labelText: 'Mobile Number',
                    labelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(228, 9, 241, 187),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.phone_android)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.016,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    } else {
                      if (value.contains("@") && value.contains(".")) {
                        return null;
                      } else {
                        return "Please enter valid email address";
                      }
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    labelText: 'Email Address',
                    labelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(228, 9, 241, 187),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.email)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.016,
                ),
                DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? "Please select city" : null,
                    hint: const Text('Select City'),
                    decoration: InputDecoration(
                      icon: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(228, 9, 241, 187),
                              Colors.white,
                            ],
                          ),
                        ),
                        child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.location_pin)),
                      ),
                      labelText: 'Location',
                      labelStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    elevation: 4,
                    isExpanded: true,
                    value: selectedCity,
                    items: cities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        // if (value != null) {
                        selectedCity = value;
                        // }
                      });
                    }),
                SizedBox(
                  height: height * 0.016,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: addressController,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? "Please enter address for order"
                      : null,
                  decoration: InputDecoration(
                    hintText: 'House No./Building No., Street, Area',
                    labelText: 'Address',
                    labelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(228, 9, 241, 187),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.location_city)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.060,
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          String name = nameController.text.trim();
                          String mobile = mobileController.text.trim();
                          String email = emailController.text.trim();
                          String address = addressController.text.trim();

                          //   setState(() {
                          //     isLoading = true;
                          //   });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OrderConfirmation(
                                name: name,
                                mobile: mobile,
                                email: email,
                                city: selectedCity!,
                                address: address);
                          }));
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return OrderConfirmation();
                        // }));
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: Colors.tealAccent),
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            'Place to Order',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.tealAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
