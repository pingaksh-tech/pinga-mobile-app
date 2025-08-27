import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/repositories/product/product_repository.dart';
import '../../data/repositories/watchlist/watchlist_repository.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../res/empty_element.dart';
import '../../utils/device_utils.dart';
import '../../widgets/product_tile.dart';
import '../../widgets/pull_to_refresh_indicator.dart';
import 'components/cart_icon_button.dart';
import 'components/sort_filter_button.dart';
import 'products_controller.dart';
import 'widgets/filter/filter_controller.dart';
import 'widgets/sort/sorting_bottomsheet.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final ProductsController con = Get.put(ProductsController());
  final FilterController filterCon = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          title: con.categoryName.isNotEmpty ? con.categoryName.value : con.subCategory.value.name,

          actions: [
            CartIconButton(
              onPressed: () {
                Get.offAllNamed(
                  AppRoutes.cartScreen,
                  predicate: (route) => route.settings.name == AppRoutes.productScreen,
                );
                // Get.back();
                // if (isRegistered<BottomBarController>()) {
                //   BottomBarController bottomCon =
                //       Get.find<BottomBarController>();
                //   bottomCon.currentBottomIndex.value = 2;
                // }
              },
            ),
          ],

          /// SORTING AND FILTERS
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  SortAndFilterButton(
                    title: "Sort",
                    isFilterButton: false,
                    image: AppAssets.sortIcon,
                    iconSize: 16.5.sp,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SortingBottomSheet(
                          watchlistId: con.watchlistId.value,
                          productsListType: con.productListType.value,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  SortAndFilterButton(
                    title: "Filter ${filterCon.count != 0 ? "(${filterCon.count})" : ""}",
                    image: AppAssets.filter,
                    onTap: () {
                      if (isRegistered<FilterController>()) {
                        FilterController filterCon = Get.find<FilterController>();
                        filterCon.isPlatinumBrand.value = con.isPlatinumBrand.value;
                      }

                      Get.toNamed(AppRoutes.filterScreen, arguments: {
                        "subCategoryId": con.subCategory.value.id,
                        "categoryId": con.categoryId.value,
                        "watchlistId": con.watchlistId.value,
                        "productListType": con.productListType.value,
                        "isPlatinumBrand": con.isPlatinumBrand.value,
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  AppIconButton(
                    icon: SvgPicture.asset(
                      con.isProductViewChange.isFalse ? AppAssets.appIcon : AppAssets.listIcon,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
                      height: 18.sp,
                    ),
                    onPressed: () {
                      con.isProductViewChange.value = !con.isProductViewChange.value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: con.loader.isFalse
            ? con.inventoryProductList.isNotEmpty
                ? PullToRefreshIndicator(
                    onRefresh: () async {
                      // filterCon.clearAllFilters();

                      /// GET ALL PRODUCTS
                      return await ProductRepository.getFilterProductsListAPI(
                        isPullToRefresh: true,
                        categoryId: con.categoryId.value,
                        productsListType: con.productListType.value,
                        watchListId: con.watchlistId.value,
                        subCategoryId: con.subCategory.value.id ?? "",
                        inStock: filterCon.isAvailable.value,

                        /// Filter
                        minMetal: filterCon.minMetalWt.value,
                        maxMetal: filterCon.maxMetalWt.value,
                        minDiamond: filterCon.minDiamondWt.value,
                        maxDiamond: filterCon.maxDiamondWt.value,
                        minMrp: filterCon.selectMrp.value.label == "customs".obs ? int.parse(filterCon.mrpFromCon.value.text) : filterCon.selectMrp.value.min?.value,
                        maxMrp: filterCon.selectMrp.value.label == "customs".obs ? int.parse(filterCon.mrpToCon.value.text) : filterCon.selectMrp.value.max?.value,

                        genderList: filterCon.selectedGender,
                        diamondList: filterCon.selectedDiamonds,
                        ktList: filterCon.selectedKt,
                        deliveryList: filterCon.selectedDelivery,
                        productionNameList: filterCon.selectedProductNames,
                        collectionList: filterCon.selectedCollections,
                        sortBy: [
                          if (con.selectPrice.value.isNotEmpty) "inventory_total_price:${con.selectPrice.value.split("/").last}",
                          if (!isValEmpty(con.selectNewestOrOldest.value)) "createdAt:${con.selectNewestOrOldest.value.split("/").last}",
                        ],
                      );
                    },
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding).copyWith(top: 0, bottom: defaultPadding * 5),
                      controller: con.scrollController,
                      children: [
                        Divider(
                          height: 2.h,
                          thickness: 1.5,
                          indent: defaultPadding / 2,
                          endIndent: defaultPadding / 2,
                        ),
                        Text(
                          "Total Products ${con.totalProducts.value}",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subText),
                          textAlign: TextAlign.center,
                        ).paddingOnly(top: defaultPadding / 3),

                        /// DEBUG-MODE
                        if (kDebugMode && con.inventoryProductList.isNotEmpty)
                          Text(
                            "Multi-Diamond - ${con.inventoryProductList[0].isDiamondMultiple} | Size? - ${con.inventoryProductList[0].sizeId != null}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subText),
                            textAlign: TextAlign.center,
                          ).paddingOnly(top: defaultPadding / 3),

                        ListView(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            /// PRODUCTS
                            Wrap(children: [
                              ...List.generate(
                                con.inventoryProductList.length,
                                (index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProductTile(
                                      screenType: "isProductsScreen",
                                      // screenType: con.productListType.value.name,
                                      category: RxString(con.inventoryProductList[index].subCategoryId ?? ""),
                                      isFancy: con.inventoryProductList[index].isDiamondMultiple ?? false,
                                      inventoryId: con.inventoryProductList[index].id,
                                      diamondList: RxList(con.inventoryProductList[index].diamonds ?? []),
                                      productTileType: con.isProductViewChange.isTrue ? ProductTileType.grid : ProductTileType.list,
                                      onTap: () {
                                        // addProductIdToGlobalList((con.inventoryProductList[index].id ?? ""), type: GlobalProductPrefixType.productDetails);
                                        navigateToProductDetailsScreen(
                                          productDetails: {
                                            "productId": (con.inventoryProductList[index].id ?? ""),
                                            "diamondClarity": con.inventoryProductList[index].isDiamondMultiple == true
                                                ? ""
                                                : (con.inventoryProductList[index].diamonds != null && con.inventoryProductList[index].diamonds!.isNotEmpty)
                                                    ? con.inventoryProductList[index].diamonds?.first.diamondClarity?.value ?? ""
                                                    : "",
                                            "diamonds": con.inventoryProductList[index].isDiamondMultiple == true ? con.inventoryProductList[index].diamonds! : [],
                                            "metalId": con.inventoryProductList[index].metalId!.value,
                                            "sizeId": con.inventoryProductList[index].sizeId!.value,
                                            "type": GlobalProductPrefixType.productDetails,
                                          },
                                          type: GlobalProductPrefixType.productDetails,
                                          arguments: {
                                            "category": /*AppStrings.cartIdPrefixSlug +*/
                                                (con.inventoryProductList[index].subCategoryId ?? ''),
                                            'isSize': !isValEmpty(con.inventoryProductList[index].sizeId),
                                            'isFancy': con.inventoryProductList[index].isDiamondMultiple ?? false,
                                            'inventoryId': /*AppStrings.productIdPrefixSlug +*/
                                                (con.inventoryProductList[index].id ?? ""),
                                            'name': con.inventoryProductList[index].name,
                                            "productsListTypeType": ProductsListType.normal,
                                            // 'like': con.inventoryProductList[index].isWishlist,
                                            "sizeId": con.inventoryProductList[index].sizeId!.value,
                                            "remark": con.inventoryProductList[index].remark!.value,
                                            "quantity": con.inventoryProductList[index].quantity!.value,

                                            "diamondClarity": (con.inventoryProductList[index].diamonds != null && con.inventoryProductList[index].diamonds!.isNotEmpty) ? con.inventoryProductList[index].diamonds?.first.diamondClarity?.value ?? "" : "",

                                            "metalId": con.inventoryProductList[index].metalId!.value,

                                            "diamonds": con.inventoryProductList[index].isDiamondMultiple == true ? con.inventoryProductList[index].diamonds : [],
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
                                      diamondOnChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          con.inventoryProductList[index].diamonds?.first.diamondClarity?.value = value;
                                        }
                                      },
                                      sizeOnChanged: (value) {
                                        con.inventoryProductList[index].sizeId!.value = value;
                                      },
                                      metalOnChanged: (value) {
                                        con.inventoryProductList[index].metalId!.value = value;
                                      },
                                      remarkOnChanged: (value) {
                                        con.inventoryProductList[index].remark!.value = value;
                                      },
                                      isLike: con.inventoryProductList[index].isWishlist,
                                      imageUrl: (con.inventoryProductList[index].inventoryImages != null && con.inventoryProductList[index].inventoryImages!.isNotEmpty) ? con.inventoryProductList[index].inventoryImages![0] : "",
                                      productName: con.inventoryProductList[index].name ?? "",
                                      productPrice: con.inventoryProductList[index].inventoryTotalPrice.toString(),
                                      productQuantity: con.inventoryProductList[index].quantity,
                                      isSizeAvailable: con.inventoryProductList[index].isShowSize ?? false,
                                      selectSize: con.inventoryProductList[index].sizeId!.value.obs,
                                      selectMetalCart: con.inventoryProductList[index].metalId!.value.obs,
                                      selectDiamondCart: (con.inventoryProductList[index].diamonds != null && con.inventoryProductList[index].diamonds!.isNotEmpty) ? (con.inventoryProductList[index].diamonds?.first.diamondClarity?.value ?? "").obs : "".obs,
                                      diamonds: con.inventoryProductList[index].diamonds!,

                                      // cartId: con.inventoryProductList[index].cartId,
                                    ),
                                    // if (con.paginationLoader.value &&
                                    //     index + 1 ==
                                    //         con.inventoryProductList.length)
                                    //   productShimmer(context)
                                  ],
                                ),
                              ),
                            ]),
                            if (con.paginationLoader.value) con.isProductViewChange.isTrue ? productGridShimmer(context, length: 20) : productListShimmer(context, length: 20)
                          ],
                        )
                      ],
                    ),
                  )
                :

                /// EMPTY DATA VIEW
                EmptyElement(
                    title: "${con.subCategory.value.name ?? "Products"} Not Found!",
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                  )
            : con.isProductViewChange.isTrue
                ? productGridShimmer(context, length: DeviceUtil.isTablet(context) ? 20 : 8)
                : productListShimmer(context, length: 8),
        floatingActionButton: FloatingActionButton(
          child: SvgPicture.asset(
            AppAssets.productDownload,
            height: 22.h,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            if (con.productListType.value == ProductsListType.watchlist) {
              WatchListRepository.resetDownloadRequest();
              Get.toNamed(
                AppRoutes.watchpdfViewerScreen,
                arguments: {
                  "title": con.categoryName.isNotEmpty ? con.categoryName.value : con.subCategory.value.name,
                  "watchId": con.watchlistId.value,
                },
              );
            } else {
              AppDialogs.productDownloadDialog(context, isDownloadFileNameChange: true, showOnlyDownloadedCatalogues: con.inventoryProductList.isEmpty);
            }
          },
        ),
      ),
    );
  }

  Widget productGridShimmer(BuildContext context, {int length = 2}) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding / 2),
      child: Wrap(
        spacing: defaultPadding,
        runSpacing: defaultPadding,
        direction: Axis.horizontal,
        children: List.generate(
          length,
          (index) => ShimmerUtils.productGridShimmer(context),
        ),
      ),
    );
  }

  Widget productListShimmer(BuildContext context, {int length = 2}) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding / 2),
      child: Wrap(
        spacing: defaultPadding,
        runSpacing: defaultPadding,
        direction: Axis.horizontal,
        children: List.generate(
          length,
          (index) => ShimmerUtils.productsListShimmer(context),
        ),
      ),
    );
  }
}
