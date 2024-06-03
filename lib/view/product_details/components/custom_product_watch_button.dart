import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../exports.dart';

class CustomProductWatchButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CustomProductWatchButton({
    super.key,
    this.icon,
    this.title,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      backgroundColor: backgroundColor ?? AppColors.subText.withOpacity(.12),
      size: 52.h,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null && icon!.isNotEmpty) ...[
            SvgPicture.asset(
              icon ?? "",
              height: 16.h,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            4.verticalSpace,
          ],
          if (title != null && title!.isNotEmpty)
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.5.sp, color: AppColors.primary),
            ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
