import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../data/repositories/cart/cart_repository.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../res/empty_element.dart';
import '../../utils/custom_route_observer.dart';
import '../../widgets/custom_check_box_tile.dart';
import '../../widgets/product_tile.dart';
import '../../widgets/pull_to_refresh_indicator.dart';
import 'cart_controller.dart';
import 'components/cart_item_simmer.dart';
import 'components/cart_popup_menu.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController con = Get.put(CartController());
  CustomRouteObserver routeObserver = Get.find<CustomRouteObserver>();

  @override
  Widget build(BuildContext context) {
    return PullToRefreshIndicator(
      onRefresh: () => CartRepository.getCartApi(isPullToRefresh: true),
      child: Obx(
        () {
          printYellow(routeObserver.currentRoute.value);
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: routeObserver.currentRoute.value != AppRoutes.bottomBarScreen
                ? MyAppBar(
                    title: "My Cart",
                    showBackIcon: false,
                    leading: IconButton(
                      onPressed: () {
                        if (isRegistered<BaseController>()) {
                          BaseController baseCon = Get.find<BaseController>();
                          printData(value: baseCon.globalProductDetails);

                          int.parse(baseCon.globalProductDetails.length.toString()) >= 1 ? Get.offAllNamed(AppRoutes.bottomBarScreen) : Get.back();
                        }
                      },
                      icon: SvgPicture.asset(
                        height: 30,
                        AppAssets.backArrowIcon,
                        color: AppColors.primary, // ignore: deprecated_member_use
                      ),
                    ),
                    actions: [
                      if (con.cartList.isNotEmpty)
                        CartPopUpMenu(
                          cardIds: (con.selectedList
                              .map(
                                (element) => element.id ?? "",
                              )
                              .toList()),
                        ),
                    ],
                  )
                : null,
            body: con.cartLoader.isFalse
                ? (con.cartList.isNotEmpty
                    ? ListView(
                        controller: con.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 1.2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                            child: CustomCheckboxTile(
                                title: "Select all items",
                                behavior: HitTestBehavior.deferToChild,
                                isSelected: RxBool(con.selectedList.length == con.cartList.length),
                                titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                scale: 1.1,
                                borderWidth: 1.6,
                                onChanged: (_) {
                                  if (con.selectedList.length != con.cartList.length) {
                                    con.selectedList.addAll(
                                      con.cartList.where(
                                        (item) => !con.selectedList.contains(item),
                                      ),
                                    );
                                  } else {
                                    con.selectedList.clear();
                                  }
                                  con.calculateSelectedItemPrice();
                                  con.calculateSelectedQue();
                                }).paddingOnly(left: defaultPadding),
                          ),
                          Column(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                                itemCount: con.cartList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                                itemBuilder: (context, index) {
                                  printYellow(con.cartList[index].remark?.value ?? "");
                                  return ProductTile(
                                    screenType: "isCartScreen",
                                    isFancy: con.cartList[index].isDiamondMultiple ?? false,
                                    cartId: con.cartList[index].id,
                                    inventoryId: con.cartList[index].inventoryId,
                                    productsListTypeType: ProductsListType.cart,
                                    selectMetalCart: (con.cartList[index].metalId!.value).obs,
                                    diamonds: con.cartList[index].diamonds,
                                    selectDiamondCart: (con.cartList[index].diamonds != null && con.cartList[index].diamonds!.isNotEmpty) ? (con.cartList[index].diamonds?.first.diamondClarity?.value ?? "").obs : "".obs,
                                    diamondOnChanged: (value) {
                                      //   printBlue(value);
                                      //   if (value!.isNotEmpty) {
                                      //     con
                                      //         .cartList[index]
                                      //         .diamonds
                                      //         ?.first
                                      //         .diamondClarity
                                      //         ?.value = value.toString();
                                      //   }
                                    },
                                    item: con.cartList[index],
                                    category: RxString(con.cartList[index].subCategoryId ?? ""),
                                    isSizeAvailable: !isValEmpty(con.cartList[index].sizeId!.value),
                                    productTileType: ProductTileType.cartTile,
                                    diamondList: RxList(con.cartList[index].diamonds ?? []),
                                    isCartSelected: RxBool(
                                      con.selectedList.contains(
                                        con.cartList[index],
                                      ),
                                    ),
                                    remark: RxString(con.cartList[index].remark?.value ?? ""),
                                    imageUrl: (con.cartList[index].inventoryImage != null && con.cartList[index].inventoryImage!.isNotEmpty) ? con.cartList[index].inventoryImage![0] : "",
                                    productName: (con.cartList[index].inventoryName ?? ""),
                                    productPrice: con.cartList[index].inventoryTotalPrice.toString(),
                                    brandName: con.cartList[index].inventoryName ?? "Unknown",
                                    productQuantity: RxInt(con.cartList[index].quantity ?? 0),
                                    selectSize: (con.cartList[index].sizeId!.value).obs,
                                    deleteOnTap: () {
                                      //? CART DELETE API
                                      CartRepository.deleteCartAPi(cartId: con.cartList[index].id);
                                      con.calculateSelectedItemPrice();
                                      con.calculateSelectedQue();
                                      Get.back();
                                    },
                                    onChanged: (_) {
                                      if (!con.selectedList.contains(con.cartList[index])) {
                                        con.selectedList.add(con.cartList[index]);
                                        con.calculateSelectedQue();
                                      } else {
                                        con.selectedList.remove(con.cartList[index]);
                                      }
                                      con.calculateSelectedItemPrice();
                                      con.calculateSelectedQue();
                                    },
                                    metalOnChanged: (value) {
                                      con.cartList[index].metalId!.value = value;
                                    },
                                    remarkOnChanged: (value) {
                                      con.cartList[index].remark!.value = value;
                                    },
                                    sizeOnChanged: (value) {
                                      con.cartList[index].sizeId!.value = value;
                                    },
                                    onTap: () {
                                      // addProductIdToGlobalList((con.cartList[index].id ?? ""), type: GlobalProductPrefixType.cart);
                                      navigateToProductDetailsScreen(
                                        productDetails: {
                                          "productId": (con.cartList[index].id ?? ""),
                                          "diamondClarity": con.cartList[index].isDiamondMultiple == false
                                              ? (con.cartList[index].diamonds != null && con.cartList[index].diamonds!.isNotEmpty)
                                                  ? con.cartList[index].diamonds?.first.diamondClarity?.value ?? ""
                                                  : ""
                                              : "",
                                          "metalId": con.cartList[index].metalId!.value,
                                          "sizeId": con.cartList[index].sizeId!.value,
                                          "diamonds": con.cartList[index].isDiamondMultiple == true ? con.cartList[index].diamonds! : [],
                                          "type": GlobalProductPrefixType.productDetails,
                                        },
                                        type: GlobalProductPrefixType.productDetails,
                                        // arguments: {
                                        //   "category": con.cartList[index].subCategoryId ?? '',
                                        //   'isFancy': con.cartList[index].isDiamondMultiple,
                                        //   'cartId': /*AppStrings.cartIdPrefixSlug +*/
                                        //       (con.cartList[index].id ?? ""),
                                        //   "inventoryId": /*AppStrings.cartIdPrefixSlug +*/
                                        //       (con.cartList[index].inventoryId ?? ""),
                                        //   'name': con.cartList[index].inventoryName,
                                        // },
                                        arguments: {
                                          "category": /*AppStrings.cartIdPrefixSlug +*/
                                              (con.cartList[index].subCategoryId ?? ''),
                                          'isSize': !isValEmpty(con.cartList[index].sizeId),
                                          'isFancy': con.cartList[index].isDiamondMultiple ?? false,
                                          'cartId': /*AppStrings.cartIdPrefixSlug +*/
                                              (con.cartList[index].id ?? ""),
                                          'inventoryId': /*AppStrings.productIdPrefixSlug +*/
                                              (con.cartList[index].inventoryId ?? ""),
                                          'name': con.cartList[index].inventoryName,
                                          "productsListTypeType": ProductsListType.normal,
                                          "sizeId": con.cartList[index].sizeId!.value,
                                          "remark": con.cartList[index].remark!.value,
                                          "diamondClarity": (con.cartList[index].diamonds != null && con.cartList[index].diamonds!.isNotEmpty) ? con.cartList[index].diamonds?.first.diamondClarity?.value ?? "" : "",
                                          "metalId": con.cartList[index].metalId!.value,
                                          "diamonds": con.cartList[index].isDiamondMultiple == true ? con.cartList[index].diamonds : [],
                                        },
                                      );
                                    },
                                  );
                                },
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
                        ],
                      )
                    : ListView(
                        children: [
                          EmptyElement(
                            title: "Cart is empty",
                            padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                          ),
                        ],
                      ))
                : ListView.separated(
                    itemCount: 20,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(defaultPadding),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                    itemBuilder: (context, index) => const CartItemShimmer(),
                  ),

            /// CART SUMMARY
            bottomNavigationBar: IntrinsicHeight(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: con.cartLoader.isFalse
                    ? con.cartList.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.only(top: defaultPadding, bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(defaultRadius),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                  child: Column(
                                    children: [
                                      cartSummaryItem(
                                        context,
                                        title: "Cart Items",
                                        price: "${con.selectedList.length}/${con.cartDetail.value.totalItems}",
                                      ),
                                      cartSummaryItem(
                                        context,
                                        title: "Cart Quantity",
                                        price: "${con.selectedQuantity.value}/${con.cartDetail.value.totalQuantity}",
                                      ),
                                      cartSummaryItem(
                                        context,
                                        title: "Cart Amount",
                                        price: "${UiUtils.amountFormat(con.selectedPrice.value, decimalDigits: 0)} / ${UiUtils.amountFormat(con.cartDetail.value.totalPrice, decimalDigits: 0)}",
                                      ),
                                      (defaultPadding / 2).verticalSpace,
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(AppRoutes.summaryScreen);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(7.w),
                                              margin: EdgeInsets.only(right: defaultPadding / 2),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(defaultRadius / 1.5),
                                              ),
                                              child: SvgPicture.asset(
                                                AppAssets.summaryIcon,
                                                height: 22.h,
                                                color: Theme.of(context).colorScheme.surface, // ignore: deprecated_member_use
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: AppButton(
                                              padding: EdgeInsets.only(right: defaultPadding / 2),
                                              backgroundColor: con.selectedList.isEmpty ? AppColors.lightGrey : AppColors.primary,
                                              height: 30.h,
                                              flexibleWidth: true,
                                              title: "Check - out",
                                              disableButton: con.selectedList.isEmpty,
                                              titleStyle: AppTextStyle.appButtonStyle(context).copyWith(
                                                color: con.selectedList.isEmpty ? null : Theme.of(context).colorScheme.surface,
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRoutes.checkoutScreen,
                                                  arguments: {
                                                    "subQuantity": con.selectedQuantity.value,
                                                    "subTotal": con.selectedPrice.value,
                                                    "cartList": con.selectedList,
                                                    "totalItems": con.selectedList.length,
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: AppButton(
                                              backgroundColor: con.selectedList.isEmpty ? AppColors.lightGrey : Colors.red,
                                              height: 30.h,
                                              flexibleWidth: true,
                                              title: "Delete",
                                              disableButton: con.selectedList.isEmpty,
                                              titleStyle: AppTextStyle.appButtonStyle(context).copyWith(
                                                color: con.selectedList.isEmpty ? null : Theme.of(context).colorScheme.surface,
                                              ),
                                              onPressed: () {
                                                AppDialogs.cartDialog(context, contentText: "Are you sure?\nYou want to remove this item from the cart?", buttonTitle: "NO", onPressed: () async {
                                                  Get.back();

                                                  //? Delete cart list api
                                                  // if (con.cartList.length ==
                                                  //     con.selectedList.length) {
                                                  // await CartRepository
                                                  //     .deleteCartAPi();
                                                  // } else {
                                                  List<String> selectedCartIds = con.selectedList.map((item) => item.id ?? "").toList();

                                                  await CartRepository.multipleCartDelete(selectedCartIds: selectedCartIds);
                                                }
                                                    // },
                                                    );
                                                con.calculateSelectedItemPrice();
                                                con.calculateSelectedQue();
                                                con.selectedList.refresh();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox()
                    : const SizedBox(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cartSummaryItem(BuildContext context, {required String title, required String price}) {
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding / 2),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            price,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
