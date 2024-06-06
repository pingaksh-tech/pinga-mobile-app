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
        color: Theme.of(context).primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      // padding: EdgeInsets.all(defaultPadding / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Decrement Button
          incrementDecrementButton(
            onPressed: () {
              /// DECREMENT
              if (textValue.value > 0) {
                textValue.value--;
                onDecrement(textValue.value);
              }
            },
            icon: SvgPicture.asset(
              AppAssets.minusIcon,
              colorFilter: ColorFilter.mode(textValue.value > 0 ? AppColors.primary : Theme.of(context).disabledColor, BlendMode.srcIn),
            ),
          ),

          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AppDialogs.addQuantityDialog(context, quantity: textValue, onChanged: (value) {
                textValue.value = value;
              });
            },
            child: SizedBox(
              width: 32.w,
              child: Text(
                "${textValue.value}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          /// Increment Button
          incrementDecrementButton(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(defaultRadius)),
            onPressed: () {
              /// INCREMENT
              if (textValue.value >= 0) {
                textValue.value++;
                onIncrement(textValue.value);
              }
            },
            icon: SvgPicture.asset(
              AppAssets.plusIcon,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  });
}

Widget incrementDecrementButton({required VoidCallback onPressed, required Widget icon, BorderRadius? borderRadius}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: borderRadius ?? BorderRadius.horizontal(left: Radius.circular(defaultRadius)),
      onTap: onPressed,
      child: Container(
        height: 36.h,
        width: 27.h,
        padding: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: 5.h),
        child: icon,
      ),
    ),
  );
}
