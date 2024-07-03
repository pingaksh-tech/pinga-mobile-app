import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../exports.dart';

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
}
