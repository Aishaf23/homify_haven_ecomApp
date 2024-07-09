import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:homify_haven/admin_panel/screens/inner_screens/category_screen.dart';
import 'package:homify_haven/admin_panel/screens/inner_screens/order_screen.dart';
import 'package:homify_haven/admin_panel/screens/inner_screens/product_screenn.dart';
import 'package:sizer/sizer.dart';
import '../../../model/category_model.dart';
import '../inner_screens/user_screen.dart';
import '../../../services/user_services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  static const String id = "dashboard";

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<int> _userCountFuture;
  late Future<int> _productCountFuture;
  late Future<int> _orderCountFuture;
  int _categoryCount = 0;

  Future<int> fetchProductCount() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('items').get();
    return snapshot.size;
  }

  Future<int> fetchOrderCount() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('orders').get();
    return snapshot.size;
  }

  @override
  void initState() {
    super.initState();
    _userCountFuture = UserService().fetchUsers().then((users) => users.length);
    _productCountFuture = fetchProductCount();
    _orderCountFuture = fetchOrderCount();
    _categoryCount = categories.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "DASHBOARD",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<int>(
                future: _userCountFuture,
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasError) {
                    return Center(child: Text('Error: ${userSnapshot.error}'));
                  } else if (!userSnapshot.hasData) {
                    return const Center(child: Text('No users found'));
                  }

                  int userCount = userSnapshot.data!;

                  return FutureBuilder<int>(
                    future: _productCountFuture,
                    builder: (context, productSnapshot) {
                      if (productSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (productSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${productSnapshot.error}'));
                      } else if (!productSnapshot.hasData) {
                        return const Center(child: Text('No products found'));
                      }

                      int productCount = productSnapshot.data!;

                      return FutureBuilder<int>(
                        future: _orderCountFuture,
                        builder: (context, orderSnapshot) {
                          if (orderSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (orderSnapshot.hasError) {
                            return Center(
                                child: Text('Error: ${orderSnapshot.error}'));
                          } else if (!orderSnapshot.hasData) {
                            return const Center(child: Text('No orders found'));
                          }

                          int orderCount = orderSnapshot.data!;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return DashboardCard(
                                title: index == 0
                                    ? 'Users'
                                    : index == 1
                                        ? 'Orders'
                                        : index == 2
                                            ? 'Products'
                                            : 'Categories',
                                count: index == 0
                                    ? '$userCount'
                                    : index == 1
                                        ? '$orderCount'
                                        : index == 2
                                            ? '$productCount'
                                            : '$_categoryCount',
                                onTap: () {
                                  if (index == 0) {
                                    Get.to(() => const UserListScreen());
                                  }
                                  if (index == 1) {
                                    Get.to(() => const OrderListScreen());
                                  }
                                  if (index == 2) {
                                    Get.to(() => const ProductListScreen());
                                  }
                                  if (index == 3) {
                                    Get.to(() => const CategoryListScreen());
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String count;
  final VoidCallback onTap;

  const DashboardCard(
      {super.key,
      required this.title,
      required this.count,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
