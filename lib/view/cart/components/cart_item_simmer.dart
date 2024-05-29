import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerUtils.shimmer(
          child: ShimmerUtils.shimmerContainer(
            height: Get.width * 0.21,
            width: Get.width * 0.21,
            borderRadiusSize: defaultRadius,
          ),
        ),
        SizedBox(width: defaultPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.45,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.60,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 15,
                width: Get.width * 0.35,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
