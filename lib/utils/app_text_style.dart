import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle textFieldStyle(BuildContext context) {
    return const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  }

  static TextStyle appButtonStyle(BuildContext context) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
  }

  static TextStyle titleStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18.0.sp,
          fontWeight: FontWeight.w600,
          color: color,
        );
  }

  static TextStyle subtitleStyle(BuildContext context, {FontWeight? fontWeight, double? fontSize, Color? color}) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize ?? 13.5.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55),
        );
  }
}
