import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../packages/marquee_widget/marquee_widget.dart';
import '../../res/empty_element.dart';
import 'components/order_simmer_tile.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController con = Get.put(OrdersController());

  double get imageWidth => Get.width * 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: MyAppBar(
      //   title: "My orders",
      //   actions: [
      //     UiUtils.notificationButton(),
      //   ],
      // ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              /*   Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2.2),
                  child: Row(
                    children: List.generate(
                      con.statusList.length,
                      (index) {
                        return GestureDetector(
                          onTap: () async {
                            if (con.tabIndex.value != index) {
                              con.tabIndex.value = index;
                              con.selectedType.value = con.statusList[index];
                              await OrdersRepository.getAllOrdersAPI();
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2.4, vertical: defaultPadding / 1.5).copyWith(bottom: defaultPadding / 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultPadding),
                              color: con.tabIndex.value == index ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface,
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.1), width: .7),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.3, vertical: 7),
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 100),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: con.tabIndex.value == index ? Theme.of(context).colorScheme.surface : Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppTheme.fontFamilyName,
                                ),
                                child: Text(
                                  con.statusList[index].capitalize!,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ), */
              SizedBox(height: defaultPadding),
              con.isLoading.isFalse
                  ? (con.orderProductList.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            controller: con.scrollController,
                            padding: EdgeInsets.all(defaultPadding / 1.5).copyWith(top: defaultPadding / 2),
                            separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(defaultPadding / 1.5).copyWith(top: 0, right: 0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                    defaultRadius,
                                  ),
                                  boxShadow: defaultShadowAllSide,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(
                                    //   AppRoutes.orderProductDetailScreen,
                                    //   arguments: {
                                    //     "productDetail": con.orderProductList[index],
                                    //     "isOrder": true,
                                    //   },
                                    // );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.openBox,
                                            // ignore: deprecated_member_use
                                            color: Theme.of(context).primaryColor,
                                            height: 25.sp,
                                          ),
                                          (defaultPadding / 2).horizontalSpace,
                                          Column(
                                            children: [
                                              Text(
                                                "71205484114-1/1",
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 0),
                                              ),
                                              Text(
                                                "05/10/2024 02:52:10",
                                                style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.sp),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      // SizedBox(width: defaultPadding / 2),
                                      orderDetailsKeyValuePairWidget1(
                                        context,
                                        title: "Name",
                                        subtitleText: "Hari Ambe Jewellers",
                                        titleFlex: 2,
                                        subTitleFlex: 7,
                                      ),
                                      SizedBox(height: defaultPadding / 2),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "EMR ID",
                                              subtitleText: "0/24/PNK/39536",
                                              subTitleFlex: 2,
                                              titleFlex: 2,
                                            ),
                                          ),
                                          defaultPadding.horizontalSpace,
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "Quantity",
                                              subtitleText: "1.0",
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
                                              subTitleFlex: 2,
                                              titleFlex: 2,
                                            ),
                                          ),
                                          defaultPadding.horizontalSpace,
                                          Expanded(
                                            child: orderDetailsKeyValuePairWidget1(
                                              context,
                                              title: "MRP",
                                              subtitleText: "257100.0",
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: con.orderProductList.length,
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
            )),
          ),
        ),
      ],
    );
  }
}
