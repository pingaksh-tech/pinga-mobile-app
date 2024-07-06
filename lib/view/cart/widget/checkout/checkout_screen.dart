import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/predefine_value_controller.dart';
import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/orders/orders_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_dialog.dart';
import '../../../bottombar/bottombar_controller.dart';
import 'checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final CheckoutController con = Get.put(CheckoutController());
  final PreDefinedValueController preCon = Get.find<PreDefinedValueController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "My CheckOut",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          children: [
            Text(
              "Order For",
              style: AppTextStyle.titleStyle(context).copyWith(fontSize: 15.sp, color: Theme.of(context).primaryColor),
            ),
            Divider(color: AppColors.primary, height: defaultPadding / 2),
            AppTextField(
              title: "Retailers",
              contentPadding: EdgeInsets.all(defaultPadding),
              readOnly: true,
              controller: con.retailerCon.value,
              hintText: "Select Retailers",
              padding: EdgeInsets.only(bottom: defaultPadding, top: defaultPadding / 2),
              suffixIcon: SvgPicture.asset(AppAssets.downArrow, height: 10),
              onTap: () {
                AppDialogs.retailerSelect(
                  context,
                  selectedRetailer: con.retailerId.obs,
                )?.then(
                  (value) {
                    if (value != null && (value.runtimeType == RetailerModel)) {
                      final RetailerModel retailerModel = (value as RetailerModel);
                      con.retailerModel.value = retailerModel;
                      con.retailerCon.value.text = con.retailerModel.value.businessName ?? "";
                      con.retailerId = con.retailerModel.value.id?.value ?? "";
                      con.checkButtonDisableStatus();
                    }
                  },
                );
              },
            ),
            defaultPadding.verticalSpace,
            Text(
              "Order Type",
              style: AppTextStyle.titleStyle(context).copyWith(fontSize: 15.sp, color: Theme.of(context).primaryColor),
            ),
            Divider(color: AppColors.primary, height: defaultPadding / 2),
            AppTextField(
              title: "Select Order Type",
              contentPadding: EdgeInsets.all(defaultPadding),
              readOnly: true,
              controller: con.orderTypeCon.value,
              hintText: "Select Order Type",
              padding: EdgeInsets.only(bottom: defaultPadding, top: defaultPadding / 2),
              suffixIcon: SvgPicture.asset(AppAssets.downArrow, height: 10),
              onTap: () {
                AppDialogs.orderSelect(
                  context,
                  orderTypeList: preCon.orderTypeList,
                  selectedOrder: RxString(con.orderTypeCon.value.text),
                )?.then(
                  (value) {
                    con.orderTypeCon.value.text = value;
                    con.checkButtonDisableStatus();
                  },
                );
              },
            ),
          ],
        ),

        /// CART SUMMARY
        bottomNavigationBar: IntrinsicHeight(
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Container(
                padding: EdgeInsets.only(top: defaultPadding, bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(defaultRadius),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Column(
                        children: [
                          cartSummaryItem(
                            context,
                            title: "Total Items",
                            price: "1",
                          ),
                          cartSummaryItem(
                            context,
                            title: "Total Quantity",
                            price: con.quantity.value.toString(),
                          ),
                          cartSummaryItem(
                            context,
                            title: "Total Payment",
                            price: UiUtils.amountFormat(con.totalPrice.value, decimalDigits: 2),
                          ),
                          (defaultPadding / 2).verticalSpace,
                          AppButton(
                            padding: EdgeInsets.only(right: defaultPadding / 2),
                            flexibleHeight: true,
                            disableButton: con.disableButton.value,
                            title: "Check Out",
                            titleStyle: AppTextStyle.appButtonStyle(context).copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            onPressed: () {
                              AppDialogs.cartDialog(
                                context,
                                contentText: "Are you sure? You want to check out this item",
                                buttonTitle2: "OK",
                                titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                onPressed: () {
                                  final List<Map<String, dynamic>> cartItems = con.cartList.map(
                                    (item) {
                                      return {
                                        "cartId": item.id,
                                        "item_total": item.inventoryTotalPrice,
                                      };
                                    },
                                  ).toList();

                                  /// Create Order Api
                                  OrdersRepository.createOrder(
                                    retailerId: con.retailerId,
                                    orderType: con.orderTypeCon.value.text,
                                    quantity: con.quantity.value,
                                    subTotal: con.totalPrice.value.toString(),
                                    cartItems: cartItems,
                                  );
                                  Get.back();
                                  Get.back();
                                  if (isRegistered<BottomBarController>()) {
                                    BottomBarController bottomCon = Get.find<BottomBarController>();
                                    bottomCon.currentBottomIndex.value = 3;
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget cartSummaryItem(BuildContext context, {required String title, required String price}) {
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
}
