import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class SortAndFilterButton extends StatelessWidget {
  final String title;
  final String image;
  final void Function()? onTap;
  final bool? isFilterButton;
  final String? filterCount;
  final double? iconSize;
  const SortAndFilterButton({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
    this.isFilterButton = true,
    this.filterCount,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(defaultRadius),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: iconSize ?? 18.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
            ).paddingOnly(right: defaultPadding / 2),
            Text(
              title,
              style: AppTextStyle.subtitleStyle(context),
            ),
            if (isFilterButton == true && !isValEmpty(filterCount))
              Container(
                height: 15.h,
                width: 15.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: defaultPadding / 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  filterCount ?? "",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 10.sp,
                      ),
                ),
              ),
          ],
        ).paddingSymmetric(vertical: defaultPadding / 2),
      ),
    );
  }
}
