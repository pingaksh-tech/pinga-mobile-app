import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/variants/variants_controller.dart';

import '../../../../widgets/color_selector/color_selector_button.dart';
import '../../../../widgets/plus_minus_title/plus_minus_tile.dart';
import '../../../../widgets/size_selector/size_selector_botton.dart';

class VariantsTab extends StatelessWidget {
  VariantsTab({super.key});

  final VariantsController con = Get.put(VariantsController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding * 3),
      children: [
        for (int i = 0; i <= 3; i++)
          variantDetailTile(
            context,
            image: "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
            title: "PLKMR7423746(SIVA 14)",
            price: 37028 + i,
          ),
      ],
    );
  }

  /// VARIANT DETAIL TILE
  Widget variantDetailTile(BuildContext context, {String? image, String? title, num? price}) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(.15),
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.r))),
        padding: EdgeInsets.all(defaultPadding / 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              imageUrl: image ?? "",
              height: 44.h,
              width: 44.h,
              borderRadius: BorderRadius.circular(defaultRadius / 2),
            ),
            6.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp, color: AppColors.font.withOpacity(.6)),
                ),

                4.verticalSpace,

                /// PRICE
                Text(
                  UiUtils.amountFormat(price, decimalDigits: 0),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Row(
                    children: [
                      /// Size Selector
                      sizeSelectorButton(context, selectedSize: con.size),
                      6.horizontalSpace,

                      /// Color Selector
                      colorSelectorButton(context, selectedColor: con.color),
                      defaultPadding.horizontalSpace,
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),

            /// Plus minus tile
            plusMinusTile(
              context,
              textValue: con.quantity,
              onDecrement: (value) {
                printYellow(value);
                con.quantity.value = value;
                con.quantity.refresh();
                printOkStatus(con.quantity);
              },
              onIncrement: (value) {
                printYellow(value);
                con.quantity.value = value;

                con.quantity.refresh();

                printOkStatus(con.quantity);
              },
            ),
          ],
        ),
      );
    });
  }
}
