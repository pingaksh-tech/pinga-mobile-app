import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_network_image.dart';
import 'order_detail_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({super.key});

  final OrderDetailController con = Get.put(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: con.orderDetailModel.value.order?.orderNo,
        ),
        body: con.isLoading.isFalse
            ? Padding(
                padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Detail",
                      style: AppTextStyle.titleStyle(context).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ).paddingOnly(bottom: defaultPadding / 2),
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                          defaultRadius,
                        ),
                        boxShadow: defaultShadowAllSide,
                      ),
                      child: Column(
                        children: [
                          orderDetailsKeyValuePairWidget1(
                            context,
                            title: "Order No.",
                            subtitleText: con.orderDetailModel.value.order?.orderNo ?? "",
                          ),
                          orderDetailsKeyValuePairWidget1(
                            context,
                            title: "Order Date",
                            subtitleText: DateFormat('MM/dd/yyyy HH:mm:ss').format(con.orderDetailModel.value.order?.createdAt ?? DateTime.now()),
                          ),
                          orderDetailsKeyValuePairWidget1(
                            context,
                            title: "Retailer Name",
                            subtitleText: con.orderDetailModel.value.order?.retailerId?.businessName ?? "",
                          ),
                          orderDetailsKeyValuePairWidget1(
                            context,
                            title: "Order Type",
                            subtitleText: con.orderDetailModel.value.order?.orderType ?? "",
                          ),
                          orderDetailsKeyValuePairWidget1(
                            context,
                            title: "Approx. Delivery",
                            subtitleText: con.orderDetailModel.value.orderItems?.first.productId?.delivery ?? "",
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Product Detail",
                      style: AppTextStyle.titleStyle(context).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ).paddingOnly(top: defaultPadding * 2, bottom: defaultPadding / 2),
                    Container(
                      padding: EdgeInsets.all(defaultPadding / 1.5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(defaultRadius),
                        boxShadow: defaultShadowAllSide,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppNetworkImage(
                                height: Get.width * 0.18,
                                width: Get.width * 0.18,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(defaultRadius),
                                imageUrl: con.orderDetailModel.value.orderItems?.first.productId?.inventoryImages?.first ?? "",
                              ),
                              (defaultPadding / 2).horizontalSpace,
                              Expanded(
                                child: Column(
                                  children: [
                                    orderDetailsKeyValuePairWidget1(
                                      context,
                                      title: "Name",
                                      subtitleText: con.orderDetailModel.value.orderItems?.first.productId?.name ?? "",
                                    ),
                                    orderDetailsKeyValuePairWidget1(
                                      context,
                                      title: "Metal",
                                      subtitleText: "${con.orderDetailModel.value.productItems?.first.productInfo?.metal} - ${con.orderDetailModel.value.productItems?.first.productInfo?.karatage}",
                                    ),
                                    orderDetailsKeyValuePairWidget1(
                                      context,
                                      title: "Diamond",
                                      subtitleText: con.orderDetailModel.value.productItems?.first.diamonds?.first.diamondClarity ?? "",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          (defaultPadding / 5).verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: orderDetailsKeyValuePairWidget1(
                                  context,
                                  title: "Quantity",
                                  titleFlex: 4,
                                  subtitleText: con.orderDetailModel.value.order?.qty.toString() ?? "",
                                ),
                              ),
                              Expanded(
                                child: orderDetailsKeyValuePairWidget1(
                                  context,
                                  title: "MRP",
                                  subtitleText: UiUtils.amountFormat(
                                    con.orderDetailModel.value.order?.subTotal,
                                    decimalDigits: 2,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : orderDetailShimmer(context),
      ),
    );
  }

  Widget orderDetailsKeyValuePairWidget1(
    BuildContext context, {
    required String title,
    required String subtitleText,
    int? titleFlex,
    int? subTitleFlex,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: titleFlex ?? 3,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.font.withOpacity(.5),
                ),
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
              ),
        ).paddingOnly(right: defaultPadding),
        Expanded(
          flex: subTitleFlex ?? 7,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              subtitleText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font),
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: defaultPadding / 5);
  }

  Widget orderDetailShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              borderRadius: BorderRadius.circular(defaultRadius),
              height: 17.h,
              width: Get.width / 3,
            ),
          ),
          (defaultPadding / 2).verticalSpace,
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              borderRadius: BorderRadius.circular(defaultRadius),
              height: 160.h,
            ),
          ),
          (defaultPadding).verticalSpace,
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              borderRadius: BorderRadius.circular(defaultRadius),
              height: 17.h,
              width: Get.width / 3,
            ),
          ),
          (defaultPadding / 2).verticalSpace,
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              borderRadius: BorderRadius.circular(defaultRadius),
              height: 110.h,
            ),
          ),
        ],
      ),
    );
  }
}
