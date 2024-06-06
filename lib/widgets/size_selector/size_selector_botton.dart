import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';
import '../../data/model/product/product_colors_model.dart';
import '../../data/model/product/product_diamond_model.dart';
import '../../data/model/product/product_size_model.dart';

Widget horizontalSelectorButton(
  BuildContext context, {
  RxString? selectedSize,
  RxString? selectedColor,
  RxString? selectedDiamond,
  RxString? remarkSelected,
  required SelectableItemType selectableItemType,
  SizeColorSelectorButtonType sizeColorSelectorButtonType = SizeColorSelectorButtonType.medium,
  Color? backgroundColor,
  bool isFlexible = false,
  Axis axisDirection = Axis.horizontal,
  Function(SizeModel model)? sizeOnChanged,
  Function(ColorModel model)? colorOnChanged,
  Function(Diamond model)? rubyOnChanged,
  Function(String model)? remarkOnChanged,
}) {
  return Expanded(
    flex: isFlexible ? 0 : 1,
    child: InkWell(
      onTap: () {
        switch (selectableItemType) {
          case SelectableItemType.size:

            /// Size Selector
            AppDialogs.sizeSelector(context)?.then(
              (value) {
                if (value != null && (value.runtimeType == SizeModel)) {
                  final SizeModel sizeModel = (value as SizeModel);

                  selectedSize?.value = sizeModel.size ?? "0";

                  if (sizeOnChanged != null) {
                    sizeOnChanged(sizeModel);
                  }
                }
              },
            );
            break;

          case SelectableItemType.color:

            /// Color Selector
            AppDialogs.colorSelector(context)?.then(
              (value) {
                if (value != null && (value.runtimeType == ColorModel)) {
                  final ColorModel colorModel = (value as ColorModel);

                  selectedColor?.value = colorModel.color ?? "-";

                  if (colorOnChanged != null) {
                    colorOnChanged(colorModel);
                  }
                }
              },
            );
            break;

          case SelectableItemType.diamond:

            /// Diamond Selector
            AppDialogs.diamondSelector(context)?.then(
              (value) {
                if (value != null && (value.runtimeType == Diamond)) {
                  final Diamond diamondModel = (value as Diamond);

                  selectedDiamond?.value = diamondModel.diamond ?? "";

                  printYellow(selectedDiamond);
                  if (rubyOnChanged != null) {
                    rubyOnChanged(diamondModel);
                  }
                }
              },
            );
            break;

          case SelectableItemType.remarks:
            Get.toNamed(AppRoutes.remarkScreen, arguments: {"remark": remarkSelected?.value})?.then(
              (value) {
                if (value != null) {
                  if (remarkOnChanged != null) {
                    remarkOnChanged(value);
                  }
                }
              },
            );

            break;
        }
      },
      child: Ink(
        child: Container(
          padding: EdgeInsets.all(defaultPadding / 2.4),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: switch (axisDirection) {
            /// Horizontal Selector
            Axis.horizontal => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    remarkSelected?.isNotEmpty ?? false ? selectableItemType.selectedIcon ?? '' : selectableItemType.icon,
                    height: switch (sizeColorSelectorButtonType) {
                      SizeColorSelectorButtonType.small => 12.h,
                      SizeColorSelectorButtonType.medium => 14.h,
                      SizeColorSelectorButtonType.large => 16.h,
                    },
                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                  (defaultPadding / 4).horizontalSpace,
                  Text(
                    switch (selectableItemType) {
                      SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value) ? "(0)" : "(${selectedSize?.value.split(" ").first})"}"),
                      SelectableItemType.color => ("Color ${isValEmpty(selectedColor?.value) ? "(-)" : "(${selectedColor?.value.split(" ").first})"}"),
                      SelectableItemType.diamond => isValEmpty(selectedDiamond?.value) ? "Diamond" : selectedDiamond?.value ?? '',
                      SelectableItemType.remarks => "Remark",
                    },
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: switch (sizeColorSelectorButtonType) {
                          SizeColorSelectorButtonType.small => 8.h,
                          SizeColorSelectorButtonType.medium => 10.h,
                          SizeColorSelectorButtonType.large => 14.h,
                        },
                        color: AppColors.primary),
                  )
                ],
              ),

            /// Vertical Selector
            Axis.vertical => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    remarkSelected?.isNotEmpty ?? false ? selectableItemType.selectedIcon ?? '' : selectableItemType.icon,
                    height: switch (sizeColorSelectorButtonType) {
                      SizeColorSelectorButtonType.small => 12.h,
                      SizeColorSelectorButtonType.medium => 14.h,
                      SizeColorSelectorButtonType.large => 16.h,
                    },
                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                  Text(
                    switch (selectableItemType) {
                      SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value) ? "(0)" : "(${selectedSize?.value.split(" ").first})"}"),
                      SelectableItemType.color => ("Color ${isValEmpty(selectedColor?.value) ? "(-)" : "(${selectedColor?.value.split(" ").first})"}"),
                      SelectableItemType.diamond => isValEmpty(selectedDiamond?.value) ? "Diamond" : selectedDiamond?.value ?? '',
                      SelectableItemType.remarks => "Remark",
                    },
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: switch (sizeColorSelectorButtonType) {
                          SizeColorSelectorButtonType.small => 8.h,
                          SizeColorSelectorButtonType.medium => 10.h,
                          SizeColorSelectorButtonType.large => 14.h,
                        },
                        color: AppColors.primary),
                  )
                ],
              ),
          },
        ),
      ),
    ),
  );
}
