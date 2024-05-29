import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

class EmptyElement extends StatelessWidget {
  final String? imagePath;
  final String title;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final double? spacing;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxis;
  final AlignmentGeometry? alignment;

  const EmptyElement({super.key, this.imagePath, required this.title, this.height, this.imageWidth, this.imageHeight, this.spacing, this.subtitle, this.titleStyle, this.subtitleStyle, this.padding, this.mainAxis, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Container(
        // height: height ?? Get.height * .4,
        padding: padding ?? EdgeInsets.only(bottom: defaultPadding),
        child: Column(
          mainAxisAlignment: mainAxis ?? MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null)
              SvgPicture.asset(
                imagePath!,
                width: imageWidth ?? Get.width / 3,
                height: imageHeight ?? Get.width / 2,
              ),
            SizedBox(height: spacing ?? defaultPadding),
            SizedBox(height: defaultPadding / 2),
            if (title != "")
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle ?? TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
              ),
            SizedBox(height: defaultPadding / 2),
            if (!isValEmpty(subtitle))
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: subtitleStyle ?? TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Theme.of(context).primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}
