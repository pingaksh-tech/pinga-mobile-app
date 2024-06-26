import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';
import '../../controller/predefine_value_controller.dart';
import '../../data/model/predefined_model/predefined_model.dart';
import '../../packages/marquee_widget/marquee_widget.dart';

Widget horizontalSelectorButton(
  BuildContext context, {
  RxString? selectedSize,
  String? categorySlug,
  RxString? selectedColor,
  RxString? selectedDiamond,
  RxString? remarkSelected,
  RxString? productName,
  required SelectableItemType selectableItemType,
  SizeColorSelectorButtonType sizeColorSelectorButtonType = SizeColorSelectorButtonType.medium,
  Color? backgroundColor,
  bool isFlexible = false,
  Axis axisDirection = Axis.horizontal,
  Function(SizeModel model)? sizeOnChanged,
  Function(SizeModel model)? colorOnChanged,
  Function(SizeModel model)? rubyOnChanged,
  Function(String model)? remarkOnChanged,
}) {
  return Expanded(
    flex: isFlexible ? 0 : 1,
    child: InkWell(
      onTap: () async {
        switch (selectableItemType) {
          case SelectableItemType.size:
            //
            if (isRegistered<PreDefinedValueController>()) {
              final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
              List<SizeModel> sizeList = await preValueCon.checkHasPreValue(categorySlug ?? '', type: selectableItemType.slug);

              /// Size Selector
              AppDialogs.sizeSelector(context, sizeList: sizeList.obs, selectedSize: selectedSize ?? ''.obs)?.then(
                (value) {
                  if (value != null && (value.runtimeType == SizeModel)) {
                    final SizeModel sizeModel = (value as SizeModel);

                    selectedSize?.value = sizeModel.label ?? "0";

                    if (sizeOnChanged != null) {
                      sizeOnChanged(sizeModel);
                    }
                  }
                },
              );
            }
            break;

          case SelectableItemType.color:
            if (isRegistered<PreDefinedValueController>()) {
              final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
              List<SizeModel> colorList = await preValueCon.checkHasPreValue(categorySlug ?? '', type: selectableItemType.slug);
              if (selectedColor != null && selectedColor.isEmpty) {
                selectedColor.value = colorList[0].id ?? '';
              }

              /// Color Selector
              AppDialogs.colorSelector(context, colorList: colorList.obs, selectedColor: selectedColor ?? ''.obs)?.then(
                (value) {
                  if (value != null && (value.runtimeType == SizeModel)) {
                    final SizeModel colorModel = (value as SizeModel);

                    selectedColor?.value = colorModel.value?.value ?? "-";

                    if (colorOnChanged != null) {
                      colorOnChanged(colorModel);
                    }
                  }
                },
              );
            }
            break;

          case SelectableItemType.diamond:
            if (isRegistered<PreDefinedValueController>()) {
              final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
              List<SizeModel> diamondList = await preValueCon.checkHasPreValue(categorySlug ?? '', type: selectableItemType.slug);
              if (selectedDiamond != null && selectedDiamond.isEmpty) {
                selectedDiamond.value = diamondList[0].id ?? '';
              }

              /// Diamond Selector
              AppDialogs.diamondSelector(context, diamondList: diamondList.obs, selectedDiamond: selectedDiamond ?? ''.obs)?.then(
                (value) {
                  if (value != null && (value.runtimeType == SizeModel)) {
                    final SizeModel diamondModel = (value as SizeModel);

                    selectedDiamond?.value = diamondModel.value?.value ?? "";

                    if (rubyOnChanged != null) {
                      rubyOnChanged(diamondModel);
                    }
                  }
                },
              );
            }
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
          case SelectableItemType.stock:
            Get.toNamed(AppRoutes.cartStockScreen, arguments: {"productName": productName?.value ?? ""});
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
          alignment: Alignment.center,
          child: switch (axisDirection) {
            /// Horizontal Selector
            Axis.horizontal => MarqueeWidget(
                child: Row(
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
                    (defaultPadding / 5).horizontalSpace,
                    Text(
                      switch (selectableItemType) {
                        SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value) ? "(0)" : "(${selectedSize?.value.split(" ").first})"}"),
                        SelectableItemType.color => ("Color ${isValEmpty(selectedColor?.value) ? "(Y)" : "(${selectedColor?.value})"}"),
                        SelectableItemType.diamond => isValEmpty(selectedDiamond?.value) ? "VVS-EF" : selectedDiamond?.value ?? '',
                        SelectableItemType.remarks => "Remark",
                        SelectableItemType.stock => "Stock",
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
                  MarqueeWidget(
                    child: Text(
                      switch (selectableItemType) {
                        SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value) ? "(0)" : "(${selectedSize?.value.split(" ").first})"}"),
                        SelectableItemType.color => ("Color ${isValEmpty(selectedColor?.value) ? "(-)" : "(${selectedColor?.value.split(" ").first})"}"),
                        SelectableItemType.diamond => isValEmpty(selectedDiamond?.value) ? "VVS-EF" : selectedDiamond?.value ?? '',
                        SelectableItemType.remarks => "Remark",
                        SelectableItemType.stock => "Stock",
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: switch (sizeColorSelectorButtonType) {
                            SizeColorSelectorButtonType.small => 8.h,
                            SizeColorSelectorButtonType.medium => 10.h,
                            SizeColorSelectorButtonType.large => 14.h,
                          },
                          color: AppColors.primary),
                    ),
                  )
                ],
              ),
          },
        ),
      ),
    ),
  );
}
