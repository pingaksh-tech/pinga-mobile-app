import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/latest_products/latest_products_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_network_image.dart';
import '../../../../res/empty_element.dart';
import '../../../../utils/app_aspect_ratios.dart';
import '../../../../widgets/pull_to_refresh_indicator.dart';
import '../../sub_category_controller.dart';

class LatestProductsTabView extends StatelessWidget {
  LatestProductsTabView({super.key});

  final SubCategoryController con = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PullToRefreshIndicator(
        onRefresh: () => LatestProductsRepository.getLatestProductsAPI(isPullToRefresh: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: con.scrollControllerLatestProd,
          children: [
            con.loaderLatestProd.isFalse
                ? con.latestProductList.isNotEmpty
                    ?

                    /// LATEST PRODUCTS
                    Obx(() {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(defaultPadding),
                          itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateToProductDetailsScreen(
                                    productDetails: {
                                      "productId": (con.latestProductList[index].id ?? ""),
                                      "diamondClarity": con.latestProductList[index].isDiamondMultiple == true
                                          ? ""
                                          : (con.latestProductList[index].diamonds != null && con.latestProductList[index].diamonds!.isNotEmpty)
                                              ? con.latestProductList[index].diamonds?.first.diamondClarity ?? ""
                                              : "",
                                      "diamonds": con.latestProductList[index].isDiamondMultiple == true ? con.latestProductList[index].diamonds! : [],
                                      "metalId": con.latestProductList[index].metalId,
                                      "sizeId": con.latestProductList[index].sizeId,
                                      "type": GlobalProductPrefixType.productDetails,
                                    },
                                    type: GlobalProductPrefixType.productDetails,
                                    arguments: {
                                      "category": /*AppStrings.cartIdPrefixSlug +*/
                                          (con.latestProductList[index].category?.id ?? ''),
                                      'isSize': !isValEmpty(con.latestProductList[index].sizeId),
                                      'isFancy': con.latestProductList[index].isDiamondMultiple ?? false,
                                      'inventoryId': /*AppStrings.productIdPrefixSlug +*/
                                          (con.latestProductList[index].inventoryId ?? ""),
                                      'name': con.latestProductList[index].productName,
                                      "productsListTypeType": ProductsListType.normal,
                                      // 'like': con.inventoryProductList[index].isWishlist,
                                      "sizeId": con.latestProductList[index].sizeId,

                                      "diamondClarity": (con.latestProductList[index].diamonds != null && con.latestProductList[index].diamonds!.isNotEmpty) ? con.latestProductList[index].diamonds?.first.diamondClarity ?? "" : "",

                                      "metalId": con.latestProductList[index].metalId,

                                      "diamonds": con.latestProductList[index].isDiamondMultiple == true ? con.latestProductList[index].diamonds : [],
                                    },
                                    whenComplete: () {
                                      if (isRegistered<BaseController>()) {
                                        BaseController baseCon = Get.find<BaseController>();
                                        if (baseCon.globalProductDetails.isNotEmpty) {
                                          baseCon.globalProductDetails.removeLast();
                                        }
                                      }
                                    },
                                  );
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: AspectRatio(
                                  aspectRatio: AppAspectRatios.r16_5,
                                  child: AppNetworkImage(
                                    width: double.infinity,
                                    imageUrl: con.latestProductList[index].productImage ?? "",
                                    fit: BoxFit.cover,
                                    boxShadow: defaultShadowAllSide,
                                    borderRadius: BorderRadius.circular(defaultRadius),
                                  ),
                                ),
                              ),

                              /// PAGINATION LOADER
                              Obx(() {
                                return Visibility(visible: (con.paginationLoaderLatestProd.value && index + 1 == con.latestProductList.length), child: shimmerTile());
                              })
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
