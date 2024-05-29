import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? elevation;
  final double? toolbarHeight;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final VoidCallback? titleOnTap;
  final Widget? leading;
  final Widget? child;
  final SystemUiOverlayStyle? systemOverlayStyle;
  @override
  final Size preferredSize;
  final bool centerTitle;
  final bool showBackIcon;
  final EdgeInsets? leadingPadding;
  final PreferredSizeWidget? bottom;
  final double? leadingWidth;
  final double? titleSpacing;
  final Color? backgroundColor;
  final Color? shadowColor;

  MyAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.elevation = 5,
    this.toolbarHeight,
    this.bottom,
    this.onTap,
    this.actions,
    this.titleOnTap,
    this.systemOverlayStyle,
    this.centerTitle = true,
    this.showBackIcon = true,
    this.leading,
    this.child,
    this.leadingPadding,
    this.leadingWidth,
    this.titleSpacing,
    this.backgroundColor,
    this.shadowColor,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  static double preferredHeightFor(BuildContext context, Size preferredSize) {
    if (preferredSize is _PreferredAppBarSize && preferredSize.toolbarHeight == null) {
      return (AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight) + (preferredSize.bottomHeight ?? 0);
    }
    return preferredSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: systemOverlayStyle,
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.transparent,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      leading: showBackIcon
          ? IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(
                height: 30,
                AppAssets.backArrowIcon,
                color: AppColors.primary, // ignore: deprecated_member_use
              ),
            )
          : leading,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      title: GestureDetector(
        onTap: titleOnTap,
        child: child ??
            Text(
              title ?? "",
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
      ),
      actions: !isValEmpty(actions)
          ? [
              Padding(
                padding: EdgeInsets.only(right: defaultPadding / 1.7),
                child: Row(
                  children: actions!,
                ),
              ),
            ]
          : null,
      bottom: bottom,
    );
  }
}

class _PreferredAppBarSize extends Size {
  final double? toolbarHeight;
  final double? bottomHeight;

  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));
}
