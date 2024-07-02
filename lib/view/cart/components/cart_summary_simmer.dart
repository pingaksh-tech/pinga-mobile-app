import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class CartSummarySimmer extends StatelessWidget {
  const CartSummarySimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: Get.width * 0.05,
                width: Get.width * 0.05,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
            ),
            (defaultPadding / 2).horizontalSpace,
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.3,
              ),
            ),
            const Spacer(),
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.15,
              ),
            ),
          ],
        ),
        (defaultPadding / 3).verticalSpace,
        Row(
          children: [
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: Get.width * 0.05,
                width: Get.width * 0.05,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
            ),
            (defaultPadding / 2).horizontalSpace,
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.3,
              ),
            ),
            const Spacer(),
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.15,
              ),
            ),
          ],
        ),
        (defaultPadding / 3).verticalSpace,
        Row(
          children: [
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: Get.width * 0.05,
                width: Get.width * 0.05,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
            ),
            (defaultPadding / 2).horizontalSpace,
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.3,
              ),
            ),
            const Spacer(),
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
