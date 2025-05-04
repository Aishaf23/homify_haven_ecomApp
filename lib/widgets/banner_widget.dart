import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

import '../controller/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: ImageSlideshow(
              width: double.infinity,
              height: Get.width / 1.575,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              autoPlayInterval: 3000,
              isLoop: true,
              children: _bannerController.bannerUrls
                  .asMap()
                  .entries
                  .map(
                    (entry) => CachedNetworkImage(
                      imageUrl: entry.value,
                      fit: entry.key < 2 ? BoxFit.cover : BoxFit.fill,
                      width: Get.width - 2,
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.white,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                  .toList(),
            ),
          );
        }
      }),
    );
  }
}
