import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/theme/app_style.dart';
import 'package:pingaksh_mobile/view/home/home_controller.dart';

import '../../exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // autoPlay: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: Get.width / 2.1,
              onPageChanged: (index, reason) {},
            ),
            items: List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.all(defaultPadding).copyWith(bottom: defaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReyjIyudrWYKWlI5MNBSLHfg1OGjAgbP2xAA&s",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: defaultPadding / 2,
              crossAxisSpacing: defaultPadding / 2,
              mainAxisExtent: 100.h,
            ),
            itemCount: con.imgList.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: NetworkImage(
                    con.imgList[index],
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Text("Rang Tarang"),
            ),
          ),
        ],
      ),
    );
  }
}
