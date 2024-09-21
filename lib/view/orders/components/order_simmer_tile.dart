import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class OrderShimmerTile extends StatelessWidget {
  const OrderShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
        boxShadow: defaultShadowAllSide,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              height: 15,
              width: Get.width * 0.35,
              borderRadiusSize: defaultRadius,
            ),
          ),
          SizedBox(height: defaultPadding / 5),
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              height: 15,
              width: Get.width * 0.45,
              borderRadiusSize: defaultRadius,
            ),
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.25,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.45,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 7),
          Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.25,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.25,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 7),

          Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.25,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 15,
                  width: Get.width * 0.35,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 15,
          //   child: Row(
          //     children: [
          //       ShimmerUtils.shimmer(
          //         child: ShimmerUtils.shimmerContainer(
          //           height: 15,
          //           width: Get.width * 0.50,
          //         ),
          //       ),
          //       const Spacer(),
          //       ShimmerUtils.shimmer(
          //         child: ShimmerUtils.shimmerContainer(
          //           height: 15,
          //           width: Get.width * 0.20,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
