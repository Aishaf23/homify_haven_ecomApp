import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/widgets/homi_button.dart';

import '../../../model/cart_model.dart';
import '../../../model/products.dart';

import '../order/thankyou.dart';

class CheckOutScreen extends StatefulWidget {
  final double totalPrice;
  final List<Product> cartProducts;

  const CheckOutScreen({
    super.key,
    required this.totalPrice,
    required this.cartProducts,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

List<String> options = ['Home', 'Work'];

List<String> payments = ['JazzCash', 'EasyPaisa', 'COD'];

class _CheckOutScreenState extends State<CheckOutScreen> {
  String currentOption = options[0];

  String paymentCurrentOption = payments[0];

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = false;

  User? currentUser;

  String userName = '';
  String userPhoneNumber = '';
  String userAddress = '';
  String userCity = '';

  double shippingFee = 30.0; // Example shipping fee

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      DocumentSnapshot docSnapshot =
          await db.collection('profileInfo').doc(currentUser!.uid).get();

      if (docSnapshot.exists) {
        setState(() {
          userName = docSnapshot['name'];
          userPhoneNumber = docSnapshot['phone'];
          userAddress = docSnapshot['address'];
          userCity = docSnapshot['city'];
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
      // Handle error if necessary
    }
  }

  Future<void> placeOrder() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch cart items from the database
      QuerySnapshot querySnapshot = await db.collection('cart').get();
      List<CartModel> cartItems =
          querySnapshot.docs.map((doc) => CartModel.fromDocument(doc)).toList();

      if (cartItems.isNotEmpty) {
        // Prepare the order data
        Map<String, dynamic> orderData = {
          'name': userName,
          'mobile_number': userPhoneNumber,
          'address': userAddress,
          'city': userCity,
          'email': currentUser!.email,
          'user_id': currentUser!.uid,
          'status': 'Pending',
          'time': DateTime.now(),
          'items': cartItems.map((item) => item.toMap()).toList(),
          'totalPrice': widget.totalPrice + shippingFee, // Include shipping fee
        };

        // Place the order
        await db.collection('orders').add(orderData);

        // Clear the cart after placing the order
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        // Show success message and navigate to ThankYouScreen
        Get.snackbar(
          'Order Placed Successfully',
          'View Order',
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade600,
          colorText: const Color(0xfff5f5f5),
        );
        Get.offAll(() => const ThankYouScreen());
      } else {
        // No items in the cart
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No items in the cart')),
        );
      }
    } catch (e) {
      // Handle errors
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to place order. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double subtotal = widget.totalPrice;
    double total = subtotal + shippingFee;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Check Out'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'Orders:',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 80,
                    //   width: double.infinity,
                    //   child: Card(
                    //     child: Center(
                    //       child: ListTile(
                    //         leading: ClipRRect(
                    //           borderRadius:
                    //               const BorderRadius.all(Radius.circular(12)),
                    //           child:
                    //               Image.asset('images/sofas/alseda_blue_2.jpg'),
                    //         ),
                    //         title: const Text(
                    //           'GLOTSTAD',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         trailing: const Text(
                    //           '\$ 200.00',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 15,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: height * 0.015,
                    ),
                    const Text(
                      'Shipping To:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    SizedBox(
                      height: height * 0.167,
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: userName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: 'Contact: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: userPhoneNumber,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: 'Address: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: userAddress,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: 'City: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: userCity,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0025,
                    ),
                    ListTile(
                      leading: ClipRRect(
                        child: Image.asset(
                          'images/logos/jazz_cash_logo.png',
                          height: height * 0.65,
                          width: width * 0.11,
                        ),
                      ),
                      title: const Text(
                        'JazzCash',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: Radio(
                        groupValue: paymentCurrentOption,
                        value: payments[0],
                        activeColor: const Color.fromARGB(255, 36, 218, 175),
                        onChanged: (value) {
                          setState(() {
                            paymentCurrentOption = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: ClipRRect(
                        child: Image.asset(
                          'images/logos/easypaisa.png',
                          height: height * 0.65,
                          width: width * 0.11,
                        ),
                      ),
                      title: const Text(
                        'EasyPaisa',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: Radio(
                        groupValue: paymentCurrentOption,
                        value: payments[1],
                        activeColor: const Color.fromARGB(255, 36, 218, 175),
                        onChanged: (value) {
                          setState(() {
                            paymentCurrentOption = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money_outlined),
                      title: const Text(
                        'Cash on Delivery',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: Radio(
                        groupValue: paymentCurrentOption,
                        value: payments[2],
                        activeColor: const Color.fromARGB(255, 36, 218, 175),
                        onChanged: (value) {
                          setState(() {
                            paymentCurrentOption = value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping Fee:',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          '\$ ${shippingFee.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total:',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          '\$ ${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$ ${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    HomifyButton(
                      title: "Payment",
                      isLoginButton: true,
                      isLoading: isLoading,
                      onPress: placeOrder,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
