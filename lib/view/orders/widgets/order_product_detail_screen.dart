import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../exports.dart';
import '../../../packages/animated_counter/animated_counter.dart';
import '../../../res/empty_element.dart';
import '../my_order_controller.dart';

class OrderProductDetailScreen extends StatelessWidget {
  OrderProductDetailScreen({super.key});

  final OrderProductDetailController con = Get.put(OrderProductDetailController());

  // final ProfileController profileCon = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: MyAppBar(
      //   title: "Details",
      // ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: Color(0xffFEF5EC),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Created At: ",
                      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(
                        con.orderProductDetail.value.products![0].product?.createdAt ?? DateTime.now(),
                      ),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 13.sp,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                Text(
                  con.orderProductDetail.value.status?.toUpperCase() ?? "",
                  style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: con.orderProductDetail.value.status == "rejected"
                            ? Colors.red
                            : con.orderProductDetail.value.status == "pending"
                                ? const Color(0xffF07E01)
                                : Colors.green,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID : ${con.orderProductDetail.value.id}",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff333333),
                      ),
                ),
                SizedBox(height: defaultPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dishank Gajera",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        launchInDialPad(
                          Uri.parse("tel://+917777990666"),
                        );
                      },
                      mini: true,
                      elevation: 0,
                      child: Icon(Icons.call, color: Theme.of(context).colorScheme.surface),
                    ),
                  ],
                ),
                Text(
                  /*profileCon.userDetails.value.data?.user?.shippingAddress ?? ""*/ "256, TGB House, Yogi Chowk, surat 394101",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff333333),
                      ),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.4),
                ),
                SizedBox(height: 12.sp),
                Text(
                  "Order Items",
                  style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 12.sp),
                con.orderProductDetail.value.products!.isNotEmpty
                    ? Stack(
                        children: [
                          ListView.separated(
                            itemCount: con.orderProductDetail.value.products?.length ?? 0,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.all(defaultPadding / 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(defaultRadius),
                                // boxShadow: defaultShadow,
                              ),
                              child: Row(
                                children: [
                                  con.orderProductDetail.value.products?[index].product?.productImages != null && con.orderProductDetail.value.products![index].product!.productImages!.isNotEmpty
                                      ? AppNetworkImage(
                                          height: Get.width * 0.21,
                                          width: Get.width * 0.21,
                                          fit: BoxFit.fitWidth,
                                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(defaultRadius),
                                          imageUrl: con.orderProductDetail.value.products?[index].product?.productImages?[0].image ?? "",
                                        )
                                      : SizedBox(height: Get.width * 0.21, width: Get.width * 0.21),
                                  SizedBox(width: defaultPadding / 1.5),
                                  Expanded(
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  con.orderProductDetail.value.products?[index].product?.title ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
                                                ),
                                              ),
                                              // AppIconButton(
                                              //   icon: SvgPicture.asset(
                                              //     AppAssets.trash,
                                              //     height: 20,
                                              //     color: Colors.red,
                                              //   ),
                                              //   onPressed: () async {
                                              //     await CartDialogs.cartItemRemoveDialog(
                                              //       context: context,
                                              //       deleteNote: "Would you like to remove item form cart?",
                                              //       onTap: () async {
                                              //         // await HomeRepository().addOrRemoveInCart(productID: con.productsList[index].product?.id ?? "", currentValue: true).then(
                                              //         //       (value) {
                                              //         //     Get.back();
                                              //         //     con.productsList.removeAt(index);
                                              //         //     if (Get.isRegistered<HomeController>()) {
                                              //         //       final HomeController homeCon = Get.find<HomeController>();
                                              //         //       int myIndex = homeCon.homeProductList.indexWhere((element) => element.id == con.productsList[index].product?.id);
                                              //         //       if (myIndex != -1) {
                                              //         //         homeCon.homeProductList[myIndex].cart?.value = value;
                                              //         //       }
                                              //         //     }
                                              //         //   },
                                              //         // );
                                              //       },
                                              //     );
                                              //   },
                                              // )
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            con.orderProductDetail.value.products?[index].product?.description ?? "",
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: defaultPadding / 2),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  UiUtils.amountFormat(con.orderProductDetail.value.products?[index].product?.price.toString() ?? ""),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                                                        fontSize: 14.5.sp,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  // counterWidget(
                                                  //   icon: Icons.remove,
                                                  //   isDisable:con.orderProductDetail.value.products?[index].quantity.value.isLowerThan(2) ? true : false,
                                                  //   onTap: () {
                                                  //     if (!con.productsList[index].quantity.value.isLowerThan(2)) {
                                                  //       con.productsList[index].quantity -= 1;
                                                  //       if (con.updateCartDebounce?.isActive ?? false) con.updateCartDebounce?.cancel();
                                                  //       con.updateCartDebounce = Timer(
                                                  //         const Duration(milliseconds: 300),
                                                  //             () async {
                                                  //           await CartRepository.updateQuantityAPI(productId: con.productsList[index].product?.id ?? "", doIncrease: false);
                                                  //         },
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Qty: ",
                                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                                                        ),
                                                        AnimatedFlipCounter(
                                                          value: con.orderProductDetail.value.products?[index].quantity ?? 0,
                                                          duration: const Duration(milliseconds: 200),
                                                          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // counterWidget(
                                                  //   icon: Icons.add,
                                                  //   isDisable: con.orderProductDetail.value.products![index].quantity!.isGreaterThan(19) ? true : false,
                                                  //   onTap: () {
                                                  //     if (!con.productsList[index].quantity.value.isGreaterThan(19)) {
                                                  //       con.productsList[index].quantity += 1;
                                                  //       if (con.updateCartDebounce?.isActive ?? false) con.updateCartDebounce?.cancel();
                                                  //       con.updateCartDebounce = Timer(
                                                  //         const Duration(milliseconds: 300),
                                                  //             () async {
                                                  //           await CartRepository.updateQuantityAPI(productId: con.productsList[index].product?.id ?? "", doIncrease: true);
                                                  //         },
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UiUtils.scrollGradient(context),
                        ],
                      )
                    : const EmptyElement(
                        title: "No orders found",
                      )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: con.orderProductDetail.value.products != null
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: 20.h, top: 20.h),
                      child: paymentSummaryItem(
                        context,
                        title: "Total Amount",
                        price: double.parse(con.orderProductDetail.value.totalAmount.toString()),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Future<void> launchInDialPad(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary.withOpacity(isDisable ? 0.5 : 1),
        ),
        child: Icon(
          icon,
          color: isDisable ? Theme.of(context).colorScheme.surface.withOpacity(0.7) : Theme.of(context).colorScheme.surface,
          size: 20,
        ),
      ),
    );
  }

  Widget paymentSummaryItem(BuildContext context, {required String title, required double price}) {
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding / 2),
      child: Row(
        children: [
          Text(
            "$title :",
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 14.5.sp, fontWeight: title == "Total Charge" ? FontWeight.w600 : FontWeight.bold),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                UiUtils.amountFormat(price.toString()),
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 14.5.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailsTile({
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.capitalize!,
            style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 13.sp, color: Colors.black),
          ),
          Text(
            value.capitalize!,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
