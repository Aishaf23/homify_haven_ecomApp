import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/admin_panel/screens/dashboard/update_complete.dart';
import 'package:homify_haven/model/products.dart';

import '../../../widgets/snackbar_widget.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});

  static const String id = "updateProductScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "UPDATE PRODUCT",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('No DATA EXISTS'),
                    );
                  }

                  final data = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Image.network(
                                        data[index]['imagesUrls'][1],
                                        height: 100,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      data[index]['productName'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      data[index]['category'],
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                    trailing: SizedBox(
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        surfaceTintColor:
                                                            Colors.white,
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'Delete Product',
                                                              style: TextStyle(
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .cancel))
                                                          ],
                                                        ),
                                                        content: const Text(
                                                            'Are you sure you want to delete this product?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'No',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                Product.deleteProduct(
                                                                    data[index]
                                                                        .id);
                                                                Navigator.pop(
                                                                    context);
                                                                SnackbarService
                                                                    .showSuccess(
                                                                        context,
                                                                        "Product deleted successfully!");
                                                              },
                                                              child: const Text(
                                                                'YES',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )),
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.white,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return UpdateCompleteProductScreen(
                                                    id: data[index].id,
                                                    product: Product(
                                                      category: data[index]
                                                          ['category'],
                                                      id: id,
                                                      productName: data[index]
                                                          ['productName'],
                                                      detail: data[index]
                                                          ['detail'],
                                                      description: data[index]
                                                          ['description'],
                                                      price: data[index]
                                                          ['price'],
                                                      discountPrice: data[index]
                                                          ['discountPrice'],
                                                      serialCode: data[index]
                                                          ['serialCode'],
                                                      imagesUrls: data[index]
                                                          ['imagesUrls'],
                                                      isOnSale: data[index]
                                                          ['isOnSale'],
                                                      isPopular: data[index]
                                                          ['isPopular'],
                                                      isFavorite: data[index]
                                                          ['isFavorite'],
                                                    ),
                                                  );
                                                }));
                                                //   Navigator.pushReplacementNamed(
                                                //       context,
                                                //       UpdateCompleteProductScreen
                                                //           .id);
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
