import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/repositories/orders/orders_repository.dart';
import '../../exports.dart';
import '../../packages/cached_network_image/cached_network_image.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              Align(
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
              ),
              con.isLoading.isFalse
                  ? (con.orderProductList.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            controller: con.scrollController,
                            padding: EdgeInsets.all(defaultPadding / 1.5).copyWith(top: defaultPadding / 2),
                            separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order ID : FN84561435851",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(/*fontWeight: FontWeight.w600*/ fontSize: 12.sp, color: AppColors.subText),
                                  ),
                                  (defaultPadding / 10).verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(
                                      //   AppRoutes.orderProductDetailScreen,
                                      //   arguments: {
                                      //     "productDetail": con.orderProductList[index],
                                      //     "isOrder": true,
                                      //   },
                                      // );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(defaultPadding / 2),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface /*Colors.red*/,
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        boxShadow: [
                                          BoxShadow(color: Theme.of(context).iconTheme.color!.withOpacity(0.05), blurRadius: 10, spreadRadius: 1),
                                        ],
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              con.orderProductList[index].products?[0].product?.productImages != null && con.orderProductList[index].products![0].product!.productImages!.isNotEmpty
                                                  ? AppNetworkImage(
                                                      height: imageWidth,
                                                      width: imageWidth,
                                                      fit: BoxFit.cover,
                                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                      borderRadius: BorderRadius.circular(defaultRadius),
                                                      imageUrl: "https://i.pinimg.com/564x/0c/10/de/0c10defc33ccee0ec274d5cd3c761273.jpg" /* con.orderProductList[index].products?[0].product?.productImages?[0].image ?? ""*/,
                                                    )
                                                  : SizedBox(height: imageWidth, width: imageWidth),
                                              SizedBox(width: defaultPadding / 2),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    orderDetailsKeyValuePairWidget(context, key: "Order No", value: "#${con.orderProductList[index].id.toString()}"),
                                                    orderDetailsKeyValuePairWidget(context, key: "Quantity", value: con.orderProductList[index].products?.length.toString() ?? ""),
                                                    // const SizedBox(height: 3),
                                                    // Text(
                                                    //   con.orderProductList[index].products?[0].title ?? "",
                                                    //   maxLines: 1,
                                                    //   overflow: TextOverflow.ellipsis,
                                                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
                                                    // ),
                                                    5.verticalSpace,
                                                    Text(
                                                      UiUtils.amountFormat(con.orderProductList[index].totalAmount.toString()),
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 13.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Order On: ",
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                    ),
                                                    TextSpan(
                                                      text: DateFormat('MM/dd/y h:mm a').format(con.orderProductList[index].products?[0].product?.createdAt ?? DateTime.now()),
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(defaultRadius / 2),
                                                  color: con.orderProductList[index].status?.toLowerCase() == OrderStatus.rejected.name ? Colors.red.withOpacity(.1) : (con.orderProductList[index].status?.toLowerCase() == OrderStatus.pending.name ? Colors.orangeAccent.withOpacity(.1) : Colors.green.withOpacity(.1)),
                                                ),
                                                child: Text(
                                                  con.orderProductList[index].status?.toUpperCase() ?? "",
                                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                        color: con.orderProductList[index].status?.toLowerCase() == OrderStatus.rejected.name ? Colors.red.withOpacity(.7) : (con.orderProductList[index].status?.toLowerCase() == OrderStatus.pending.name ? Colors.orange.withOpacity(.8) : Colors.green),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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

  Widget orderDetailsKeyValuePairWidget(
    BuildContext context, {
    required String key,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$key : ",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),
          TextSpan(
            // text: "#${con.orderProductList[index].products?[0].id?.substring(14)}",
            text: value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7)),
          ),
        ],
      ),
    );
  }
}
