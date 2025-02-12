import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/predefine_value_controller.dart';
import '../../../../data/model/filter/mrp_model.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/custom_check_box_tile.dart';
import '../../../../widgets/filter_listview_widget.dart';
import 'filter_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final FilterController con = Get.put(FilterController());
  final PreDefinedValueController preValCon =
      Get.find<PreDefinedValueController>();

  Color get dividerColor =>
      Theme.of(Get.context!).dividerColor.withOpacity(0.08);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "Filter",
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Row(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const RangeMaintainingScrollPhysics(),
                itemCount: con.filterOptions.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: dividerColor,
                ),
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      bool isSelected =
                          con.filterType.value == con.filterOptions[index];
                      return GestureDetector(
                        onTap: () {
                          con.filterType.value = con.filterOptions[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding / 1.5),
                          alignment: Alignment.center,
                          color: isSelected
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                con.filterOptions[index].icon,
                                height: 19.h,
                              ),
                              Text(
                                "${con.filterOptions[index].label} ${con.applyFilterCounts[index] != 0 ? "(${con.applyFilterCounts[index]})" : ""}",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.titleStyle(context)
                                    .copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.w500
                                            : FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // VerticalDivider(width: 0, color: dividerColor),
            Expanded(
              flex: 2,
              child: switch (con.filterType.value) {
                FilterItemType.range => Padding(
                    padding: EdgeInsets.only(
                        top: defaultPadding,
                        left: defaultPadding,
                        right: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metal WT(grm)",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(bottom: defaultPadding / 5),
                        Text(
                          "${con.minMetalWt.value.toStringAsFixed(2)} - ${con.maxMetalWt.value.toStringAsFixed(2)}",
                          style: AppTextStyle.titleStyle(context)
                              .copyWith(fontSize: 13.sp),
                        ),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(trackHeight: 2),
                          ),
                          child: RangeSlider(
                            values: RangeValues(
                                con.minMetalWt.value, con.maxMetalWt.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 200.0,
                            min: 0.01,
                            onChanged: (value) {
                              con.minMetalWt.value = value.start;
                              con.maxMetalWt.value = value.end;
                              con.onSilderChangeCount();
                              if (con.applyFilterCounts.isNotEmpty) {
                                con.applyFilterCounts[0] = 1;
                              }
                            },
                          ),
                        ),
                        const Divider(height: 0),
                        Text(
                          "Diamond WT",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(
                            bottom: defaultPadding / 5,
                            top: defaultPadding / 2),
                        Text(
                          "${con.minDiamondWt.value.toStringAsFixed(2)} - ${con.maxDiamondWt.value.toStringAsFixed(2)}",
                          style: AppTextStyle.titleStyle(context)
                              .copyWith(fontSize: 13.sp),
                        ),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(
                              trackHeight: 2,
                            ),
                          ),
                          child: RangeSlider(
                            values: RangeValues(
                                con.minDiamondWt.value, con.maxDiamondWt.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 20,
                            min: 0.01,
                            onChanged: (value) {
                              con.minDiamondWt.value = value.start;
                              con.maxDiamondWt.value = value.end;
                              con.onSilderChangeCount();

                              if (con.applyFilterCounts.isNotEmpty) {
                                con.applyFilterCounts[0] = 1;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                FilterItemType.mrp => Column(
                    children: [
                      Obx(() {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const RangeMaintainingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          itemBuilder: (context, index) => Obx(() {
                            return CustomCheckboxTile(
                              scale: 1,
                              isSelected: (con.selectMrp.value.label ==
                                      con.mrpList[index].label)
                                  .obs,
                              title: con.mrpList[index].label?.value,
                              titleStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: con.selectMrp.value.label ==
                                          con.mrpList[index].label
                                      ? FontWeight.w500
                                      : FontWeight.w400),
                              onChanged: (value) {
                                if (value == false) {
                                  con.selectMrp.value = MrpModel();
                                } else {
                                  con.selectMrp.value = con.mrpList[index];
                                }
                                if (con.selectMrp.value.label != null &&
                                    con.selectMrp.value.label!.isNotEmpty) {
                                  con.count++;
                                  con.applyFilterCounts[1] = 1;
                                } else {
                                  con.count--;
                                  con.applyFilterCounts[1] = 0;
                                }

                                con.selectMrp.refresh();
                              },
                            );
                          }),
                          separatorBuilder: (context, index) => separateDivider,
                          itemCount: con.mrpList.length,
                        );
                      }),
                      CustomCheckboxTile(
                        scale: 1,
                        isSelected:
                            (con.selectMrp.value.label?.value == 'customs').obs,
                        title: "Customs",
                        titleStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: con.selectMrp.value.label
                                        .toString()
                                        .toLowerCase() ==
                                    'customs'
                                ? FontWeight.w500
                                : FontWeight.w400),
                        onChanged: (value) {
                          if (value == false) {
                            con.selectMrp.value = MrpModel();
                          } else {
                            con.selectMrp.value =
                                MrpModel(label: "customs".obs);
                          }
                          (con.selectMrp.value.label != null &&
                                  con.selectMrp.value.label!.isNotEmpty)
                              ? con.applyFilterCounts[1] = 1
                              : con.applyFilterCounts[1] = 0;
                        },
                      ),
                      10.verticalSpace,
                      if (con.selectMrp.value.label == "customs".obs)
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hintText: "From",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.font.withOpacity(.5)),
                                controller: con.mrpFromCon.value,
                                padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 1.4)
                                    .copyWith(right: 0),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 1.5,
                                    horizontal: defaultPadding),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(defaultRadius),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                onChanged: (val) {
                                  con.selectMrp.value.min?.value;
                                },
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: AppTextField(
                                hintText: "To",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.font.withOpacity(.5)),
                                controller: con.mrpToCon.value,
                                padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 1.4)
                                    .copyWith(left: 0),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 1.5,
                                    horizontal: defaultPadding),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(defaultRadius),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),

                //? Available Tab UI
                FilterItemType.available => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemBuilder: (context, index) => CustomCheckboxTile(
                      scale: 1,
                      title: con.availableList[index].title ?? "",
                      isSelected: con.isAvailable,
                      onChanged: (val) {
                        if (val != null) {
                          con.isAvailable.value = val;
                          if (con.isAvailable.isTrue) {
                            con.count++;
                          } else {
                            con.count--;
                          }
                          con.isAvailable.value
                              ? con.applyFilterCounts[2] = 1
                              : con.applyFilterCounts[2] = 0;
                        }
                      },
                    ),
                    separatorBuilder: (context, index) => separateDivider,
                    itemCount: con.availableList.length,
                  ),

                //? Gender Tab UI
                FilterItemType.gender => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemCount: preValCon.genderList.length,
                    separatorBuilder: (context, index) => separateDivider,
                    itemBuilder: (context, index) => Obx(() {
                      return CustomCheckboxTile(
                        scale: 1,
                        title: preValCon.genderList[index].capitalizeFirst,
                        isSelected: RxBool(con.selectedGender
                            .contains(preValCon.genderList[index])),
                        onChanged: (val) {
                          if (con.selectedGender
                              .contains(preValCon.genderList[index])) {
                            con.selectedGender
                                .remove(preValCon.genderList[index]);
                            if (con.selectedGender.isEmpty) {
                              con.count--;
                            }
                          } else {
                            if (con.selectedGender.isEmpty) {
                              con.count++;
                            }
                            con.selectedGender.add(preValCon.genderList[index]);
                          }

                          con.applyFilterCounts[3] = con.selectedGender.length;
                        },
                      );
                    }),
                  ),

                //? diamond Type Tab UI
                FilterItemType.diamond => FilterListViewWidget(
                    diamondList: preValCon.diamondsList,
                    type: FilterItemType.diamond,
                    onSelect: () {
                      con.applyFilterCounts[4] = con.selectedDiamonds.length;
                    },
                  ),

                //? KT Tab UI
                FilterItemType.kt => FilterListViewWidget(
                    metalList: preValCon.metalsList,
                    type: FilterItemType.kt,
                    onSelect: () {
                      con.applyFilterCounts[5] = con.selectedKt.length;
                    },
                  ),

                //? Delivery Tab UI
                FilterItemType.delivery => FilterListViewWidget(
                    deliveryList: preValCon.deliveriesList,
                    type: FilterItemType.delivery,
                    onSelect: () {
                      con.applyFilterCounts[6] = con.selectedDelivery.length;
                    },
                  ),

                //? Tag Tab UI
                FilterItemType.production => FilterListViewWidget(
                    deliveryList: preValCon.productNamesList,
                    type: FilterItemType.production,
                    onSelect: () {
                      con.applyFilterCounts[7] =
                          con.selectedProductNames.length;
                    },
                  ),

                //? Collection Tab UI
                FilterItemType.collection => FilterListViewWidget(
                    collectionList: preValCon.collectionList,
                    type: FilterItemType.collection,
                    onSelect: () {
                      con.applyFilterCounts[8] = con.selectedCollections.length;
                    },
                  )
              },
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(
              bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  height: 30.h,
                  title: "Clear All",
                  buttonType: ButtonType.outline,
                  onPressed: () async {
                    con.clearAllFilters();
                    await ProductRepository.getFilterProductsListAPI(
                      productsListType: con.productsListType,
                      watchListId: con.watchlistId,
                      categoryId: con.categoryId,
                      subCategoryId: con.subCategoryId,
                    ).then((value) => Get.back());
                  },
                ),
              ),
              defaultPadding.horizontalSpace,
              Expanded(
                child: AppButton(
                  loader: con.isLoader.value,
                  height: 30.h,
                  title: "Apply",
                  onPressed: () async {
                    /// GET FILTER PRODUCT
                    await ProductRepository.getFilterProductsListAPI(
                      watchListId: con.watchlistId,
                      productsListType: con.productsListType,
                      loader: con.isLoader,
                      categoryId: con.categoryId,
                      subCategoryId: con.subCategoryId,
                      minMetal: con.minMetalWt.value,
                      maxMetal: con.maxMetalWt.value,
                      minDiamond: con.minDiamondWt.value,
                      maxDiamond: con.maxDiamondWt.value,
                      minMrp: con.selectMrp.value.min?.value,
                      maxMrp: con.selectMrp.value.max?.value,
                      inStock: con.isAvailable.value,
                      genderList: con.selectedGender,
                      diamondList: con.selectedDiamonds,
                      ktList: con.selectedKt,
                      deliveryList: con.selectedDelivery,
                      productionNameList: con.selectedProductNames,
                      collectionList: con.selectedCollections,
                    ).then((value) => Get.back(result: con.count));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider get separateDivider => Divider(
      height: defaultPadding / 2,
      indent: defaultPadding,
      endIndent: defaultPadding);
}
