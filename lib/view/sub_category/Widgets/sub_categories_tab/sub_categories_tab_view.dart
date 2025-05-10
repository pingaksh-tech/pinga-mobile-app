import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/sub_category/sub_category_repository.dart';
import '../../../../exports.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/pull_to_refresh_indicator.dart';
import '../../components/sub_category_tile.dart';
import '../../sub_category_controller.dart';

class SubCategoriesTabView extends StatelessWidget {
  SubCategoriesTabView({super.key});

  final SubCategoryController con = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PullToRefreshIndicator(
        onRefresh: () => SubCategoryRepository.getSubCategoriesAPI(isPullToRefresh: true, searchText: con.getSearchText),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: con.scrollControllerSubCategory,
          children: [
            con.loaderSubCategory.isFalse
                ? con.subCategoriesList.isNotEmpty
                    ?

                    /// SUB CATEGORIES
                    ListView.separated(
                        padding: EdgeInsets.all(defaultPadding),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Obx(() {
                          return Column(
                            children: [
                              SubCategoryTile(
                                categoryName: con.subCategoriesList[index].name ?? "",
                                subTitle: "Available ${(con.subCategoriesList[index].totalCount ?? 0)}",
                                imageUrl: con.subCategoriesList[index].subCategoryImage ?? "",
                                onTap: () => Get.toNamed(
                                  AppRoutes.productScreen,
                                  arguments: {
                                    "category": con.subCategoriesList[index],
                                    "categoryId": con.categoryId.value,
                                    "type": ProductsListType.normal,
                                    "isPlatinumBrand": con.isPlatinumBrand.value,
                                  },
                                ),
                              ),

                              /// PAGINATION LOADER
                              Obx(() {
                                return Visibility(visible: (con.paginationLoaderSubCategory.value && index + 1 == con.subCategoriesList.length), child: shimmerTile());
                              })
                            ],
                          );
                        }),
                        itemCount: con.subCategoriesList.length,
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                      )
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
        ),
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
