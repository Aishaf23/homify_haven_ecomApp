import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannerController _bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Obx(() {
        if (_bannerController.bannerUrls.isEmpty) {
          return const Center(child: CupertinoActivityIndicator());
        } else {
          return CarouselSlider(
            items: _bannerController.bannerUrls
                .asMap()
                .entries
                .map(
                  (entry) => ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: entry.value,
                      fit: entry.key < 2 ? BoxFit.cover : BoxFit.fill,
                      width: Get.width - 2,
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.white,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              aspectRatio: 1.45,
              viewportFraction: 1,
            ),
          );
        }
      }),
    );
  }
}
