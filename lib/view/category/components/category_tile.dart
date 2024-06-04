import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/res/app_network_image.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final String subTitle;
  final String imageUrl;
  final VoidCallback onTap;
  final double? fontSize;

  const CategoryTile({
    super.key,
    required this.categoryName,
    required this.subTitle,
    required this.imageUrl,
    required this.onTap,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(defaultPadding / 1.5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
          boxShadow: defaultShadowAllSide,
        ),
        child: Row(
          children: [
            AppNetworkImage(
              height: Get.width * 0.18,
              width: Get.width * 0.18,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(defaultRadius),
              imageUrl: imageUrl,
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: AppTextStyle.titleStyle(context).copyWith(fontSize: fontSize ?? 16.sp),
                  ),
                  Text(
                    subTitle,
                    style: AppTextStyle.subtitleStyle(context),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
