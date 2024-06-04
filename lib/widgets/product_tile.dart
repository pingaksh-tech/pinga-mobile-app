import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';
import '../res/app_network_image.dart';
import '../theme/app_style.dart';
import 'plus_minus_title/plus_minus_tile.dart';
import 'size_selector/size_selector_botton.dart';

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
              padding: EdgeInsets.all(defaultPadding / 4).copyWith(top: defaultPadding / 2, bottom: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
              child: Row(
                children: [
                  sizeSelectorButton(context, selectedSize: "19".obs, sizeColorSelectorButtonType: SizeColorSelectorButtonType.small),
                  (defaultPadding / 4).horizontalSpace,
                  sizeSelectorButton(context, selectedSize: "19".obs, sizeColorSelectorButtonType: SizeColorSelectorButtonType.small),
                ],
              ),
            ),
            (defaultPadding / 4).verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
              child: Row(
                children: [
                  sizeSelectorButton(context, selectedSize: "19".obs, sizeColorSelectorButtonType: SizeColorSelectorButtonType.small),
                  (defaultPadding / 4).horizontalSpace,
                  sizeSelectorButton(context, selectedSize: "19".obs, sizeColorSelectorButtonType: SizeColorSelectorButtonType.small),
                ],
              ),
            ),
            (defaultPadding / 4).verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6, vertical: defaultPadding / 6).copyWith(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AppButton(
                      flexibleWidth: true,
                      flexibleHeight: true,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.06),
                      child: SvgPicture.asset(
                        AppAssets.like,
                        height: 19.sp,
                        width: 19.sp,
                        colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  (defaultPadding / 4).horizontalSpace,
                  plusMinusTile(
                    context,
                    textValue: 1.obs,
                    onIncrement: (v) {},
                    onDecrement: (v) {},
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
