import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_network_image.dart';
import 'image_view_controller.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen({super.key});

  final ImageViewController con = Get.put(ImageViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: con.productName.value,
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.only(top: defaultPadding * 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (con.imageList.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Stack(
                      children: [
                        /// IMAGES
                        PageView.builder(
                          controller: con.imagesPageController.value,
                          itemCount: con.imageList.length,
                          onPageChanged: (index) {
                            con.currentPage.value = index;
                          },
                          itemBuilder: (context, index) {
                            return AppNetworkImage(
                              imageUrl: con.imageList[index],
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.zero,
                            );
                          },
                        ),

                        /// PAGE INDEX INDICATOR
                        Positioned(
                          bottom: defaultPadding,
                          left: Get.width / 2.3,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.surface.withOpacity(.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: con.imageList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: defaultPadding / 2,
                    ),
                    itemBuilder: (context, index) => Obx(() {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: con.currentPage.value == index ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.2),
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: AppNetworkImage(
                              height: 60.h,
                              width: 60.h,
                              fit: BoxFit.cover,
                              imageUrl: con.imageList[index],
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () {
                                con.imagesPageController.value.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                              },
                            ),
                          ),
                          if (con.currentPage.value == index)
                            Container(
                              height: 60.h,
                              width: 62.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.all(defaultPadding * 1.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: Theme.of(context).colorScheme.surface),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(defaultPadding / 4),
                                child: SvgPicture.asset(
                                  AppAssets.doneSmall,
                                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
