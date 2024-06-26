import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../data/repositories/banner/banner_repository.dart';
import '../../data/repositories/category/category_repository.dart';
import '../../res/app_network_image.dart';
import '../../res/empty_element.dart';
import '../../utils/app_aspect_ratios.dart';
import '../../widgets/pull_to_refresh_indicator.dart';
import 'home_controller.dart';

import '../../exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Obx(() {
          return PullToRefreshIndicator(
            onRefresh: () async {
              /// PULL TO REFRESH
              await BannerRepository.getBannersAPI();
              await CategoryRepository.getCategoriesAPI(isPullToRefresh: true);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: con.scrollController,
              children: [
                defaultPadding.verticalSpace,

                /// ***********************************************************************************
                ///                                       BANNERS
                /// ***********************************************************************************

                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    aspectRatio: AppAspectRatios.r16_7,
                  ),
                  items: con.bannerLoader.isFalse
                      ? con.bannersList.isNotEmpty
                          ? List.generate(
                              con.bannersList.length,
                              (index) => Container(
                                margin: EdgeInsets.all(defaultPadding).copyWith(bottom: defaultPadding / 2, top: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                  boxShadow: defaultShadow(context),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: AppNetworkImage(
                                  imageUrl: con.bannersList[index].bannerImage ?? "",
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : []
                      :

                      /// LOADER VIEW
                      List.generate(
                          1,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                            child: ShimmerUtils.shimmer(
                              child: ShimmerUtils.shimmerContainer(
                                borderRadiusSize: defaultRadius,
                              ),
                            ),
                          ),
                        ),
                ),

                /// ***********************************************************************************
                ///                                     CATEGORIES
                /// ***********************************************************************************

                con.categoryLoader.isFalse
                    ? con.categoriesList.isNotEmpty
                        ?

                        /// CATEGORIES LIST VIEW
                        Column(
                            children: [
                              gridviewBuilder(
                                length: con.categoriesList.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => Get.toNamed(
                                    AppRoutes.categoryScreen,
                                    arguments: {
                                      "categoryName": con.categoriesList[index].name,
                                      "categoryId": con.categoriesList[index].id,
                                    },
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      AppNetworkImage(
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageUrl: con.categoriesList[index].categoryImage ?? "",
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(defaultRadius),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                                            child: Container(
                                              color: Colors.black.withOpacity(0.45),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(defaultPadding),
                                        child: Text(
                                          (con.categoriesList[index].name ?? AppStrings.defaultPingakshLogoURL),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.titleStyle(context).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// PAGINATION LOADER
                              Visibility(
                                visible: con.paginationLoader.isTrue,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2).copyWith(top: 0),
                                  child: ShimmerUtils.shimmer(
                                    child: ShimmerUtils.shimmerContainer(
                                      borderRadiusSize: defaultRadius,
                                      height: Get.width / 3,
                                      width: Get.width,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        :

                        /// EMPTY ELEMENT VIEW
                        const Center(
                            child: EmptyElement(
                              title: "Categories Not Found!",
                              alignment: Alignment.center,
                              imagePath: AppAssets.emptyData,
                            ),
                          )
                    :

                    /// LOADING SHIMMER VIEW
                    gridviewBuilder(
                        length: 6,
                        itemBuilder: (context, index) => ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(
                            borderRadiusSize: defaultRadius,
                          ),
                        ),
                      )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget gridviewBuilder({
    required int length,
    required Widget? Function(BuildContext, int) itemBuilder,
  }) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding / 5, bottom: defaultBottomPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: defaultPadding / 2,
        crossAxisSpacing: defaultPadding / 1.8,
        mainAxisExtent: 135.h,
      ),
      itemCount: length,
      itemBuilder: itemBuilder,
    );
  }
}
