import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/model/product/single_product_model.dart';
import '../../../exports.dart';

EdgeInsets get bodyPadding => EdgeInsets.symmetric(horizontal: defaultPadding);

class PriceBreakupDialog {
  static Future<dynamic> priceBreakupDialog(BuildContext context, {required PriceBreaking priceBreakModel}) {
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
              Column(
                mainAxisSize: MainAxisSize.min,
                // physics: const RangeMaintainingScrollPhysics(),
                // padding: EdgeInsets.zero,
                // shrinkWrap: true,
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

                  ListView(
                    // physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      if (priceBreakModel.colourStone != null)

                        /// Body
                        Text(
                          "COLOR STONE",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                        ),
                      if (priceBreakModel.colourStone != null)
                        Padding(
                          padding: bodyPadding,
                          child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                        ),
                      if (priceBreakModel.colourStone != null)

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
                              priceTableRow(context, value1: "Weight", value2: "Pieces", value3: "Total"),

                              /// Value Row
                              priceTableRow(
                                context,
                                isSubtitle: true,
                                value1: "${priceBreakModel.colourStone?.colourStoneWeight} g",
                                value2: UiUtils.amountFormat(priceBreakModel.colourStone?.colourStoneCount ?? 0, decimalDigits: 2),
                                value3: UiUtils.amountFormat(priceBreakModel.colourStone?.colourStonePrice ?? 0, decimalDigits: 0),
                              ),
                            ],
                          ),
                        ),
                      if (priceBreakModel.pearl != null)

                        /// Body
                        Text(
                          "PEARL",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                        ),
                      if (priceBreakModel.pearl != null)
                        Padding(
                          padding: bodyPadding,
                          child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                        ),
                      if (priceBreakModel.pearl != null)

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
                              priceTableRow(context, value1: "Weight", value2: "Pieces", value3: "Total"),

                              /// Value Row
                              priceTableRow(
                                context,
                                isSubtitle: true,
                                value1: "${priceBreakModel.pearl?.pearlWeight} g",
                                value2: UiUtils.amountFormat(priceBreakModel.pearl?.pearlCount ?? 0, decimalDigits: 2),
                                value3: UiUtils.amountFormat(priceBreakModel.pearl?.pearlPrice ?? 0, decimalDigits: 0),
                              ),
                            ],
                          ),
                        ),

                      Text(
                        "MINO",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                      ),
                      Padding(
                        padding: bodyPadding,
                        child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                      ),

                      /// Body
                      Padding(
                        padding: bodyPadding.copyWith(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font),
                            ),
                            Text(
                              UiUtils.amountFormat(priceBreakModel.mino?.minoPrice ?? 0, decimalDigits: 2),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.subText),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: bodyPadding.copyWith(bottom: defaultPadding),
                        child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                      ),

                      /// Body
                      Text(
                        "METAL",
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
                            priceTableRow(context, value1: "Weight", value2: "Per gram price", value3: "Total"),

                            /// Value Row
                            priceTableRow(
                              context,
                              isSubtitle: true,
                              value1: "${priceBreakModel.metal?.metalWeight} g",
                              value2: UiUtils.amountFormat(priceBreakModel.metal?.pricePerGram ?? 0, decimalDigits: 2),
                              value3: UiUtils.amountFormat(priceBreakModel.metal?.metalPrice ?? 0, decimalDigits: 0),
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
                            priceTableRow(context, value1: "Weight", value2: "Carat price", value3: "Total"),

                            /// Value Row
                            priceTableRow(
                              context,
                              isSubtitle: true,
                              value1: "${priceBreakModel.diamond?.diamondWeight ?? 0}",
                              value2: UiUtils.amountFormat(priceBreakModel.diamond?.diamondCartPrice ?? 0, decimalDigits: 2),
                              value3: UiUtils.amountFormat(priceBreakModel.diamond?.diamondPrice ?? 0, decimalDigits: 0),
                            ),
                          ],
                        ),
                      ),

                      /// Other Pricing
                      Text(
                        "MANUFACTURING",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.primary),
                      ),
                      Padding(
                        padding: bodyPadding,
                        child: Divider(height: 5.h, color: Theme.of(context).dividerColor.withOpacity(.2)),
                      ),

                      /// Table View
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
                            priceTableRow(context, value1: "Weight", value2: "Per Gram Labour", value3: "Total"),

                            /// Value Row
                            priceTableRow(
                              context,
                              isSubtitle: true,
                              value1: "${priceBreakModel.manufacturingPrice?.metalWeight ?? 0}",
                              value2: UiUtils.amountFormat(priceBreakModel.manufacturingPrice?.perGramLabour ?? 0, decimalDigits: 2),
                              value3: UiUtils.amountFormat(priceBreakModel.manufacturingPrice?.manufacturingPrice ?? 0, decimalDigits: 0),
                            ),
                          ],
                        ),
                      ),
                      50.verticalSpace,
                    ],
                  )
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
                        UiUtils.amountFormat(priceBreakModel.total ?? 0, decimalDigits: 0),
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
    String? value4,
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          // height: 22.h,
          // padding: (value3 != null && value3.isNotEmpty)
          //     ? null
          //     : EdgeInsets.only(left: defaultPadding * 2),
          // alignment: (value3 != null && value3.isNotEmpty)
          //     ? Alignment.center
          //     : Alignment.centerLeft,
          child: Text(
            value1,
            maxLines: 1,
            textAlign: TextAlign.start,
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
        if (value4 != null && value4.isNotEmpty)
          Text(
            value4,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: isSubtitle ? AppColors.subText : AppColors.font),
          ),
      ],
    );
  }
}
