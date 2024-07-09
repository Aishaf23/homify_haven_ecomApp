import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/user%20panel/screens/cart/check_out_screen.dart';
import 'package:homify_haven/user%20panel/screens/settings/screens/profile_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../model/products.dart';
import '../../../widgets/homi_button.dart';

import '../../../widgets/header.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  List<Product> allProducts = [];

  CollectionReference db = FirebaseFirestore.instance.collection('cart');

  delete(String id, BuildContext context) {
    db
        .doc(id)
        .delete()
        .then((value) => Get.snackbar('Item Deleted Successfully', "",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade400,
            colorText: const Color(0xfff5f5f5),
            duration: const Duration(seconds: 2),
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            )));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: Header(
              title: "CART ITEMS",
            )),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // Calculate total price
            // double totalPrice = 0;
            // snapshot.data!.docs.forEach((doc) {
            //   totalPrice += doc['price'] * doc['quantity'];
            // });

            double calculateTotalPrice() {
              double totalPrice = 0;
              // ignore: avoid_function_literals_in_foreach_calls
              snapshot.data!.docs.forEach((doc) {
                totalPrice += doc['price'] * doc['quantity'];
              });
              return totalPrice;
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Image.asset('images/emptycart.png'),
                    const Text(
                      'Add Items to Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }

            // ignore: avoid_unnecessary_containers
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final res = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 3,
                                      spreadRadius: 3,
                                      offset: const Offset(3, 3)),
                                ]),
                            child: Row(
                              children: [
                                Image.network(
                                  res['image'],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${res['productName']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Text("Qty: "),
                                                Container(
                                                    color: Colors.black,
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 30,
                                                            minHeight: 20,
                                                            maxWidth: 30,
                                                            maxHeight: 20),
                                                    child: Text(
                                                      "${res['quantity']}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Price: "),
                                            Text(
                                              "\$${res['price']}",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    delete(res.id, context);
                                    if (kDebugMode) {
                                      print(
                                          'User has removed an item from cart');
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.remove,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.grey.shade300),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${calculateTotalPrice()}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                height: 65,
                                width: 250,
                                child: HomifyButton(
                                  title: "Proceed to Checkout",
                                  isLoginButton: true,
                                  isLoading: false,
                                  onPress: () {
                                    // Check if the user profile is complete (e.g., displayName is not null)
                                    if (FirebaseAuth.instance.currentUser
                                                ?.displayName ==
                                            null ||
                                        FirebaseAuth.instance.currentUser!
                                            .displayName!.isEmpty) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //     content: Text(
                                      //       'Please Complete Profile First',
                                      //     ),
                                      //   ),
                                      // );
                                      Get.to(() => const ProfileScreen());
                                    } else {
                                      Get.to(() => CheckOutScreen(
                                            cartProducts:
                                                allProducts, // Pass your list of cart products here
                                            totalPrice: calculateTotalPrice(),
                                          ));
                                    }
                                  },
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
          },
        ));
  }
}
