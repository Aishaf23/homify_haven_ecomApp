import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/header.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key, });

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: Header(
            title: "MY ORDERS",
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user_id', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.black)));
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No orders found',
                    style: TextStyle(color: Colors.black)));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              var orderId = order.id;
              var items = order['items'] as List<dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.black,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  const TextSpan(
                                      text: 'Order ID: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                  TextSpan(
                                      text: orderId,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  const TextSpan(
                                    text: 'Date: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: DateFormat('dd/MM/yy : HH:mm').format(
                                        (order['time'] as Timestamp).toDate()),
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: items.map((item) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: Image.network(item['image'] as String),
                              title: Text(
                                item['productName'] as String,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(color: Colors.white),
                                      children: [
                                        const TextSpan(
                                            text: 'Price: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: '${item['price']} \$',
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(color: Colors.white),
                                      children: [
                                        const TextSpan(
                                            text: 'Quantity: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: '${item['quantity']}',
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.white),
                                  children: [
                                    const TextSpan(
                                        text: 'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${order['status']}',
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
