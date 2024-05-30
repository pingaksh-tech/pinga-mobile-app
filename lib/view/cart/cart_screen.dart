import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/repositories/cart/cart_repository.dart';
import '../../exports.dart';
import '../../packages/animated_counter/animated_counter.dart';
import '../../packages/cached_network_image/cached_network_image.dart';
import '../../res/app_bar.dart';
import '../../res/empty_element.dart';
import 'cart_controller.dart';
import 'components/cart_item_simmer.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController con = Get.put(CartController());

  double get imageWidth => Get.width * 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Get.currentRoute == AppRoutes.cartScreen
          ? MyAppBar(
              title: "My Cart",
            )
          : null,
      body: SafeArea(
        child: Obx(
          () => con.isLoading.isFalse
              ? (con.productsList.isNotEmpty
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            // MyAppBar(
                            //   title: "Cart",
                            //   // elevation: 0,
                            // ),
                            Expanded(
                              child: ListView(
                                children: [
                                  ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                                    itemCount: con.productsList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => const Divider(height: 0.9),
                                    itemBuilder: (context, index) => Dismissible(
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
                                                    imageUrl: "https://i.pinimg.com/564x/0c/10/de/0c10defc33ccee0ec274d5cd3c761273.jpg" /* con.productsList[index].product?.productImages?[0].image ?? ""*/,
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

                                  /// CART SUMMARY
                                  IntrinsicHeight(
                                    child: Obx(
                                      () => AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 350),
                                        child: con.isLoading.isFalse
                                            ? con.productsList.isNotEmpty
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor.withOpacity(.1),
                                                      borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                                          child: Column(
                                                            children: [
                                                              (defaultPadding / 1.5).verticalSpace,
                                                              paymentSummaryItem(context, title: "Sub Total", price: con.totalPrice.value),
                                                              paymentSummaryItem(context, title: "Tax", price: 0.0),
                                                              const Divider(height: 1),
                                                              (defaultPadding / 1.5).verticalSpace,
                                                              paymentSummaryItem(context, title: "Total Amount", price: con.totalPrice.value, highlight: true),
                                                            ],
                                                          ),
                                                        ),
                                                        AppButton(
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
                                                        ),
                                                        // (defaultPadding / 2).verticalSpace
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: UiUtils.scrollGradient(context, isBottom: true),
                        // ),
                      ],
                    )
                  : EmptyElement(
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
        ),
      ),

      /// CART SUMMARY
      // bottomNavigationBar: IntrinsicHeight(
      //   child: Obx(
      //     () => AnimatedSwitcher(
      //       duration: const Duration(milliseconds: 350),
      //       child: con.isLoading.isFalse
      //           ? con.productsList.isNotEmpty
      //               ? Container(
      //                   decoration: BoxDecoration(
      //                     color: Theme.of(context).primaryColor.withOpacity(.1),
      //                     /* gradient: LinearGradient(
      //                       begin: Alignment.bottomCenter,
      //                       end: Alignment.topCenter,
      //                       stops: const [0.0, 1],
      //                       colors: [
      //                         Colors.white,
      //                         Theme.of(context).primaryColor.withOpacity(.1),
      //                       ],
      //                     ),*/
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
      //                     ],
      //                   ),
      //                 )
      //               : const SizedBox()
      //           : const SizedBox(),
      //     ),
      //   ),
      // ),
    );
  }

  Widget paymentSummaryItem(BuildContext context, {required String title, required double price, bool highlight = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding / 2),
      child: Row(
        children: [
          Text(
            "$title :",
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: (highlight ? 14 : 13).sp, fontWeight: highlight ? FontWeight.w600 : FontWeight.w500),
          ),
          const Spacer(),
          Text(
            UiUtils.amountFormat(price.toString()),
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: (highlight ? 14 : 13).sp, fontWeight: highlight ? FontWeight.w600 : FontWeight.w500),
          ),
        ],
      ),
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
