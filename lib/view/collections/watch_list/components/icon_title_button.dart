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
    return Column(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            icon ?? "",
            height: 14.h,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          onPressed: onPressed,
        ),
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10.sp, color: AppColors.primary),
        )
      ],
    );
  }
}
