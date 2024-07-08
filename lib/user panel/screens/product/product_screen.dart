import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../model/products.dart';
import '../../../widgets/header.dart';
import 'product_detail_screen.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  String? category;
  ProductScreen({
    super.key,
    this.category,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> allProducts = [];

  getData() {
    FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((QuerySnapshot? snapshot) => {
              if (widget.category == null)
                {
                  snapshot?.docs.forEach((e) {
                    if (e.exists) {
                      setState(() {
                        allProducts.add(
                          Product(
                            id: e['id'],
                            productName: e['productName'],
                            price: e['price'],
                            imagesUrls: e['imagesUrls'],
                          ),
                        );
                      });
                    }
                  })
                }
              else
                {
                  snapshot?.docs
                      .where(
                          (element) => element['category'] == widget.category)
                      .forEach((e) {
                    if (e.exists) {
                      setState(() {
                        allProducts.add(
                          Product(
                            id: e['id'],
                            productName: e['productName'],
                            price: e['price'],
                            imagesUrls: e['imagesUrls'],
                          ),
                        );
                      });
                    }
                  })
                }
            });
    if (kDebugMode) {
      print("All Products List: $allProducts");
    }
  }

  TextEditingController searchController = TextEditingController();

  filterData(String query) {
    List<Product> dummySearch = [];
    dummySearch.addAll(allProducts);
    if (query.isNotEmpty) {
      List<Product> dummyData = [];
      for (var element in dummySearch) {
        if (element.productName!.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(element);
        }
      }
      setState(() {
        allProducts.clear();
        allProducts.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        allProducts.clear();

        allProducts.addAll(totalItems);
      });
      // return;
    }
  }

  List<Product> totalItems = [];

  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(const Duration(seconds: 1), () {
      totalItems.addAll(allProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: Header(
            title: widget.category ?? "ALL PRODUCTS",
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filterData(searchController.text);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for furniture...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: 0.8,
                // crossAxisSpacing: 6,
                // mainAxisSpacing: 6,
              ),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                                  id: allProducts[index].id,
                                )));
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                          )),
                          child: Image.network(
                            allProducts[index].imagesUrls!.first,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(child: Text(allProducts[index].productName!)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
