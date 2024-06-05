import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';

class ShelfCollections extends StatefulWidget {
  const ShelfCollections({Key? key}) : super(key: key);

  @override
  State<ShelfCollections> createState() => _ShelfCollectionsState();
}

class _ShelfCollectionsState extends State<ShelfCollections> {
  final bool _showExclusiveOffers = true;

  FirebaseFirestore db = FirebaseFirestore.instance;

  late Stream<QuerySnapshot<Map<String, dynamic>>> shelfdataStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shelfdataStream = db
        .collection('products')
        .where('title', isEqualTo: 'Shelf')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SHELF COLLECTION',
              style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontFamily: 'Jersey',
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: shelfdataStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('Please Wait'),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 6,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: snapshot.data?.docs.length,
                      // itemCount:
                      //     furnitures.where((item) => item['title'] == 'Shelf').length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot products = snapshot.data!.docs[index];

                        final List<Map<String, dynamic>> sofaFurnitures =
                            furnitures
                                .where((item) => item['title'] == 'Shelf')
                                .toList();
                        // sofaFurnitures
                        //     .sort((a, b) => a['title'].compareTo(b['title']));
                        final sofaFurniture = sofaFurnitures[index];
                        return Card(
                          elevation: 0,
                          color: const Color.fromRGBO(0, 0, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return FurniiDetailPage(
                                    furniture:
                                        products.data() as Map<String, dynamic>,
                                  );
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.network(
                                      products['imageurl'][1],
                                      width: double.infinity,
                                      height: height * 0.16,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    products['name'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${products['price']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}