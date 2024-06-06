import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AppIconButton(
          icon: SvgPicture.asset(
            AppAssets.cart,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.cartScreen);
          },
        ),
        Positioned(
          top: 2.h,
          right: defaultPadding / 2,
          child: Container(
            padding: EdgeInsets.all(4.h).copyWith(top: 5.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            alignment: Alignment.center,
            child: Text(
              "4",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.background,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
