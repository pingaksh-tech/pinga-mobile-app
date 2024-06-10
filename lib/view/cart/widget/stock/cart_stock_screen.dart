import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/plus_minus_title/plus_minus_tile.dart';
import 'cart_stock_controller.dart';

class CartStockScreen extends StatelessWidget {
  CartStockScreen({super.key});

  final CartStockController con = Get.put(CartStockController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          centerTitle: false,
          title: "Stock List for ${con.productName.value}",
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: con.stockList.length,
              separatorBuilder: (context, index) => (defaultPadding / 2).verticalSpace,
              itemBuilder: (context, index) => Row(
                children: [
                  SvgPicture.asset(con.stockList[index].image ?? ""),
                  (defaultPadding / 1.5).horizontalSpace,
                  Expanded(
                    child: Text(
                      con.stockList[index].stock ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                  ),
                  Text(
                    con.stockList[index].value ?? "",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            (defaultPadding / 1.5).verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Add to cart",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15.sp),
                    ),
                  ),
                  plusMinusTile(
                    context,
                    size: 20,
                    textValue: RxInt(1),
                    onIncrement: (p0) {},
                    onDecrement: (p0) {},
                  ),
                ],
              ),
            ),
            Divider(height: 20.h, color: AppColors.lightGrey.withOpacity(0.5))
          ],
        ),
      ),
    );
  }
}
