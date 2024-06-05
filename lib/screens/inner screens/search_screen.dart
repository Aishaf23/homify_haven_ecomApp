import 'package:flutter/material.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> filteredFurniture = furnitures;
  Set<int> addedToCartItems = <int>{};

  void _filterFurniture(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        filteredFurniture = furnitures;
      } else {
        filteredFurniture = furnitures
            .where((element) =>
                element['title']
                    .toString()
                    .toLowerCase()
                    .contains(searchTerm) ||
                element['name'].toString().toLowerCase().contains(searchTerm) ||
                element['product']
                    .toString()
                    .toLowerCase()
                    .contains(searchTerm))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: _filterFurniture,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for furniture...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredFurniture.length,
        itemBuilder: (context, index) {
          final furniture = filteredFurniture[index];
          final isAddedToCart = addedToCartItems.contains(index);

          return ListTile(
            leading: Image.network(
              furniture['imageurl'][0],
              width: width * 0.125,
              height: height * 0.05,
              fit: BoxFit.cover,
            ),
            title: Text(furniture['name']),
            subtitle: Text("\$ ${furniture['price']}"),
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
            trailing: Material(
              color: const Color.fromARGB(255, 176, 211, 228),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.greenAccent,
                onTap: () {
                  setState(() {
                    if (addedToCartItems.contains(index)) {
                      addedToCartItems.remove(index); // Remove item from cart
                    } else {
                      addedToCartItems.add(index); // Add item to cart
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item added to cart')),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    isAddedToCart
                        ? Icons.check
                        : Icons.add_shopping_cart_rounded,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
