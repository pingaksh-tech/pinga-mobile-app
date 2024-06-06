import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/empty_element.dart';
import '../../widgets/custom_check_box_tile.dart';
import '../../widgets/product_tile.dart';
import 'cart_controller.dart';
import 'components/cart_item_simmer.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController con = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: Get.currentRoute == AppRoutes.cartScreen
            ? MyAppBar(
                title: "My Cart",
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          insetPadding: EdgeInsets.only(right: defaultPadding),
                          alignment: Alignment.topRight,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                dialogText(
                                  context,
                                  title: "Download cart items",
                                  onTap: () {},
                                ),
                                dialogText(
                                  context,
                                  title: "Add to watchList",
                                  onTap: () {},
                                ),
                                dialogText(
                                  context,
                                  title: "Clear cart",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            : null,
        body: con.isLoading.isFalse
            ? (con.productsList.isNotEmpty
                ? ListView(
                    children: [
                      CustomCheckboxTile(
                        title: "Select all items",
                        isSelected: RxBool(false),
                        titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        scale: 1.1,
                        borderWidth: 1.6,
                      ).paddingOnly(left: defaultPadding * 1.5),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding).copyWith(top: 0),
                        itemCount: con.productsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(height: 0.9),
                        itemBuilder: (context, index) => ProductTile(
                          productTileType: ProductTileType.cartTile,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.productDetailsScreen,
                              arguments: {},
                            );
                          },
                          imageUrl: con.productsList[index].product?.productImages?[0].image ?? "",
                          productName: (con.productsList[index].product?.title ?? ""),
                          productPrice: con.productsList[index].product?.price.toString() ?? "",
                          brandName: con.productsList[index].product?.brandName ?? "Unknown",
                        ),
                        /* GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.productDetailsScreen,
                              arguments: {},
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 1.2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.topLeft,
                                  children: [
                                    con.productsList[index].product?.productImages != null && con.productsList[index].product!.productImages!.isNotEmpty
                                        ? AppNetworkImage(
                                            height: imageWidth,
                                            width: imageWidth,
                                            fit: BoxFit.cover,
                                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(defaultRadius),
                                            imageUrl: /* "https://i.pinimg.com/564x/0c/10/de/0c10defc33ccee0ec274d5cd3c761273.jpg"*/ con.productsList[index].product?.productImages?[0].image ?? "",
                                          )
                                        : SizedBox(
                                            width: imageWidth,
                                            height: imageWidth,
                                          ),
                                    Positioned(
                                      top: -12.h,
                                      left: -5.w,
                                      child: CustomCheckboxTile(
                                        isSelected: RxBool(false),
                                      ),
                                    ),
                                  ],
                                ),
                                (defaultPadding / 2).horizontalSpace,
                                Expanded(
                                  child: Obx(
                                    () => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (con.productsList[index].product?.title ?? ""),
                                                    maxLines: 2,
                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                                                  ),
                                                  Text(
                                                    'Brand: ${con.productsList[index].product?.brandName ?? "Unknown"}',
                                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: defaultPadding, top: defaultPadding / 5),
                                                    child: Text(
                                                      UiUtils.amountFormat(con.productsList[index].product?.price.toString() ?? ""),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [],
                                                ),
                                                plusMinusTile(
                                                  context,
                                                  size: 20,
                                                  textValue: RxInt(1),
                                                  onIncrement: (p0) {},
                                                  onDecrement: (p0) {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        (defaultPadding / 3).verticalSpace,
                                        Row(
                                          children: [
                                            horizontalSelectorButton(
                                              context,
                                              selectedSize: RxString(con.sizeModel.size ?? ""),
                                              selectableItemType: SelectableItemType.size,
                                              sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                                              isFlexible: true,
                                              axisDirection: Axis.vertical,
                                              sizeOnChanged: (value) {
                                                /// Return Selected Size
                                                if ((value.runtimeType == SizeModel)) {
                                                  con.sizeModel = value;
                                                }
                                              },
                                            ),
                                            (defaultPadding / 4).horizontalSpace,
                                            horizontalSelectorButton(
                                              context,
                                              selectedColor: RxString(con.colorModel.color ?? ""),
                                              selectableItemType: SelectableItemType.color,
                                              sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                                              isFlexible: true,
                                              axisDirection: Axis.vertical,
                                              colorOnChanged: (value) {
                                                /// Return Selected Color
                                                if ((value.runtimeType == ColorModel)) {
                                                  con.colorModel = value;
      
                                                  printYellow(con.colorModel);
                                                }
                                              },
                                            ),
                                            (defaultPadding / 4).horizontalSpace,
                                            horizontalSelectorButton(
                                              context,
                                              isFlexible: true,
                                              axisDirection: Axis.vertical,
                                              remarkSelected: con.selectedRemark,
                                              selectableItemType: SelectableItemType.remarks,
                                              sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                                              remarkOnChanged: (value) {
                                                con.selectedRemark.value = value;
                                              },
                                            ),
                                            (defaultPadding / 4).horizontalSpace,
                                            horizontalSelectorButton(
                                              context,
                                              selectedDiamond: "SOL".obs,
                                              selectableItemType: SelectableItemType.diamond,
                                              isFlexible: true,
                                              axisDirection: Axis.vertical,
                                              sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                                              rubyOnChanged: (value) {
                                                /// Return Selected Diamond
                                                if ((value.runtimeType == Diamond)) {
                                                  con.diamondModel = value;
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) */
                      )

                      /// CART SUMMARY
                      // IntrinsicHeight(
                      //   child: Obx(
                      //     () => AnimatedSwitcher(
                      //       duration: const Duration(milliseconds: 350),
                      //       child: con.isLoading.isFalse
                      //           ? con.productsList.isNotEmpty
                      //               ? Container(
                      //                   decoration: BoxDecoration(
                      //                     color: Theme.of(context).primaryColor.withOpacity(.1),
                      //                     borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Container(
                      //                         padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      //                         child: Column(
                      //                           children: [
                      //                             (defaultPadding / 1.5).verticalSpace,
                      //                             paymentSummaryItem(context, title: "Sub Total", price: con.totalPrice.value),
                      //                             paymentSummaryItem(context, title: "Tax", price: 0.0),
                      //                             const Divider(height: 1),
                      //                             (defaultPadding / 1.5).verticalSpace,
                      //                             paymentSummaryItem(context, title: "Total Amount", price: con.totalPrice.value, highlight: true),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       AppButton(
                      //                         padding: EdgeInsets.all(defaultPadding).copyWith(top: defaultPadding / 3),
                      //                         onPressed: () async {
                      //                           await CartRepository.placeOrderAPI();
                      //                         },
                      //                         child: Padding(
                      //                           padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      //                           child: Text(
                      //                             "Order Now",
                      //                             style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       // (defaultPadding / 2).verticalSpace
                      //                     ],
                      //                   ),
                      //                 )
                      //               : const SizedBox()
                      //           : const SizedBox(),
                      //     ),
                      //   ),
                      // )
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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                              child: Column(
                                children: [
                                  paymentSummaryItem(
                                    context,
                                    title: "Cart items",
                                    price: "0/10",
                                  ),
                                  paymentSummaryItem(
                                    context,
                                    title: "Cart quantity",
                                    price: "0/1185",
                                  ),
                                  paymentSummaryItem(
                                    context,
                                    title: "Cart amount",
                                    price: "${UiUtils.amountFormat("0", decimalDigits: 0)} / ${UiUtils.amountFormat("300215", decimalDigits: 0)}",
                                  ),
                                  (defaultPadding / 2).verticalSpace,
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(7.w),
                                          margin: EdgeInsets.only(right: defaultPadding / 2),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              defaultRadius / 1.5,
                                            ),
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
                                          backgroundColor: AppColors.lightGrey,
                                          height: 30.h,
                                          flexibleWidth: true,
                                          title: "Check - out",
                                          titleStyle: AppTextStyle.appButtonStyle(context),
                                        ),
                                      ),
                                      Expanded(
                                        child: AppButton(
                                          backgroundColor: AppColors.lightGrey,
                                          height: 30.h,
                                          flexibleWidth: true,
                                          title: "Delete",
                                          titleStyle: AppTextStyle.appButtonStyle(context),
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

  Widget paymentSummaryItem(BuildContext context, {required String title, required String price}) {
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

  Widget dialogText(
    BuildContext context, {
    required String title,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Theme.of(context).primaryColor,
            ),
      ).paddingOnly(bottom: defaultPadding),
    );
  }

  Widget counterWidget(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
    required bool isDisable,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.all(4.sp),
        duration: const Duration(microseconds: 300),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(defaultRadius),
          color: Theme.of(context).colorScheme.secondary.withOpacity(isDisable ? 0.01 : 0.15),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary.withOpacity(isDisable ? 0.5 : 1),
          size: 20,
        ),
      ),
    );
  }
}
/* 
Dismissible(
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        con.removeProductFromCart(context, index: index);
                                      },
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: Theme.of(context).colorScheme.error,

                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(right: 20), // Background color when swiping
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete_outline,
                                              color: Theme.of(context).colorScheme.surface,
                                              size: 22.sp,
                                            ),
                                            (defaultPadding / 4).verticalSpace,
                                            Text(
                                              "Remove",
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    color: Theme.of(context).colorScheme.surface,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            )
                                          ],
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.productDetailsScreen,
                                            arguments: {
                                              // "brandName": con.brandList[index]["brandName"],
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 1.5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.surface /*  Colors.red.withOpacity(0.45)*/,
                                            // borderRadius: BorderRadius.circular(defaultRadius),
                                            // boxShadow: defaultShadow(context),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              con.productsList[index].product?.productImages != null && con.productsList[index].product!.productImages!.isNotEmpty
                                                  ? AppNetworkImage(
                                                      height: imageWidth,
                                                      width: imageWidth,
                                                      fit: BoxFit.cover,
                                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                      borderRadius: BorderRadius.circular(defaultRadius),
                                                      imageUrl: /* "https://i.pinimg.com/564x/0c/10/de/0c10defc33ccee0ec274d5cd3c761273.jpg"*/ con.productsList[index].product?.productImages?[0].image ?? "",
                                                    )
                                                  : SizedBox(
                                                      width: imageWidth,
                                                      height: imageWidth,
                                                    ),
                                              (defaultPadding / 2).horizontalSpace,
                                              Expanded(
                                                child: Obx(
                                                  () => Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              (con.productsList[index].product?.title ?? ""),
                                                              maxLines: 2,
                                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // (defaultPadding / 5).verticalSpace,
                                                      Text(
                                                        'Brand: ${con.productsList[index].product?.brandName ?? "Unknown"}',
                                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      (defaultPadding / 4).verticalSpace,
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(right: defaultPadding),
                                                              child: Text(
                                                                UiUtils.amountFormat(con.productsList[index].product?.price.toString() ?? ""),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          /// QUANTITY
                                                          Row(
                                                            children: [
                                                              counterWidget(
                                                                context,
                                                                icon: con.productsList[index].quantity < 2 ? Icons.delete_outline : Icons.remove,
                                                                isDisable: /*con.productsList[index].quantity.value.isLowerThan(2) ? true : false*/ false,
                                                                onTap: () async {
                                                                  if (!con.productsList[index].quantity.value.isLowerThan(2)) {
                                                                    con.productsList[index].quantity -= 1;
                                                                    if (con.updateCartDebounce?.isActive ?? false) con.updateCartDebounce?.cancel();
                                                                    con.updateCartDebounce = Timer(
                                                                      const Duration(milliseconds: 300),
                                                                      () async {
                                                                        await CartRepository.updateQuantityAPI(productId: con.productsList[index].product?.id ?? "", doIncrease: false);
                                                                      },
                                                                    );
                                                                  } else {
                                                                    /// REMOVE PRODUCT FROM CART
                                                                    con.removeProductFromCart(context, index: index);
                                                                  }
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                                                child: AnimatedFlipCounter(
                                                                  value: con.productsList[index].quantity.value,
                                                                  duration: const Duration(milliseconds: 200),
                                                                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12.sp),
                                                                ),
                                                              ),
                                                              counterWidget(
                                                                context,
                                                                icon: Icons.add,
                                                                isDisable: con.productsList[index].quantity.value.isGreaterThan(19) ? true : false,
                                                                onTap: () {
                                                                  if (!con.productsList[index].quantity.value.isGreaterThan(19)) {
                                                                    con.productsList[index].quantity += 1;
                                                                    if (con.updateCartDebounce?.isActive ?? false) con.updateCartDebounce?.cancel();
                                                                    con.updateCartDebounce = Timer(
                                                                      const Duration(milliseconds: 300),
                                                                      () async {
                                                                        await CartRepository.updateQuantityAPI(productId: con.productsList[index].product?.id ?? "", doIncrease: true);
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      // (defaultPadding / 2).verticalSpace,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
 */
/* AppButton(
                              padding: EdgeInsets.all(defaultPadding).copyWith(top: defaultPadding / 3),
                              onPressed: () async {
                                await CartRepository.placeOrderAPI();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                child: Text(
                                  "Order Now",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1),
                                ),
                              ),
                            ), */
