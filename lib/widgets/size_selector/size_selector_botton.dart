import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_dialog.dart';
import '../../controller/predefine_value_controller.dart';
import '../../data/model/common/splash_model.dart';
import '../../data/model/product/products_model.dart';
import '../../packages/marquee_widget/marquee_widget.dart';

Widget horizontalSelectorButton(
  BuildContext context, {
  String? categorySlug,
  RxString? selectedSizeCart,
  Rx<DiamondModel>? selectedSize,
  Rx<MetalModel>? selectedMetal,
  Rx<DiamondModel>? selectedDiamond,
  bool isFancy = false,
  RxList<DiamondListModel>? diamondsList,
  RxString? remarkSelected,
  RxString? productName,
  required SelectableItemType selectableItemType,
  SizeColorSelectorButtonType sizeColorSelectorButtonType = SizeColorSelectorButtonType.medium,
  Color? backgroundColor,
  bool isFlexible = false,
  Axis axisDirection = Axis.horizontal,
  Function(DiamondModel model)? sizeOnChanged,
  Function(MetalModel model)? metalOnChanged,
  Function(DiamondModel model)? rubyOnChanged,
  Function(List<DiamondListModel> listModel)? multiRubyOnChanged,
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
              RxList<CategoryWiseSize> allSizeList = preValueCon.categoryWiseSizesList;
              RxList<DiamondModel> sizeList = <DiamondModel>[].obs;

              for (var element in allSizeList) {
                if (element.name?.toLowerCase() == categorySlug?.toLowerCase() && element.data != null) {
                  sizeList = element.data!.obs;
                }
              }

              /// Size Selector
              AppDialogs.sizeSelector(context, sizeList: sizeList, selectedSize: selectedSizeCart ?? selectedSize?.value.id ?? "".obs)?.then(
                (value) {
                  if (value != null && (value.runtimeType == DiamondModel)) {
                    final DiamondModel sizeModel = (value as DiamondModel);
                    selectedSize?.value = sizeModel;

                    int index = sizeList.indexWhere((element) => element.id == sizeModel.id);
                    if (index != -1) {
                      selectedSize?.value = sizeList[index];
                    }

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
              RxList<MetalModel> colorList = preValueCon.metalsList;

              /// Metal Selector
              AppDialogs.colorSelector(context, colorList: colorList, selectedColor: selectedMetal?.value.id ?? "".obs)?.then(
                (value) {
                  if (value != null && (value.runtimeType == MetalModel)) {
                    final MetalModel metalModel = (value as MetalModel);

                    selectedMetal?.value = metalModel;

                    if (metalOnChanged != null) {
                      metalOnChanged(metalModel);
                    }
                  }
                },
              );
            }
            break;

          case SelectableItemType.diamond:
            if (isRegistered<PreDefinedValueController>()) {
              /// Diamond Selector
              if (isFancy) {
                /// MULTI DIAMOND
                AppDialogs.multiDiamondSelector(context, diamondList: diamondsList)?.then(
                  (value) {
                    if (value != null && (value.runtimeType == DiamondModel)) {
                      final DiamondModel diamondModel = (value as DiamondModel);

                      selectedDiamond?.value = diamondModel;

                      if (multiRubyOnChanged != null) {
                        multiRubyOnChanged(diamondsList ?? []);
                      }
                    }
                  },
                );
              } else {
                final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
                RxList<DiamondModel> diamondList = preValueCon.diamondsList;

                /// SINGLE DIAMOND
                AppDialogs.diamondSelector(context, diamondList: diamondList, selectedDiamond: selectedDiamond?.value.id ?? ''.obs)?.then(
                  (value) {
                    if (value != null && (value.runtimeType == DiamondModel)) {
                      final DiamondModel diamondModel = (value as DiamondModel);

                      selectedDiamond?.value = diamondModel;

                      if (rubyOnChanged != null) {
                        rubyOnChanged(diamondModel);
                      }
                    }
                  },
                );
              }
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
                        SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value.shortName) ? "(0)" : "(${selectedSize?.value.shortName})"}"),
                        SelectableItemType.color => ("Metal ${isValEmpty(selectedMetal?.value.shortName) ? "(-)" : "(${selectedMetal?.value.shortName})"}"),
                        SelectableItemType.diamond => isValEmpty(selectedDiamond?.value.shortName) ? "-" : selectedDiamond?.value.shortName ?? '',
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
                        SelectableItemType.size => ("Size ${isValEmpty(selectedSize?.value.shortName) ? "(0)" : "(${selectedSize?.value.shortName})"}"),
                        SelectableItemType.color => ("Metal ${isValEmpty(selectedMetal?.value.shortName) ? "(-)" : "(${selectedMetal?.value.shortName?.split(" ").first})"}"),
                        SelectableItemType.diamond => isValEmpty(selectedDiamond?.value.shortName) ? "-" : selectedDiamond?.value.shortName ?? '',
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
