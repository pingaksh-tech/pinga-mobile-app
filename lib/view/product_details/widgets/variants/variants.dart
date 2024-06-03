import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:pingaksh_mobile/view/product_details/components/dialog_buttons/color_dialog/color_dialog_button.dart';
import 'package:pingaksh_mobile/view/product_details/components/dialog_buttons/size_dialog/size_dialog_botton.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/variants/variants_controller.dart';

class Variants extends StatelessWidget {
  Variants({super.key});

  final VariantsController con = Get.put(VariantsController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding * 3),
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(.15),
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.r))),
          padding: EdgeInsets.all(defaultPadding / 1.5),
          child: Row(
            children: [
              AppNetworkImage(
                imageUrl: "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
                height: 44.h,
                width: 44.h,
                borderRadius: BorderRadius.circular(defaultRadius / 2),
              ),
              6.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PLKMR7423746(SIVA 14)",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp, color: AppColors.font.withOpacity(.6)),
                  ),
                  Text(
                    UiUtils.amountFormat(37028, decimalDigits: 0),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12.3.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Row(
                    children: [
                      /// Size Selector
                      SizeDialogButton(),
                      (defaultPadding / 2).horizontalSpace,

                      /// Color Selector
                      ColorDialogButton(),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
