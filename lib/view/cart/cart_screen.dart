import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../res/empty_element.dart';
import '../../widgets/custom_check_box_tile.dart';
import '../../widgets/product_tile.dart';
import 'cart_controller.dart';
import 'components/cart_item_simmer.dart';
import 'components/cart_popup_menu.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController con = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: Get.currentRoute == AppRoutes.cartScreen
            ? MyAppBar(
                title: "My Cart",
                actions: [
                  CartPopUpMenu(),
                ],
              )
            : null,
        body: con.isLoading.isFalse
            ? (con.productsList.isNotEmpty
                ? ListView(
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
                          isSelected: RxBool(con.selectedList.length == con.productsList.length),
                          titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          scale: 1.1,
                          borderWidth: 1.6,
                          onChanged: (_) {
                            if (con.selectedList.length != con.productsList.length) {
                              con.selectedList.addAll(con.productsList.where((item) => !con.selectedList.contains(item)));
                            } else {
                              con.selectedList.clear();
                            }
                            con.calculateSelectedItemPrice();
                            con.calculateSelectedQue();
                          },
                        ).paddingOnly(left: defaultPadding),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding),
                        itemCount: con.productsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                        itemBuilder: (context, index) {
                          return ProductTile(
                            item: con.productsList[index],
                            productTileType: ProductTileType.cartTile,
                            categorySlug: "ring",
                            isCartSelected: RxBool(con.selectedList.contains(con.productsList[index])),
                            imageUrl: con.productsList[index].product?.productImages?[0].image ?? "",
                            productName: (con.productsList[index].product?.title ?? ""),
                            productPrice: con.productsList[index].product?.price.toString() ?? "",
                            brandName: con.productsList[index].product?.brandName ?? "Unknown",
                            productQuantity: con.productsList[index].quantity,
                            deleteOnTap: () {
                              if (con.selectedList.contains(con.productsList[index])) {
                                con.selectedList.remove(con.productsList[index]);
                                con.calculateSelectedQue();
                              }
                              con.productsList.removeAt(index);
                              con.calculateSelectedItemPrice();
                              con.calculateSelectedQue();
                              Get.back();
                            },
                            onChanged: (_) {
                              if (!con.selectedList.contains(con.productsList[index])) {
                                con.selectedList.add(con.productsList[index]);
                                con.calculateSelectedQue();
                              } else {
                                con.selectedList.remove(con.productsList[index]);
                              }
                              con.calculateSelectedItemPrice();
                              con.calculateSelectedQue();
                            },
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.productDetailsScreen,
                                arguments: {},
                              );
                            },
                          );
                        },
                      )
                    ],
                  )
                : const EmptyElement(
                    title: "Cart is empty",
                    imagePath: AppAssets.emptyData,
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
            child: con.isLoading.isFalse
                ? con.productsList.isNotEmpty
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
                                    title: "Cart items",
                                    price: "${con.selectedList.length}/${con.productsList.length}",
                                  ),
                                  cartSummaryItem(
                                    context,
                                    title: "Cart quantity",
                                    price: "${con.selectedQuantity.value}/${con.totalQuantity.value}",
                                  ),
                                  cartSummaryItem(
                                    context,
                                    title: "Cart amount",
                                    price: "${UiUtils.amountFormat(con.selectedPrice.value, decimalDigits: 0)} / ${UiUtils.amountFormat(con.totalPrice.value, decimalDigits: 0)}",
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
                                            AppDialogs.cartDialog(
                                              context,
                                              contentText: "Your service is temporary disable,Please contact to back office!",
                                              dialogTitle: "Alert",
                                              buttonTitle2: "OK",
                                              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                              onPressed: () => Get.back(),
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
                                            AppDialogs.cartDialog(
                                              context,
                                              contentText: "Are you sure\nYou want to remove this item from the cart?",
                                              buttonTitle: "NO",
                                              onPressed: () {
                                                Get.back();
                                                con.productsList.removeWhere((item) => con.selectedList.contains(item));
                                                con.selectedList.clear();
                                              },
                                            );
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
