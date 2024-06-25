import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/empty_element.dart';
import '../../components/sub_category_tile.dart';
import '../../sub_category_controller.dart';

class SubCategoriesTabView extends StatelessWidget {
  SubCategoriesTabView({super.key});

  final SubCategoryController con = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: const RangeMaintainingScrollPhysics(),
        controller: con.scrollControllerSubCategory,
        children: [
          con.loaderSubCategory.isFalse
              ? con.subCategoriesList.isNotEmpty
                  ?

                  /// SUB CATEGORIES
                  Obx(() {
                      return ListView.separated(
                        padding: EdgeInsets.all(defaultPadding),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            SubCategoryTile(
                              categoryName: con.subCategoriesList[index].name ?? "",
                              subTitle: (con.subCategoriesList[index].totalCount ?? 0).toString(),
                              imageUrl: con.subCategoriesList[index].subCategoryImage ?? "",
                              onTap: () => Get.toNamed(
                                AppRoutes.productScreen,
                                arguments: {
                                  "category": con.subCategoriesList[index],
                                },
                              ),
                            ),

                            /// PAGINATION LOADER
                            if (con.paginationLoaderSubCategory.value && index == con.subCategoriesList.length - 1) shimmerTile(),
                          ],
                        ),
                        itemCount: con.subCategoriesList.length,
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                      );
                    })
                  :

                  /// EMPTY DATA VIEW
                  EmptyElement(
                      title: "Categories Not Found!",
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
