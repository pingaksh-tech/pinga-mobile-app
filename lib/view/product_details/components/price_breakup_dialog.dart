import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

EdgeInsets get bodyPadding => EdgeInsets.symmetric(horizontal: defaultPadding);

class PriceBreakupDialog {
  static Future<dynamic> priceBreakupDialog(BuildContext context) {
    return Get.dialog(
      Dialog(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: AppColors.background,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                physics: const RangeMaintainingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  /// Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(right: defaultPadding / 2, top: defaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Price breakup",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        AppIconButton(
                          size: 24.h,
                          splashColor: Theme.of(context).scaffoldBackgroundColor,
                          onPressed: () {
                            Get.back();
                          },
                          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          icon: SvgPicture.asset(AppAssets.crossIcon),
                        ),
                      ],
                    ),
                  ),
                  (defaultPadding / 1.5).verticalSpace,

                  /// Body
                  Text(
                    "GOLD",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                  ),
                  Padding(
                    padding: bodyPadding,
                    child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                  ),

                  /// Table View
                  Padding(
                    padding: bodyPadding.copyWith(bottom: defaultPadding),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        /// Title Row
                        priceTableRow(context, value1: "Weight", value2: "KT price", value3: "Total"),

                        /// Value Row
                        priceTableRow(
                          context,
                          isSubtitle: true,
                          value1: "6.05 g",
                          value2: UiUtils.amountFormat(5066, decimalDigits: 0),
                          value3: UiUtils.amountFormat(43572, decimalDigits: 0),
                        ),
                      ],
                    ),
                  ),

                  /// Diamond Table Pricing
                  Text(
                    "DIAMOND",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                  ),
                  Padding(
                    padding: bodyPadding,
                    child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                  ),

                  /// Table View
                  Padding(
                    padding: bodyPadding.copyWith(bottom: defaultPadding),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        // 2: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        /// Title Row
                        priceTableRow(context, value1: "Weight", value2: "Total"),

                        /// Value Row
                        priceTableRow(
                          context,
                          isSubtitle: true,
                          value1: "0.662",
                          value2: UiUtils.amountFormat(76130, decimalDigits: 0),
                        ),
                      ],
                    ),
                  ),

                  /// Other Pricing
                  Text(
                    "OTHER",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                  ),
                  Padding(
                    padding: bodyPadding,
                    child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                  ),

                  /// Table View
                  Padding(
                    padding: bodyPadding,
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        priceTableRow(context, value1: "Labour", value2: UiUtils.amountFormat(12124, decimalDigits: 0)),
                        priceTableRow(context, value1: "GST", value2: UiUtils.amountFormat(5772, decimalDigits: 0)),
                      ],
                    ),
                  ),
                  50.verticalSpace,
                ],
              ),

              /// TOTAL AMOUNT
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(defaultRadius),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        textAlign: TextAlign.end,
                        UiUtils.amountFormat(12703, decimalDigits: 0),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static TableRow priceTableRow(
    BuildContext context, {
    required String value1,
    required String value2,
    String? value3,
    bool isSubtitle = false,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(.2),
          ),
        ),
      ),
      children: [
        Container(
          height: 22.h,
          padding: (value3 != null && value3.isNotEmpty) ? null : EdgeInsets.only(left: defaultPadding * 2),
          alignment: (value3 != null && value3.isNotEmpty) ? Alignment.center : Alignment.centerLeft,
          child: Text(
            value1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: isSubtitle ? AppColors.subText : AppColors.font),
          ),
        ),
        Text(
          value2,
          textAlign: value3 != null && value3.isNotEmpty ? TextAlign.center : TextAlign.end,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: isSubtitle ? AppColors.subText : AppColors.font),
        ),
        if (value3 != null && value3.isNotEmpty)
          Text(
            value3,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: isSubtitle ? AppColors.subText : AppColors.font),
          ),
      ],
    );
  }
}
