import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 178, 255, 237),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(top: 15),
                        shadowColor: Colors.amber,
                        borderOnForeground: true,
                        elevation: 3,
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          leading:
                              Image.asset('images/sofas/linanaes-main.jpg'),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Arm Chair',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Order ID: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text('12345678'),
                                ],
                              )
                            ],
                          ),
                          subtitle: Text('Delivered'),
                          trailing: Text('23/07/2023'),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
