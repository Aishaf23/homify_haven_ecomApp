import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/models/category_model.dart';
import 'package:homify_haven/models/firestore_collection.dart';

import 'package:homify_haven/models/furnitures_model.dart';
import 'package:homify_haven/screens/order/address/add_address.dart';
import 'package:homify_haven/screens/order/thankyou.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/utils/rounded_button.dart';
import 'package:provider/provider.dart';

class OrderConfirmation extends StatefulWidget {
  final String name;
  final String mobile;
  final String email;
  final String city;
  final String address;
  const OrderConfirmation(
      {required this.name,
      required this.mobile,
      required this.email,
      required this.city,
      required this.address,
      super.key});

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

List<String> options = ['Home', 'Work'];

List<String> payments = ['JazzCash', 'EasyPaisa', 'COD', 'NayaPay', 'SadaPay'];

class _OrderConfirmationState extends State<OrderConfirmation> {
  String currentOption = options[0];

  String paymentCurrentOption = payments[0];

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = false;

  User? currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  // Function to add category to Firestore
  // Future<String> addCategoryToFirestore(Category category) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference categoriesCollection =
  //       firestore.collection('categories');

  //   DocumentReference docRef =
  //       categoriesCollection.doc(); // Automatically generates an ID

  //   await docRef.set(category.toMap());

  //   return docRef.id; // Return the generated ID
  // }

  // Future<void> addProductsToFirestore(
  //     List<Map<String, dynamic>> furnitures) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   for (var furniture in furnitures) {
  //     await firestore
  //         .collection('products')
  //         .add(furniture)
  //         .then((docRef) async {
  //       print("Product added with ID: ${docRef.id}");
  //       // After adding the product, add the categories
  //       List<Category> categories = [];
  //       for (var categoryData in furniture['title']) {
  //         Category category = Category(
  //           id: '',
  //           name: categoryData['name'].toString(),
  //           imageUrl:
  //               categoryData['imageUrl'][0].toString(), // Example image URL
  //         );
  //         String categoryId = await addCategoryToFirestore(category);
  //         category.id = categoryId;
  //         categories.add(category);
  //         print("Category added with ID: ${category.id.toString()}");
  //       }
  //       // Now you can use the 'categories' list as needed
  //     }).catchError((error) {
  //       print("Error adding product: $error");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
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
                    const Text(
                      'Orders:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child:
                                Image.asset('images/sofas/kivik_pink_1.jpg')),
                        title: Text(
                          'Kivik',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('LoveSeat for Two'),
                        trailing: Text(
                          '\$ 300.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
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
                    ListTile(
                      leading: Radio(
                        groupValue: currentOption,
                        value: options[0],
                        activeColor: const Color.fromARGB(255, 36, 218, 175),
                        onChanged: (value) {
                          setState(() {
                            currentOption = value.toString();
                          });
                        },
                      ),
                      title: Text(
                        widget.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.address,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.city,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Contact:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.mobile,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      leading: Radio(
                        groupValue: currentOption,
                        value: options[1],
                        activeColor: const Color.fromARGB(255, 36, 218, 175),
                        onChanged: (value) {
                          setState(() {
                            currentOption = value.toString();
                          });
                        },
                      ),
                      title: const Text(
                        'Work',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                          'MaxCore Technologies \nSabzazar \nMULTAN'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: height * 0.005,
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
                    SizedBox(
                      height: height * 0.002,
                    ),
                    ListTile(
                      leading: ClipRRect(
                        child: Image.asset(
                          'images/logos/easypaisa.png',
                          height: height * 0.65,
                          width: width * 0.11,
                          // color: Colors.transparent,
                        ),
                      ),
                      title: const Text(
                        'Easypaisa',
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
                    SizedBox(
                      height: height * 0.002,
                    ),
                    ListTile(
                      leading: ClipRRect(
                        child: Image.asset(
                          'images/logos/cod.png',
                          height: height * 0.65,
                          width: width * 0.11,
                          // color: Colors.transparent,
                        ),
                      ),
                      title: const Text(
                        'Cash On Delivery (COD)',
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
                      height: height * 0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping Fee:',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          '\$ 30',
                          style: TextStyle(color: Colors.grey.shade700),
                        )
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
                          '\$ 730.00',
                          style: TextStyle(color: Colors.grey.shade700),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ 760.00',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RoundedButton(
                            text: 'Payment',
                            onTap: () {
                              // addCategoryToFirestore(category);
                              addProductsToFirestore(furnitures);
                            },
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  navigateToAddress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddressAdd();
    }));
  }

  navigateToThankYouScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ThankYouScreen(
          name: widget.name,
          mobile: widget.mobile,
          email: widget.email,
          city: widget.city,
          address: widget.address);
    }));
  }

  addToCart() {
    setState(() {
      isLoading = true;
    });

    if (currentUser == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Unable to get user info')));
      return;
    }

    db.collection('orders').add({
      'name': widget.name,
      'mobile_number': widget.mobile,
      'address': widget.address,
      'email': widget.email,
      'city': widget.city,
      'time': DateTime.now().millisecondsSinceEpoch,
      'items': context.read<CartProvider>().cartList,
    }).then((value) {
      setState(() {
        isLoading = false;
      });

      context.read<CartProvider>().clearCart();

      navigateToThankYouScreen();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order Placed Successfully')));
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
      print(error);
    });
  }
}
