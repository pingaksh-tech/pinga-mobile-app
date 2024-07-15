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
                          orderDetailsKeyValuePairWidget(
                            context,
                            title: "Order No.",
                            subtitleText: !isValEmpty(con.orderDetailModel.value.order?.orderNo) ? con.orderDetailModel.value.order?.orderNo ?? "" : "",
                          ),
                          orderDetailsKeyValuePairWidget(
                            context,
                            title: "Order Date",
                            subtitleText: !isValEmpty(con.orderDetailModel.value.order?.createdAt) ? DateFormat('MM/dd/yyyy HH:mm:ss').format(con.orderDetailModel.value.order?.createdAt ?? DateTime.now()) : "",
                          ),
                          orderDetailsKeyValuePairWidget(
                            context,
                            title: "Retailer Name",
                            subtitleText: !isValEmpty(con.orderDetailModel.value.order?.retailerId?.businessName) ? con.orderDetailModel.value.order?.retailerId?.businessName ?? "" : "",
                          ),
                          orderDetailsKeyValuePairWidget(
                            context,
                            title: "Order Type",
                            subtitleText: !isValEmpty(con.orderDetailModel.value.order?.orderType) ? con.orderDetailModel.value.order?.orderType ?? "" : "",
                          ),
                          orderDetailsKeyValuePairWidget(
                            context,
                            title: "Approx. Delivery",
                            subtitleText: !isValEmpty(con.orderDetailModel.value.orderItems) ? con.orderDetailModel.value.orderItems?.first.productId?.delivery ?? "" : "gfdgfg",
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Product Detail",
                      style: AppTextStyle.titleStyle(context).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ).paddingOnly(top: defaultPadding * 2, bottom: defaultPadding / 2),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(defaultPadding / 1.5),
                          margin: EdgeInsets.only(bottom: defaultPadding / 1.5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(defaultRadius),
                            boxShadow: defaultShadowAllSide,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  (con.orderDetailModel.value.productItems?[index].inventoryImages != null && !isValEmpty(con.orderDetailModel.value.productItems?[index].inventoryImages))
                                      ? AppNetworkImage(
                                          height: Get.width * 0.18,
                                          width: Get.width * 0.18,
                                          fit: BoxFit.cover,
                                          borderRadius: BorderRadius.circular(defaultRadius),
                                          imageUrl: (con.orderDetailModel.value.productItems?[index].inventoryImages?.first != null && !isValEmpty(con.orderDetailModel.value.productItems?[index].inventoryImages?.first)) ? con.orderDetailModel.value.productItems![index].inventoryImages?.first ?? "" : "",
                                        )
                                      : Container(
                                          height: Get.width * 0.18,
                                          width: Get.width * 0.18,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(defaultRadius),
                                            color: AppColors.primary.withOpacity(0.1),
                                          ),
                                        ),
                                  (defaultPadding / 2).horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      children: [
                                        orderDetailsKeyValuePairWidget(
                                          context,
                                          title: "Name",
                                          subtitleText: con.orderDetailModel.value.orderItems?[index].productId?.name ?? "",
                                        ),
                                        orderDetailsKeyValuePairWidget(
                                          context,
                                          title: "Metal",
                                          subtitleText: "${con.orderDetailModel.value.productItems?[index].productInfo?.metal} - ${con.orderDetailModel.value.productItems?[index].productInfo?.karatage}",
                                        ),
                                        orderDetailsKeyValuePairWidget(
                                          context,
                                          title: "Diamond",
                                          subtitleText: !isValEmpty(con.orderDetailModel.value.productItems?[index].diamonds) ? (con.orderDetailModel.value.productItems?[index].diamonds?.first.diamondClarity ?? "") : "",
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
                                    child: orderDetailsKeyValuePairWidget(
                                      context,
                                      title: "Quantity",
                                      titleFlex: 4,
                                      subtitleText: con.orderDetailModel.value.orderItems?[index].qty.toString() ?? "",
                                    ),
                                  ),
                                  Expanded(
                                    child: orderDetailsKeyValuePairWidget(
                                      context,
                                      title: "MRP",
                                      subtitleText: UiUtils.amountFormat(
                                        con.orderDetailModel.value.orderItems?[index].grandTotal.toString() ?? "",
                                        decimalDigits: 2,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        itemCount: con.orderDetailModel.value.productItems?.length,
                      ),
                    ),
                  ],
                ),
              )
            : orderDetailShimmer(context),
      ),
    );
  }

  Widget orderDetailsKeyValuePairWidget(
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
