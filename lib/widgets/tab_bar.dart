import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../exports.dart';

class MySlideTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final TabAlignment? tabAlignment;
  final TabController? controller;
  final BoxBorder? border;
  final void Function(int)? onTap;

  const MySlideTabBar({
    super.key,
    this.width,
    this.borderRadius,
    this.controller,
    this.tabAlignment,
    required this.tabs,
    this.backgroundColor,
    this.labelColor,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      decoration: BoxDecoration(border: border, color: backgroundColor ?? Theme.of(context).cardColor, borderRadius: borderRadius),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: tabAlignment ?? TabAlignment.center,
        dividerColor: Colors.transparent,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: labelColor ?? Theme.of(context).primaryColor,
            ),
        unselectedLabelColor: AppColors.subText,
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }
}
