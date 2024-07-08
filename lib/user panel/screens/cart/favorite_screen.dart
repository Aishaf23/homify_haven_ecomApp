import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/header.dart';
import '../product/product_detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: Header(
            title: "FAVOURITE",
          )),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('favourite')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('favItems')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> favSnapshot) {
            if (!favSnapshot.hasData) {
              return const CircularProgressIndicator();
            }

            List favIds =
                favSnapshot.data!.docs.map((doc) => doc['pid']).toList();

            if (favIds.isEmpty) {
              return const Center(child: Text("No Favourite Items Found"));
            }

            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                List<QueryDocumentSnapshot<Object?>> favProds = itemSnapshot
                    .data!.docs
                    .where((element) => favIds.contains(element["id"]))
                    .toList();

                return ListView.builder(
                  itemCount: favProds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 0.7.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                id: favProds[index]['id'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                favProds[index]['productName'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailScreen(
                                                id: favProds[index]['id'],
                                              )));
                                },
                                icon: const Icon(
                                  Icons.navigate_next_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
