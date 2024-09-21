import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

class DownloadSelectionTile extends StatelessWidget {
  final String title;
  final String? image;
  final VoidCallback onTap;
  const DownloadSelectionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: Theme.of(context).primaryColor.withOpacity(0.06),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              image ?? AppAssets.cart,
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
            ),
            defaultPadding.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    ).paddingOnly(bottom: defaultPadding / 1.5);
  }
}
