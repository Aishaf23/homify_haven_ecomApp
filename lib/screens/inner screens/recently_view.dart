import 'package:flutter/material.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/menu_page.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';

class RecentlyViewScreen extends StatefulWidget {
  @override
  _RecentlyViewScreenState createState() => _RecentlyViewScreenState();
}

class _RecentlyViewScreenState extends State<RecentlyViewScreen> {
  List<Map<String, dynamic>> filteredFurniture = furnitures;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return isEmpty
        ? Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(
                    'Your recent view is empty',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MainMenu();
                        }));
                      },
                      child: Text("Shop Now"))
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Recently Viewed'),
              centerTitle: true,
            ),
            body: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 7,
                childAspectRatio: 0.72,
              ),
              itemCount: filteredFurniture.length,
              itemBuilder: (context, index) {
                final furniture = filteredFurniture[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FurniiDetailPage(
                          furniture: furniture,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image.network(
                            furniture['imageurl'][0],
                            height: height * 0.18,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                furniture['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$ ${furniture['price']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 19,
                                    backgroundColor:
                                        Color.fromARGB(255, 196, 240, 198),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add_shopping_cart,
                                          size: 24,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
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
