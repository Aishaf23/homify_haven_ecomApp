import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class OrderListScreen extends StatelessWidget {
  OrderListScreen({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Order List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Use Sizer for font size
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          iconSize: 20, // Use Sizer for icon size
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 1.h, // Use Sizer for padding
              horizontal: 0.5.w, // Use Sizer for padding
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        );
                      }

                      if (snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No orders found',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        );
                      }

                      int totalOrders = snapshot.data!.docs.length;

                      return Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Total Orders',
                                    style: TextStyle(
                                      fontSize: 26, // Use Sizer for font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h, // Use Sizer for spacing
                                  ),
                                  Text(
                                    '$totalOrders',
                                    style: const TextStyle(
                                      fontSize: 33, // Use Sizer for font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h, // Use Sizer for spacing
                          ),
                          Scrollbar(
                            thumbVisibility: true,
                            thickness: 5,
                            controller: controller,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: controller,
                              child: DataTable(
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.08);
                                  } else {
                                    return Colors
                                        .black; // Use black color as the default.
                                  }
                                }),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Order ID',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Username',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  // DataColumn(
                                  //   label: Text(
                                  //     'Item Name',
                                  //     style: TextStyle(
                                  //       fontStyle: FontStyle.italic,
                                  //       color: Colors.blue,
                                  //       fontSize: 18,
                                  //     ),
                                  //   ),
                                  // ),
                                  DataColumn(
                                    label: Text(
                                      'Price',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Image',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Status',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: snapshot.data!.docs.map((order) {
                                  var orderId = order.id;
                                  var items = order['items'] as List<dynamic>;

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(orderId,
                                          style:
                                              const TextStyle(fontSize: 18))),
                                      DataCell(Text(order['name'],
                                          style:
                                              const TextStyle(fontSize: 18))),
                                      DataCell(Text(order['email'],
                                          style:
                                              const TextStyle(fontSize: 18))),
                                      // DataCell(
                                      //   Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: items.map((item) {
                                      //       return Expanded(
                                      //         child: Center(
                                      //           child: Text(
                                      //               item['productName']
                                      //                   as String,
                                      //               style: const TextStyle(
                                      //                   fontSize: 18)),
                                      //         ),
                                      //       );
                                      //     }).toList(),
                                      //   ),
                                      // ),

                                      DataCell(
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      '${order['totalPrice']} \$',
                                                      style: const TextStyle(
                                                          fontSize: 18)),
                                                ),
                                              )
                                              // }).toList(),
                                            ]),
                                      ),
                                      DataCell(
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: items.map((item) {
                                            return Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  item['image'] as String,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      DataCell(
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: items.map((item) {
                                            return Expanded(
                                              child: Center(
                                                child: Text(
                                                    '${item['quantity']}',
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      DataCell(
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: items.map((item) {
                                            return Expanded(
                                              child: Center(
                                                child: Text(
                                                    '${order['status']}',
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
