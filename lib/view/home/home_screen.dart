import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/res/app_network_image.dart';
import 'package:pingaksh_mobile/view/home/home_controller.dart';

import '../../exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: const RangeMaintainingScrollPhysics(),
          padding: EdgeInsets.only(top: defaultPadding),
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                height: Get.width / 3.1,
              ),
              items: List.generate(
                con.bannerList.length,
                (index) => Container(
                  margin: EdgeInsets.all(defaultPadding).copyWith(bottom: defaultPadding / 2, top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    con.bannerList[index],
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding / 5, bottom: defaultBottomPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: defaultPadding / 2,
                crossAxisSpacing: defaultPadding / 1.8,
                mainAxisExtent: 100.h,
              ),
              itemCount: con.imgList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.categoryScreen),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppNetworkImage(
                      imageUrl: con.imgList[index],
                      borderRadius: BorderRadius.circular(defaultRadius),
                      fit: BoxFit.fill,
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Rang Tarang",
                      style: AppTextStyle.titleStyle(context).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
