import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../exports.dart';
import '../res/app_network_image.dart';

class ProductTile extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String productName;
  final String productPrice;
  const ProductTile({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width / 2 - defaultPadding * 1.5,
        margin: EdgeInsets.all(defaultPadding / 2),
        padding: EdgeInsets.all(defaultPadding / 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey.withOpacity(0.7),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.width / 2 - defaultPadding * 2.5,
              child: AppNetworkImage(
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(defaultRadius),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                imageUrl: imageUrl,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.lightGrey,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: defaultPadding / 1.5, bottom: defaultPadding / 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    UiUtils.amountFormat(productPrice),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
