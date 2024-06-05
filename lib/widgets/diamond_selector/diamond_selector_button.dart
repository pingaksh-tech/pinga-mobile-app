import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';

Widget diamondSelectorButton(BuildContext context, {required RxString selectedSize, Color? backgroundColor}) {
  return InkWell(
    onTap: () {
      AppDialogs.sizeSelector(context)?.then(
        (value) {
          if (value != null) {
            selectedSize.value = value;
          }
        },
      );
    },
    child: Ink(
      child: Obx(() {
        return Container(
          padding: EdgeInsets.all(defaultPadding / 2.4),
          decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(defaultRadius)),
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.ringSizeIcon,
                height: 14.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              Text(
                "Size ${isValEmpty(selectedSize.value) ? "(0)" : "(${selectedSize.value.split(" ").first})"}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp, color: AppColors.primary),
              )
            ],
          ),
        );
      }),
    ),
  );
}
