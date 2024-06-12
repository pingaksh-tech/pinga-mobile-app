import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/empty_element.dart';
import 'components/order_simmer_tile.dart';
import 'components/order_tile.dart';
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
                              return OrderTile(
                                orderId: "71205484114-1/1",
                                dateTime: con.orderProductList[index].createdAt ?? DateTime.now(),
                                customerName: con.orderProductList[index].products?.first.product?.title ?? "",
                                emrId: "0/24/PNK/39536",
                                quantity: "2",
                                totalDp: "12548",
                                mrpPrice: (con.orderProductList[index].products?.first.price ?? 0).toString(),
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
