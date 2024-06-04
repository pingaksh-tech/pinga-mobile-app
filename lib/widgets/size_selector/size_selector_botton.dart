import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';

Widget horizontalSelectorButton(BuildContext context, {RxString? selectedSize, RxString? selectedColor, required SelectableItemType selectableItemType, SizeColorSelectorButtonType sizeColorSelectorButtonType = SizeColorSelectorButtonType.medium, Color? backgroundColor}) {
  bool isSmallSize = (sizeColorSelectorButtonType == SizeColorSelectorButtonType.small);
  bool isMediumSize = (sizeColorSelectorButtonType == SizeColorSelectorButtonType.medium);
  bool isLargeSize = (sizeColorSelectorButtonType == SizeColorSelectorButtonType.large);

  bool isSize = (selectableItemType == SelectableItemType.size);
  bool isColor = (selectableItemType == SelectableItemType.color);
  bool isDiamond = (selectableItemType == SelectableItemType.diamond);
  bool isRemark = (selectableItemType == SelectableItemType.remarks);
  return Expanded(
    child: InkWell(
      onTap: () {
        if (isSize) {
          AppDialogs.selectSizeDialog(context)?.then(
            (value) {
              if (value != null) {
                selectedSize?.value = value;
              }
            },
          );
        } else if (isColor) {
          AppDialogs.selectColorDialog(context)?.then(
            (value) {
              if (value != null) {
                selectedColor?.value = value;
              }
            },
          );
        }
      },
      child: Ink(
          child: Container(
        padding: EdgeInsets.all(defaultPadding / 2.4),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSize
                  ? AppAssets.ringSizeIcon
                  : isColor
                      ? AppAssets.colorIcon
                      : isDiamond
                          ? AppAssets.diamondIcon
                          : AppAssets.remarkOutlineIcon,
              height: isSmallSize
                  ? 12.h
                  : isMediumSize
                      ? 14.h
                      : 16.h,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            (defaultPadding / 4).horizontalSpace,
            Text(
              isSize
                  ? ("Size ${isValEmpty(selectedSize?.value) ? "(0)" : "(${selectedSize?.value.split(" ").first})"}")
                  : isColor
                      ? ("Color ${isValEmpty(selectedColor?.value) ? "(-)" : "(${selectedColor?.value.split(" ").first})"}")
                      : isDiamond
                          ? "Ruby"
                          : "Remark",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: isSmallSize
                      ? 8.h
                      : isMediumSize
                          ? 10.h
                          : 14.h,
                  color: AppColors.primary),
            )
          ],
        ),
      )),
    ),
  );
}

Widget sizeSelectorButton(BuildContext context, {required RxString selectedSize, Color? backgroundColor}) {
  return InkWell(
    onTap: () {
      AppDialogs.selectSizeDialog(context)?.then(
        (value) {
          if (value != null) {
            selectedSize.value = value;
          }
        },
      );
    },
    child: Ink(
      child: Obx(() {
        return Container(
          padding: EdgeInsets.all(defaultPadding / 2.4),
          decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.06), borderRadius: BorderRadius.circular(defaultRadius)),
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.ringSizeIcon,
                height: 14.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              Text(
                "Size ${isValEmpty(selectedSize.value) ? "(0)" : "(${selectedSize.value.split(" ").first})"}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp, color: AppColors.primary),
              )
            ],
          ),
        );
      }),
    ),
  );
}
