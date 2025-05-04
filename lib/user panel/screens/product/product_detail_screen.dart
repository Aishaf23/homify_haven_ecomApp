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
import '../../../widgets/snackbar_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? id;
  const ProductDetailScreen({super.key, this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? product;
  int count = 1;
  int newPrice = 0;
  int selectedIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  Future<void> getProductData() async {
    final query = await FirebaseFirestore.instance
        .collection("items")
        .where("id", isEqualTo: widget.id)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final data = query.docs.first.data();
      setState(() {
        product = Product(
          id: data["id"],
          detail: data["detail"],
          productName: data["productName"],
          description: data['description'],
          imagesUrls: List<String>.from(data["imagesUrls"]),
          price: data['price'],
          discountPrice: data['discountPrice'],
        );
        newPrice = product!.price!;
      });
    }
  }

  void updatePrice() {
    if (count > 3) {
      newPrice = count * (product!.discountPrice ?? product!.price!);
    } else {
      newPrice = count * product!.price!;
    }
  }

  Future<void> toggleFavourite(bool isFav, String? favId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final favRef = FirebaseFirestore.instance
        .collection('favourite')
        .doc(uid)
        .collection('favItems');

    if (isFav && favId != null) {
      await favRef.doc(favId).delete();
    } else {
      await favRef.add({"pid": product!.id});
    }
  }

  Future<void> addToCart() async {
    setState(() => isLoading = true);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final cartRef = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('cartItems');
    final productId = product!.id;

    final docRef = cartRef.doc(productId);
    final docSnapshot = await docRef.get();

    final unitPrice = product!.price!;
    final discountPrice = product!.discountPrice ?? unitPrice;

    if (docSnapshot.exists) {
      // Product already in cart, update quantity & price
      final existingQty = docSnapshot['quantity'] ?? 0;
      final newQty = existingQty + count;
      final updatedPrice =
          newQty > 3 ? newQty * discountPrice : newQty * unitPrice;

      await docRef.update({
        'quantity': newQty,
        'price': updatedPrice,
      });

      SnackbarService.showAdded(context, "Item quantity updated in Cart");
    } else {
      // Product not in cart, add new entry
      final newItem = CartModel(
        id: productId,
        image: product!.imagesUrls!.first,
        name: product!.productName,
        quantity: count,
        price: newPrice,
      );

      await cartRef.doc(productId).set(newItem.toMap());

      SnackbarService.showAdded(context, "Item added to Cart");
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Header(title: product!.productName ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product!.imagesUrls![selectedIndex],
              height: 32.5.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product!.imagesUrls!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 25.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Image.network(
                        product!.imagesUrls![index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 6.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  "${product!.price} \$",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('favourite')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('favItems')
                  .where('pid', isEqualTo: product!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                final isFav = snapshot.data?.docs.isNotEmpty ?? false;
                final favId = isFav ? snapshot.data!.docs.first.id : null;

                return IconButton(
                  onPressed: () => toggleFavourite(isFav, favId),
                  icon: Icon(
                    Icons.favorite,
                    color: isFav ? Colors.red : Colors.black,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ReadMoreText(
                  product!.detail!,
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
            Padding(
              padding: const EdgeInsets.all(8),
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
                          "Discount of ${product!.discountPrice}\$ will be applied when you order more than three items of this product.",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                              updatePrice();
                            });
                          }
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 14,
                          child: const Icon(Icons.exposure_minus_1, size: 20),
                        ),
                      ),
                      Text('$count', style: TextStyle(fontSize: 16.sp)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            count++;
                            updatePrice();
                          });
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 14,
                          child: const Icon(Icons.exposure_plus_1, size: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 6.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: Center(
                      child: Text(
                        "$newPrice \$",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HomifyButton(
              isLoginButton: true,
              isLoading: isLoading,
              onPress: addToCart,
              title: "Add to Cart",
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
