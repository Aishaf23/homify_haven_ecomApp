import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homify_haven/model/cart_model.dart';

import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../../model/products.dart';
import '../../../widgets/homi_button.dart';
import '../../../widgets/header.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? id;
  const ProductDetailScreen({super.key, this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Product> allProducts = [];
  int count = 1;
  var newPrice = 0;

  bool isLoading = false;
  bool isfvrt = false;

  int selectedIndex = 0;

  getData() async {
    await FirebaseFirestore.instance
        .collection("items")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["id"] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var item in e["imagesUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Product(
                    id: e["id"],
                    detail: e["detail"],
                    productName: e["productName"],
                    description: e['description'],
                    imagesUrls: e["imagesUrls"],
                    price: e['price'],
                    discountPrice: e['discountPrice'] ?? 0,
                  ),
                );
              });
            }
          }
        }
        newPrice = allProducts.first.price!;
      });
    });
    // print(allProducts[0].discountPrice);
  }

  addToFavourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favItems")
        .add({"pid": allProducts.first.id});
    if (kDebugMode) {
      print('Added to Favorite');
    }
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favItems")
        .doc(id)
        .delete();
    if (kDebugMode) {
      print('Removed from Favorite');
    }
  }

  int calculatePrice(int quantity) {
    if (quantity > 3 && allProducts.first.discountPrice != 0) {
      return quantity * allProducts.first.discountPrice!;
    } else {
      return quantity * allProducts.first.price!;
    }
  }

  Future<void> addToCart(CartModel item) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollection = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('items');

    final existing =
        await cartCollection.where('id', isEqualTo: item.id).limit(1).get();

    if (existing.docs.isNotEmpty) {
      final existingDoc = existing.docs.first;
      final existingData = existingDoc.data();
      final newQuantity = existingData['quantity'] + item.quantity;
      final newPrice = calculatePrice(newQuantity);

      await cartCollection.doc(existingDoc.id).update({
        'quantity': newQuantity,
        'price': newPrice,
      });
    } else {
      await cartCollection.add({
        'id': item.id,
        'productId': item.id,
        'name': item.productName,
        'image': item.image,
        'quantity': item.quantity,
        'price': calculatePrice(item.quantity!.toInt()),
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(5.h),
                child: Header(
                  title: "${allProducts.first.productName}",
                )),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    allProducts[0].imagesUrls![selectedIndex],
                    height: 32.5.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          allProducts[0].imagesUrls!.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 10.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Image.network(
                                  allProducts[0].imagesUrls![index],
                                  height: 9.h,
                                  width: 9.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 6.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "${allProducts.first.price} \$",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('favItems')
                          .where('pid', isEqualTo: allProducts.first.id)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return const Text("");
                        }
                        return IconButton(
                            onPressed: () {
                              snapshot.data!.docs.isEmpty
                                  ? addToFavourite()
                                  : removeToFavrourite(
                                      snapshot.data!.docs.first.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: snapshot.data!.docs.isEmpty
                                  ? Colors.black
                                  : Colors.red,
                            ));
                      }),
                  SizedBox(
                    height: 0.05.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ReadMoreText(
                        allProducts.first.detail!,
                        textAlign: TextAlign.justify,
                        trimLines: 5,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        lessStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "NOTE: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Discount of ${allProducts.first.discountPrice}\$ will be applied when you order more then three items of this product",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) count--;
                                    newPrice = calculatePrice(count);
                                  });
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    radius: 14,
                                    child: const Icon(Icons.exposure_minus_1,
                                        size: 20),
                                  ),
                                ),
                              ),
                              Text('$count', style: TextStyle(fontSize: 16.sp)),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                    newPrice = calculatePrice(count);
                                  });
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    radius: 14,
                                    child: const Icon(Icons.exposure_plus_1,
                                        size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 6.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text("$newPrice \$",
                                        style: const TextStyle(
                                            color: Colors.white))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HomifyButton(
                    isLoginButton: true,
                    isLoading: isLoading,
                    onPress: () {
                      setState(() {
                        isLoading = true;
                      });
                      CartModel.addOrUpdateCartItem(CartModel(
                        id: allProducts.first.id,
                        productId: allProducts.first.id,
                        image: allProducts.first.imagesUrls!.first,
                        productName: allProducts.first.productName,
                        quantity: count,
                        price: newPrice ?? 0,
                      )).whenComplete(() {
                        setState(() {
                          isLoading = false;
                          Get.snackbar(
                            count > 1 ? 'Cart Updated' : 'Item Added to Cart',
                            "Check Cart",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.amber.shade700,
                            colorText: Colors.black,
                            duration: const Duration(seconds: 2),
                            icon: const Icon(Icons.shopping_bag_outlined,
                                color: Colors.black),
                          );
                        });
                      });
                    },
                    title: "Add to Cart",
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          );
  }
}
