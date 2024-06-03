import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/view/product_details/components/dialog_buttons/size_dialog/size_dialog_controller.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';

class SizeDialogButton extends StatelessWidget {
  SizeDialogButton({super.key});

  final SizeDialogController con = Get.put(SizeDialogController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppDialogs.selectSizeDialog(context)?.then(
          (value) {
            if (value != null) {
              con.selectedSize.value = value;
            }
          },
        );
      },
      child: Ink(
        child: Obx(() {
          return Container(
            padding: EdgeInsets.all(defaultPadding / 2.7),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(defaultRadius)),
            child: Column(
              children: [
                SvgPicture.asset(
                  AppAssets.ringSizeIcon,
                  height: 14.h,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
                Text(
                  "Size ${isValEmpty(con.selectedSize.value) ? "(0)" : "(${con.selectedSize.value.split(" ").first})"}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp, color: AppColors.primary),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
