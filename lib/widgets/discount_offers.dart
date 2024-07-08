import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../model/products.dart';

class DiscountItems extends StatelessWidget {
  const DiscountItems({
    super.key,
    required this.allProducts,
  });

  final List<Product> allProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.discountPrice! > 300)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: 10.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                            e.imagesUrls![0],
                            // height: 80,
                            // width: 80,
                          )),
                          // borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        // child: ClipRRect(
                        //   child: Image.network(
                        //     e.imagesUrls![0],
                        //     height: 80,
                        //     width: 80,
                        //   ),
                        // ),
                      ),
                      Expanded(child: Text(e.productName!)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
