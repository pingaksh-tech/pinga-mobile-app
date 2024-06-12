import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../exports.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  final DateTime dateTime;
  final String customerName;
  final String emrId;
  final String quantity;
  final String totalDp;
  final String mrpPrice;

  const OrderTile({
    super.key,
    required this.orderId,
    required this.dateTime,
    required this.customerName,
    required this.emrId,
    required this.quantity,
    required this.totalDp,
    required this.mrpPrice,
  });

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderId,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, height: 0),
                    ),
                    Text(
                      DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime),
                      style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 11.5.sp),
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            orderDetailsKeyValuePairWidget1(
              context,
              title: "Name",
              subtitleText: customerName,
              titleFlex: 2,
              subTitleFlex: 8,
            ),
            SizedBox(height: defaultPadding / 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: orderDetailsKeyValuePairWidget1(
                    context,
                    title: "EMR ID",
                    subtitleText: emrId,
                    subTitleFlex: 4,
                    titleFlex: 3,
                  ),
                ),
                defaultPadding.horizontalSpace,
                Expanded(
                  child: orderDetailsKeyValuePairWidget1(
                    context,
                    title: "Quantity",
                    subtitleText: quantity,
                    titleFlex: 3,
                    subTitleFlex: 4,
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding / 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: orderDetailsKeyValuePairWidget1(
                    context,
                    title: "Total DP",
                    subtitleText: UiUtils.amountFormat(
                      totalDp,
                      decimalDigits: 2,
                    ),
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
                      mrpPrice,
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
  }

  Widget orderDetailsKeyValuePairWidget1(
    BuildContext context, {
    required String title,
    required String subtitleText,
    int? titleFlex,
    int? subTitleFlex,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: titleFlex ?? 0,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12.5.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
                ),
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
              ),
        ).paddingOnly(right: defaultPadding / 2),
        Expanded(
          flex: subTitleFlex ?? 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              subtitleText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.5.sp),
            ),
          ),
        ),
      ],
    );
  }
}
