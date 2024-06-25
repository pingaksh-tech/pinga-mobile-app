import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_network_image.dart';
import '../../../../res/empty_element.dart';
import '../../sub_category_controller.dart';

class LatestProductsTabView extends StatelessWidget {
  LatestProductsTabView({super.key});

  final SubCategoryController con = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: const RangeMaintainingScrollPhysics(),
        controller: con.scrollControllerLatestProd,
        children: [
          con.loaderLatestProd.isFalse
              ? con.latestProductList.isNotEmpty
                  ?

                  /// LATEST PRODUCTS
                  Obx(() {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(defaultPadding),
                        itemBuilder: (context, index) => Column(
                          children: [
                            AppNetworkImage(
                              height: Get.height / 8,
                              width: double.infinity,
                              imageUrl: con.latestProductList[index].productImage ?? "",
                              fit: BoxFit.cover,
                              boxShadow: defaultShadowAllSide,
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),

                            /// PAGINATION LOADER
                            if (con.paginationLoaderLatestProd.value && index == con.latestProductList.length - 1) shimmerTile(),
                          ],
                        ),
                        itemCount: con.latestProductList.length,
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                      );
                    })
                  :

                  /// EMPTY DATA VIEW
                  EmptyElement(
                      title: "Latest Products Not Found!",
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                    )
              :

              /// LOADING VIEW
              shimmerListView()
        ],
      );
    });
  }

  Widget shimmerTile({bool showShimmer = true}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      width: Get.width,
      height: Get.width / 4,
      child: showShimmer
          ? ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                borderRadiusSize: defaultRadius,
              ),
            )
          : const SizedBox(),
    );
  }

  Widget shimmerListView() {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding),
      shrinkWrap: true,
      itemBuilder: (context, index) => shimmerTile(),
      itemCount: 10,
    );
  }
}
