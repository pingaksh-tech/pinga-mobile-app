import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        padding: EdgeInsets.all(defaultPadding / 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: defaultShadowAllSide,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: Get.width / 2 - defaultPadding * 2.5,
                  child: AppNetworkImage(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(defaultRadius / 1.5),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    imageUrl: imageUrl,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightGrey.withOpacity(0.5),
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(defaultPadding / 2),
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Flora",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AppIconButton(
                    onPressed: () {},
                    size: 25.h,
                    icon: Icon(
                      Icons.more_vert_rounded,
                      size: 18.sp,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: defaultPadding / 1.5, bottom: defaultPadding / 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 45,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(defaultRadius - 4),
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppAssets.ringIcon,
                              height: 15,
                              color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                            ),
                            Text(
                              "19",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 45,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(defaultRadius - 4),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.color_lens_outlined,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "30",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
