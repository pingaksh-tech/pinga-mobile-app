import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class SortAndFilterButton extends StatelessWidget {
  final String title;
  final String image;
  final void Function()? onTap;
  const SortAndFilterButton({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 18.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
            ).paddingOnly(right: defaultPadding / 2),
            Text(
              title,
              style: AppTextStyle.subtitleStyle(context),
            ),
          ],
        ).paddingSymmetric(vertical: defaultPadding / 2),
      ),
    );
  }
}
