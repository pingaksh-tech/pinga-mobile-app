import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/repositories/product/product_repository.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../res/empty_element.dart';
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

          actions: const [
            CartIconButton(),
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
                    onTap: () => Get.toNamed(AppRoutes.filterScreen, arguments: {
                      "subCategoryId": con.subCategory.value.id,
                      "categoryId": con.categoryId.value,
                      "watchlistId": con.watchlistId.value,
                      "productListType": con.productListType.value,
                    }),
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
        body: PullToRefreshIndicator(
          onRefresh: () async {
            /// GET ALL PRODUCTS
            return await ProductRepository.getFilterProductsListAPI(
              isPullToRefresh: true,
              categoryId: con.categoryId.value,
              productsListType: ProductsListType.normal,
              subCategoryId: con.subCategory.value.id ?? "",
            );
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding).copyWith(top: 0, bottom: defaultPadding * 5),
            children: [
              Divider(
                height: 2.h,
                thickness: 1.5,
                indent: defaultPadding / 2,
                endIndent: defaultPadding / 2,
              ),
              Text(
                "Total Products ${con.inventoryProductList.length}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subText),
                textAlign: TextAlign.center,
              ).paddingOnly(top: defaultPadding / 3),
              ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  /// PRODUCTS
                  con.loader.isFalse
                      ? con.inventoryProductList.isNotEmpty
                          ? Wrap(
                              children: List.generate(
                                con.inventoryProductList.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProductTile(
                                      category: RxString(con.subCategory.value.id ?? ""),
                                      isFancy: con.isFancyDiamond.value,
                                      inventoryId: con.inventoryProductList[index].id,
                                      diamondList: RxList(con.inventoryProductList[index].diamonds ?? []),
                                      productTileType: con.isProductViewChange.isTrue ? ProductTileType.grid : ProductTileType.list,
                                      onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                                        "category": con.inventoryProductList[index].subCategoryId ?? '',
                                        'isSize': con.isSizeAvailable.value,
                                        'isFancy': con.isFancyDiamond.value,
                                        'inventoryId': con.inventoryProductList[index].id,
                                        'name': con.inventoryProductList[index].name,
                                        'like': con.inventoryProductList[index].isWishlist,
                                      }),
                                      isLike: con.inventoryProductList[index].isWishlist,
                                      imageUrl: (con.inventoryProductList[index].inventoryImages != null && con.inventoryProductList[index].inventoryImages!.isNotEmpty) ? con.inventoryProductList[index].inventoryImages![0] : "",
                                      productName: con.inventoryProductList[index].name ?? "",
                                      productPrice: con.inventoryProductList[index].inventoryTotalPrice.toString(),
                                      productQuantity: con.inventoryProductList[index].quantity,
                                      isSizeAvailable: con.isSizeAvailable.value,
                                      selectSize: (con.inventoryProductList[index].sizeId ?? "").obs,
                                      selectMetalCart: (con.inventoryProductList[index].metalId ?? "").obs,
                                      selectDiamondCart: (con.inventoryProductList[index].diamonds != null && con.inventoryProductList[index].diamonds!.isNotEmpty) ? (con.inventoryProductList[index].diamonds?.first.diamondClarity?.value ?? "").obs : "".obs,
                                      diamonds: con.inventoryProductList[index].diamonds,
                                    ),
                                    if (con.paginationLoader.value && index + 1 == con.inventoryProductList.length) productShimmer(context)
                                  ],
                                ),
                              ),
                            )
                          :

                          /// EMPTY DATA VIEW
                          EmptyElement(
                              title: "${con.subCategory.value.name ?? "Products"} Not Found!",
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                            )
                      : productShimmer(context, length: 6),
                ],
              )
            ],
          ),
        ),
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
            AppDialogs.productDownloadDialog(context, isDownloadFileNameChange: true);
          },
        ),
      ),
    );
  }

  Widget productShimmer(BuildContext context, {int length = 2}) {
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
