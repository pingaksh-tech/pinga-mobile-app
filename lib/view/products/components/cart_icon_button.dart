import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../cart/cart_controller.dart';

class CartIconButton extends StatelessWidget {
  final void Function() onPressed;
  CartIconButton({super.key, required this.onPressed});

  final CartController con = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          alignment: Alignment.topRight,
          children: [
            AppIconButton(
              icon: SvgPicture.asset(
                AppAssets.cart,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              onPressed: onPressed,
            ),
            if (!isValEmpty(con.cartDetail.value.totalItems))
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
                    con.cartDetail.value.totalItems.toString(),
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
        ));
  }
}
