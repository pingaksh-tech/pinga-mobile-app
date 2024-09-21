import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../exports.dart';

class IconTitleButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final VoidCallback? onPressed;

  const IconTitleButton({
    super.key,
    this.icon,
    this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius),
      onTap: onPressed,
      child: Ink(
        padding: EdgeInsets.all(defaultPadding / 3),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: SvgPicture.asset(
                icon ?? "",
                height: 14.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
            2.verticalSpace,
            Text(
              title ?? "",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10.sp, color: AppColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
