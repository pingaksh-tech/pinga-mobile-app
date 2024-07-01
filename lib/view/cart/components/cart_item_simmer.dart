import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding / 1.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
        boxShadow: defaultShadowAllSide,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  borderRadiusSize: defaultRadius,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerUtils.shimmer(
                            child: ShimmerUtils.shimmerContainer(
                              height: 15,
                              width: Get.width * 0.4,
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
                      SizedBox(width: defaultPadding),
                      ShimmerUtils.shimmer(
                        child: ShimmerUtils.shimmerContainer(
                          height: 42,
                          borderRadius: BorderRadius.circular(defaultRadius),
                          width: Get.width * 0.21,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 42,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  width: Get.width * 0.11,
                ),
              ),
              SizedBox(width: defaultPadding / 3),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 42,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  width: Get.width * 0.11,
                ),
              ),
              SizedBox(width: defaultPadding / 3),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 42,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  width: Get.width * 0.11,
                ),
              ),
              SizedBox(width: defaultPadding / 3),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 42,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  width: Get.width * 0.11,
                ),
              ),
              SizedBox(width: defaultPadding / 3),
              ShimmerUtils.shimmer(
                child: ShimmerUtils.shimmerContainer(
                  height: 42,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  width: Get.width * 0.11,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
