import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class OrderShimmerTile extends StatelessWidget {
  const OrderShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                    width: Get.width * 0.30,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        SizedBox(
          height: 15,
          child: Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.50,
                ),
              ),
              const Spacer(),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
