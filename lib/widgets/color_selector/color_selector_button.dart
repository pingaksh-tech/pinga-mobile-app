import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';

Widget colorSelectorButton(BuildContext context, {required RxString selectedColor, Color? backgroundColor}) {
  return InkWell(
    onTap: () {
      AppDialogs.selectColorDialog(context)?.then(
        (value) {
          if (value != null) {
            selectedColor.value = value;
          }
        },
      );
    },
    child: Ink(
      child: Obx(() {
        return Container(
          padding: EdgeInsets.all(defaultPadding / 2.4),
          decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.06), borderRadius: BorderRadius.circular(defaultRadius)),
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.colorIcon,
                height: 14.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              Text(
                "Color ${isValEmpty(selectedColor.value) ? "(-)" : "(${selectedColor.value.split(" ").first})"}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp, color: AppColors.primary),
              )
            ],
          ),
        );
      }),
    ),
  );
}
