import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/view/product_details/components/dialog_buttons/color_dialog/color_dialog_controller.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';

class ColorDialogButton extends StatelessWidget {
  ColorDialogButton({super.key});

  final ColorDialogController con = Get.put(ColorDialogController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppDialogs.selectColorDialog(context)?.then(
          (value) {
            if (value != null) {
              con.selectedColor.value = value;
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
                  AppAssets.colorIcon,
                  height: 14.h,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
                Text(
                  "Color ${isValEmpty(con.selectedColor.value) ? "(-)" : "(${con.selectedColor.value.split(" ").first})"}",
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
