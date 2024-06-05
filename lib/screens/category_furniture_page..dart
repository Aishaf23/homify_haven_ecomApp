import 'package:flutter/material.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';

class CategoryFurniturePage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> furnitureItems;

  const CategoryFurniturePage({
    Key? key,
    required this.category,
    required this.furnitureItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
        // padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0, // Adjust the spacing between columns
          mainAxisSpacing: 0, // Adjust the spacing between rows
          childAspectRatio: 0.9,
        ),
        itemCount: furnitureItems.length,
        itemBuilder: (context, index) {
          final furniture = furnitureItems[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FurniiDetailPage(furniture: furniture,);
              }));
            },
            child: Card(
              elevation: 0,
              color: const Color.fromRGBO(0, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        furniture['imageurl'][2].toString(),
                        width: double.infinity,
                        height: height * 0.16, // Adjust height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      furniture['name'].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      "\$ ${furniture['price'].toString()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
