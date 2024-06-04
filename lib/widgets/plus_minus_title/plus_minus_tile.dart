import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../exports.dart';
import '../../res/app_dialog.dart';

Widget plusMinusTile(
  BuildContext context, {
  required RxInt textValue,
  double? size,
  required Function(int) onIncrement,
  required Function(int) onDecrement,
}) {
  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      padding: EdgeInsets.all(defaultPadding / 2),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Minus Button
          AppIconButton(
            size: size ?? 17.h,
            icon: SvgPicture.asset(
              AppAssets.minusIcon,
              colorFilter: ColorFilter.mode(textValue.value > 0 ? AppColors.primary : Theme.of(context).disabledColor, BlendMode.srcIn),
            ),
            onPressed: () {
              /// DECREMENT
              if (textValue.value > 0) {
                textValue.value--;
                onDecrement(textValue.value);
              }
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AppDialogs.addQuantityDialog(context, quantity: textValue, onChanged: (value) {
                textValue.value = value;
              });
            },
            child: SizedBox(
              width: 30.w,
              child: Text(
                "${textValue.value}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          /// Plus Button
          AppIconButton(
            size: size ?? 17.h,
            icon: SvgPicture.asset(
              AppAssets.plusIcon,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            onPressed: () {
              /// INCREMENT
              if (textValue.value >= 0) {
                textValue.value++;
                onIncrement(textValue.value);
              }
            },
          ),
        ],
      ),
    );
  });
}
