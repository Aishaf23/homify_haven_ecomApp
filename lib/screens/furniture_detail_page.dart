import 'package:flutter/material.dart';
import 'package:homify_haven/screens/cart/cart_page.dart';
import 'package:homify_haven/screens/order/checkout.dart';
import 'package:provider/provider.dart';
import 'package:homify_haven/provider/wishlist_provider.dart';
import 'package:homify_haven/provider/cart_provider.dart';
import 'package:readmore/readmore.dart';

class FurniiDetailPage extends StatefulWidget {
  FurniiDetailPage({
    super.key,
    required this.furniture,
  });

  final Map<String, dynamic> furniture;

  @override
  State<FurniiDetailPage> createState() => _FurniiDetailPageState();
}

class _FurniiDetailPageState extends State<FurniiDetailPage> {
  bool isDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isInWishlist = context.watch<WishlistProvider>().wishlistItems.any(
          (item) => item['id'] == widget.furniture['id'],
        );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 178, 255, 237),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 8, top: 8),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 197, 196, 196),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
            ),
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.white,
            pinned: true,
            floating: true,
            expandedHeight: height * 0.425,
            leadingWidth: width * 0.15,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.furniture['name'].toString(),
                style: TextStyle(
                  fontSize: 26,
                  color: Color(0xFFB8860B),
                  fontFamily: 'Jersey',
                ),
              ),
              titlePadding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              background: InkWell(
                onTap: () {
                  // Handle image tap
                },
                child: Image.network(
                  widget.furniture['imageurl'][0],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    SizedBox(height: height * 0.025),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Container(
                          height: height * 0.45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(width: 0.1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.005),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.furniture['name']
                                                    ?.toString() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.furniture['description']
                                                    ?.toString() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "\$ ${widget.furniture['price'] ?? ''}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ReadMoreText(
                                    widget.furniture['product_details']
                                        .toString(),
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: ' Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    lessStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    'Measurements',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDetailsExpanded = !isDetailsExpanded;
                                      });
                                    },
                                    child: ReadMoreText(
                                      widget.furniture['measurement']
                                          .toString(),
                                      trimLines: 2,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                      moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      lessStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    'Select Color',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.1,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (_, index) {
                                        final colors = [
                                          Colors.pink.shade200,
                                          Color(0xffF5F5DC),
                                          Color(0xff000080),
                                          Color(0xff1A4228),
                                        ];
                                        return Row(
                                          children: [
                                            MyContainer(color: colors[index]),
                                            SizedBox(width: width * 0.025),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFB5F0D3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
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
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      if (isInWishlist) {
                        context
                            .read<WishlistProvider>()
                            .removeProduct(widget.furniture);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Item removed from wishlist'),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        context
                            .read<WishlistProvider>()
                            .addProduct(widget.furniture, context);
                      }
                    },
                    icon: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_outline,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.tealAccent,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(275, 55),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    context.read<CartProvider>().addProduct(widget.furniture);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Item added to cart'),
                      duration: Duration(seconds: 1),
                    ));
                    print('User has added an item to the cart');
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return AddToCart();
                    }));
                  },
                  label: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.tealAccent,
                    ),
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

class MyContainer extends StatelessWidget {
  MyContainer({required this.color, super.key});

  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.135,
      width: width * 0.13,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orangeAccent,
          width: width * 0.004,
        ),
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
