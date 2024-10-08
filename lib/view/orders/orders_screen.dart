import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/repositories/orders/orders_repository.dart';
import '../../exports.dart';
import '../../res/empty_element.dart';
import '../../widgets/pull_to_refresh_indicator.dart';
import 'components/order_simmer_tile.dart';
import 'components/order_tile.dart';
import 'orders_controller.dart';
import 'widgets/order_filter/order_filter_controller.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController con = Get.put(OrdersController());
  final OrderFilterController filterController =
      Get.put(OrderFilterController());

  @override
  Widget build(BuildContext context) {
    return PullToRefreshIndicator(
      onRefresh: () {
        filterController.clearFilter();
        return OrdersRepository.getAllOrdersAPI(isPullToRefresh: true);
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: con.isLoading.isFalse
              ? (con.orderList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: con.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(defaultPadding / 1.5),
                            itemCount: con.orderList.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: defaultPadding),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.orderDetailScreen,
                                      arguments: {
                                        "orderId": con.orderList[index].id
                                      });
                                },
                                child: OrderTile(
                                  orderId: con.orderList[index].orderNo ?? "",
                                  dateTime: con.orderList[index].createdAt ??
                                      DateTime.now(),
                                  customerName: con.orderList[index].retailer
                                          ?.businessName ??
                                      "",
                                  quantity: con.orderList[index].qty.toString(),
                                  mrpPrice: con.orderList[index].grandTotal
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),

                        /// PAGINATION LOADER
                        Visibility(
                          visible: con.paginationLoading.isTrue,
                          child: const OrderShimmerTile(),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        EmptyElement(
                          title: "No orders found",
                          padding:
                              EdgeInsets.symmetric(vertical: Get.width / 2.5),
                        ),
                      ],
                    ))
              : ListView.separated(
                  itemCount: 20,
                  padding: EdgeInsets.all(defaultPadding),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: defaultPadding),
                  itemBuilder: (context, index) => const OrderShimmerTile(),
                ),
          bottomNavigationBar: con.isLoading.isFalse
              ? con.orderList.isNotEmpty
                  ? IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.all(defaultPadding).copyWith(
                            bottom: MediaQuery.of(context).padding.bottom +
                                defaultPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(defaultRadius),
                          ),
                        ),
                        child: Column(
                          children: [
                            orderSummaryItem(context,
                                title: "Total Items",
                                subTitle: con.orderCounts.value.totalCount
                                    .toString()),
                            // orderSummaryItem(context, title: "Total DP", subTitle: UiUtils.amountFormat("219850", decimalDigits: 0)),
                            orderSummaryItem(context,
                                title: "Total Amount",
                                subTitle: UiUtils.amountFormat(
                                    con.orderCounts.value.totalAmount
                                        .toString(),
                                    decimalDigits: 0)),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget orderSummaryItem(BuildContext context,
      {required String title, required String subTitle}) {
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
