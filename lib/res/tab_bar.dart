import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../exports.dart';

class MyTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? width;
  final double? borderRadius;
  final TabAlignment? tabAlignment;
  final TabController? controller;

  const MyTabBar({super.key, this.width, this.borderRadius, this.controller, this.tabAlignment, required this.tabs, this.backgroundColor, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius)),
      child: TabBar(
        controller: controller,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: defaultPadding / 6, horizontal: defaultPadding / 6),
        labelColor: Theme.of(context).scaffoldBackgroundColor,
        labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
        unselectedLabelColor: Colors.black.withOpacity(0.4),
        unselectedLabelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
        automaticIndicatorColorAdjustment: true,
        indicatorWeight: double.minPositive,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius / 2),
          color: Theme.of(context).primaryColor,
        ),
        labelPadding: EdgeInsets.all(defaultPadding / 1.5),
        indicatorSize: TabBarIndicatorSize.tab,
        splashBorderRadius: BorderRadius.circular(defaultRadius / 2),
        tabs: tabs,
      ),
    );
  }
}
