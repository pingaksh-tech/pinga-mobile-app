import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../exports.dart';
import '../../packages/marquee_widget/marquee_widget.dart';
import '../../res/empty_element.dart';
import 'components/order_simmer_tile.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController con = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              con.isLoading.isFalse
                  ? (con.orderProductList.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            controller: con.scrollController,
                            padding: EdgeInsets.all(defaultPadding / 1.5),
                            itemCount: con.orderProductList.length,
                            separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                    defaultRadius,
                                  ),
                                  boxShadow: defaultShadowAllSide,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.openBox,
                                            colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                                            height: 27.sp,
                                          ),
                                          (defaultPadding / 2).horizontalSpace,
                                          Column(
                                            children: [
                                              Text(
                                                "71205484114-1/1",
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 0),
                                              ),
                                              Text(
                                                DateFormat('MM/dd/yyyy HH:mm:ss').format(con.orderProductList[index].createdAt ?? DateTime.now()),
                                                style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.sp),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      orderDetailsKeyValuePairWidget1(
                                        context,
                                        title: "Name",
                                        subtitleText: con.orderProductList[index].products?.first.product?.title ?? "",
                                        titleFlex: 2,
                                        subTitleFlex: 8,
                                      ),
                                      SizedBox(height: defaultPadding / 2),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "EMR ID",
                                              subtitleText: "0/24/PNK/39536",
                                              subTitleFlex: 4,
                                              titleFlex: 3,
                                            ),
                                          ),
                                          defaultPadding.horizontalSpace,
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "Quantity",
                                              subtitleText: (con.orderProductList[index].products?.first.quantity ?? 0).toString(),
                                              titleFlex: 3,
                                              subTitleFlex: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: defaultPadding / 2),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "Total DP",
                                              subtitleText: "21632.2",
                                              subTitleFlex: 4,
                                              titleFlex: 3,
                                            ),
                                          ),
                                          defaultPadding.horizontalSpace,
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "MRP",
                                              subtitleText: UiUtils.amountFormat(
                                                (con.orderProductList[index].products?.first.price ?? 0).toString(),
                                                decimalDigits: 2,
                                              ),
                                              titleFlex: 3,
                                              subTitleFlex: 4,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Expanded(
                          child: EmptyElement(
                            title: "No orders found",
                            imagePath: AppAssets.emptyData,
                          ),
                        ))
                  : Expanded(
                      child: ListView.separated(
                        itemCount: 20,
                        padding: EdgeInsets.all(defaultPadding),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                        itemBuilder: (context, index) => const OrderShimmerTile(),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(20),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultRadius),
            ),
          ),
          child: Column(
            children: [
              orderSummaryItem(context, title: "Total items", subTitle: "5"),
              orderSummaryItem(context, title: "Total DP", subTitle: UiUtils.amountFormat("219850", decimalDigits: 0)),
              orderSummaryItem(context, title: "Total Amount", subTitle: UiUtils.amountFormat("284523", decimalDigits: 0)),
            ],
          ),
        ),
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
      children: [
        Expanded(
          flex: titleFlex ?? 0,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
                ),
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
              ),
        ).paddingOnly(right: defaultPadding / 2),
        Expanded(
          flex: subTitleFlex ?? 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: MarqueeWidget(
              child: Text(
                subtitleText,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget orderSummaryItem(BuildContext context, {required String title, required String subTitle}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Text(
          subTitle,
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
