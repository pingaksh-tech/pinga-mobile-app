import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../exports.dart';
import 'device_utils.dart';

class ShimmerUtils {
  static Widget shimmer({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    bool isShowShimmer = true,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isShowShimmer == true
          ? Shimmer.fromColors(
              baseColor: baseColor ?? Theme.of(Get.context!).primaryColor.withOpacity(1),
              highlightColor: highlightColor?.withOpacity(0.1) ?? Theme.of(Get.context!).scaffoldBackgroundColor,
              child: child,
            )
          : child,
    );
  }

  static Container d({Color? color}) {
    return Container(
      height: 1,
      color: color ?? Colors.white.withOpacity(0.2),
    );
  }

  static Widget shimmerContainer({double? height, double? width, BorderRadiusGeometry? borderRadius, double? borderRadiusSize, Widget? child, Decoration? decoration}) => Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(borderRadiusSize ?? 50),
              color: AppColors.primary.withOpacity(0.1),
            ),
      );

  static Widget loadingShimmerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
      child: Row(
        children: [
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              height: 46.h,
              width: 46.h,
              borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
            ),
          ),
          defaultPadding.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 10.h,
                  width: 100.w,
                  borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                ),
              ),
              (defaultPadding / 2).verticalSpace,
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 10.h,
                  width: Get.width * 0.5,
                  borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget productGridShimmer(BuildContext context) {
    return ShimmerUtils.shimmer(
      child: ShimmerUtils.shimmerContainer(
        height: Get.height / 2.7,
        width: DeviceUtil.isTablet(Get.context!) ? (Get.width / 4 - (defaultPadding * 1.3)) : Get.width / 2 - defaultPadding * 1.5,
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget productsListShimmer(BuildContext context) {
    return ShimmerUtils.shimmer(
      child: ShimmerUtils.shimmerContainer(
        height: 100.h,
        width: Get.width - defaultPadding * 1.5,
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
