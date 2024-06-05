import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/classes/furnitures_list.dart';
import 'package:homify_haven/screens/login/login_screen.dart';
import 'package:homify_haven/menu_page.dart';
import 'package:homify_haven/screens/order/checkout.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:homify_haven/screens/furniture_detail_page.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Show the snackbar after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      // Show the snackbar
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: "Swipe right or left to delete",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.amber.shade300,
        messageText: Text(
          "Swipe right or left to delete",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        margin: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(20),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        onStatusChanged: (status) {
          if (status == FlushbarStatus.DISMISSED) {
            print('Flushbar dismissed');
          }
        },
      )..show(context);
    });
  }

  // Define the mapping of titles to colors
  Map<String, Color> titleColors = {
    "Sofas": Color.fromARGB(255, 248, 242, 180),
    "Beds": Color(0xffe78169),
    "Table": Color.fromARGB(255, 189, 231, 103),
    "Outdoor": Color(0xffcc6633),
    "Shelf": Color.fromARGB(255, 235, 234, 229),
    "Plants": Color(0xffcae4c5),
    "Lamps": Color(0xff996633),
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final cartList = context.watch<CartProvider>().cartList;

    // Calculate total prices per category
    Map<String, double> categoryTotals = {};
    double grandTotal = 0;

    for (var item in cartList) {
      double price = (item['price'] ?? 0) * (item['quantity'] ?? 1);
      String category = item['title'];

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + price;
      } else {
        categoryTotals[category] = price;
      }

      grandTotal += price;
    }

    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          Text(
            'Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          if (cartList.isNotEmpty)
            TextButton(
              onPressed: () {
                context.read<CartProvider>().clearCart();
              },
              child: Text(
                'Clear Cart',
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.black54,
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (cartList.isEmpty)
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.35,
                    ),
                    Center(
                      child: Text(
                        'Cart is Empty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ...categoryTotals.entries.map((entry) {
                String category = entry.key;
                double categoryTotal = entry.value;

                return Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: double.infinity,
                  child: Card(
                    color: titleColors[category] ?? Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          ...cartList
                              .where((item) => item['title'] == category)
                              .map((furnitureItems) {
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                context
                                    .read<CartProvider>()
                                    .removeProduct(furnitureItems);
                              },
                              background: Container(color: Colors.red),
                              confirmDismiss: (direction) {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        surfaceTintColor: Colors.transparent,
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Do you want to remove this product from cart?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              "NO",
                                            ),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.blue,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                              context
                                                  .read<CartProvider>()
                                                  .removeProduct(
                                                      furnitureItems);
                                            },
                                            child: Text("YES"),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Card(
                                  elevation: 3,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return FurniiDetailPage(
                                          furniture: cartList[0],
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: height * 0.115,
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            furnitureItems['imageurl'][0]
                                                .toString(),
                                            width: width * 0.15,
                                            height: height * 0.07,
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              furnitureItems['name'].toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '\$ ${furnitureItems['price'].toString()}',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                furnitureItems['description']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    // context
                                                    //     .read<CartProvider>()
                                                    //     .decreaseQuantity(
                                                    //         furnitureItems);
                                                  },
                                                ),
                                                Text(
                                                  furnitureItems['quantity']
                                                          ?.toString() ??
                                                      '0',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    // context
                                                    //     .read<CartProvider>()
                                                    //     .increaseQuantity(
                                                    //         furnitureItems);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          SizedBox(height: height * 0.01),
                          Padding(
                            padding: const EdgeInsets.only(right: 18, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total for $category: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$ ${categoryTotal.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              Visibility(
                visible: cartList.isNotEmpty,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainMenu()),
                      (route) => false,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: ' Continue Shopping ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: Colors.black54,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        decoration: TextDecoration
                            .underline, // Underline both icon and texts
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(228, 9, 241, 187),
              Colors.white,
              Color.fromARGB(228, 9, 241, 187),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$ ${grandTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    User? currentUser = auth.currentUser;

                    if (cartList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add Items'),
                        ),
                      );
                      return; // Prevent navigation
                    }

                    if (currentUser == null) {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                      // Again check if a user is logged in, if so, proceed to CheckOutPage
                      currentUser = auth.currentUser;
                      if (currentUser != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CheckOutPage(
                            totalPrice: grandTotal,
                          );
                        }));
                      }
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CheckOutPage(
                          totalPrice: grandTotal,
                        );
                      }));
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.tealAccent,
                  ),
                  label: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
