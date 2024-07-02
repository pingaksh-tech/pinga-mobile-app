import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/predefine_value_controller.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/custom_check_box_tile.dart';
import '../../../../widgets/filter_listview_widget.dart';
import 'filter_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final FilterController con = Get.put(FilterController());
  final PreDefinedValueController preValCon = Get.find<PreDefinedValueController>();

  Color get dividerColor => Theme.of(Get.context!).dividerColor.withOpacity(0.08);

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
                itemCount: FilterItemType.values.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: dividerColor,
                ),
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      bool isSelected = con.filterType.value == FilterItemType.values[index];
                      // int activeCount = con.getActiveFilterCount(FilterItemType.values[index].label);
                      return GestureDetector(
                        onTap: () {
                          con.filterType.value = FilterItemType.values[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.5),
                          alignment: Alignment.center,
                          color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                FilterItemType.values[index].icon,
                                height: 19.h,
                              ),
                              Text(
                                FilterItemType.values[index].label,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
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
                    padding: EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metal WT(grm)",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(bottom: defaultPadding / 5),
                        Text(
                          "${con.minMetalWt.value.toStringAsFixed(2)} - ${con.maxMetalWt.value.toStringAsFixed(2)}",
                          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
                        ),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(trackHeight: 2),
                          ),
                          child: RangeSlider(
                            values: RangeValues(con.minMetalWt.value, con.maxMetalWt.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 200.0,
                            min: 0.01,
                            onChanged: (value) {
                              con.minMetalWt.value = value.start;
                              con.maxMetalWt.value = value.end;
                            },
                          ),
                        ),
                        const Divider(height: 0),
                        Text(
                          "Diamond WT",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(bottom: defaultPadding / 5, top: defaultPadding / 2),
                        Text(
                          "${con.minDiamondWt.value.toStringAsFixed(2)} - ${con.maxDiamondWt.value.toStringAsFixed(2)}",
                          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
                        ),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(
                              trackHeight: 2,
                            ),
                          ),
                          child: RangeSlider(
                            values: RangeValues(con.minDiamondWt.value, con.maxDiamondWt.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 20,
                            min: 0.01,
                            onChanged: (value) {
                              con.minDiamondWt.value = value.start;
                              con.maxDiamondWt.value = value.end;
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
                          padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                          itemBuilder: (context, index) => Obx(() {
                            return CustomCheckboxTile(
                              scale: 1,
                              isSelected: (con.selectMrp['label'] == con.mrpList[index]['label']).obs,
                              title: con.mrpList[index]['label'].value,
                              titleStyle: TextStyle(fontSize: 13.sp, fontWeight: con.selectMrp['label'] == con.mrpList[index]['label'] ? FontWeight.w500 : FontWeight.w400),
                              onChanged: (value) {
                                if (value == false) {
                                  con.selectMrp.value = {"label": "".obs, "min": 0, "max": 0} as Map<dynamic, dynamic>;
                                } else {
                                  con.selectMrp.value = con.mrpList[index];
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
                        isSelected: (con.selectMrp['label'] == 'customs').obs,
                        title: "Customs",
                        titleStyle: TextStyle(fontSize: 13.sp, fontWeight: con.selectMrp['label'].toString().toLowerCase() == 'customs' ? FontWeight.w500 : FontWeight.w400),
                        onChanged: (value) {
                          if (value == false) {
                            con.selectMrp.value = {"label": "".obs, "min": 0, "max": 0} as Map<dynamic, dynamic>;
                          } else {
                            con.selectMrp.value = {"label": "customs".obs, "min": 0, "max": 0} as Map<dynamic, dynamic>;
                          }
                        },
                      ),
                      10.verticalSpace,
                      if (con.selectMrp['label'] == "customs".obs)
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hintText: "From",
                                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.font.withOpacity(.5)),
                                controller: con.mrpFromCon.value,
                                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.4).copyWith(right: 0),
                                contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.5, horizontal: defaultPadding),
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(defaultRadius),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: AppTextField(
                                hintText: "To",
                                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.font.withOpacity(.5)),
                                controller: con.mrpToCon.value,
                                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.4).copyWith(left: 0),
                                contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.5, horizontal: defaultPadding),
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
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
                      isSelected: con.isAvailable ?? false.obs,
                      onChanged: (val) {
                        if (val != null) {
                          con.isAvailable?.value = val;
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
                    itemBuilder: (context, index) => CustomCheckboxTile(
                      scale: 1,
                      title: preValCon.genderList[index].capitalizeFirst,
                      isSelected: RxBool(con.selectedGender.contains(preValCon.genderList[index])),
                      onChanged: (val) {
                        if (con.selectedGender.contains(preValCon.genderList[index])) {
                          con.selectedGender.remove(preValCon.genderList[index]);
                        } else {
                          con.selectedGender.add(preValCon.genderList[index]);
                        }
                      },
                    ),
                  ),

                //? diamond Type Tab UI
                FilterItemType.diamond => FilterListViewWidget(
                    diamondList: preValCon.diamondsList,
                    type: FilterItemType.diamond,
                    onSelect: (value) {
                      con.selectedDiamonds.value = value;
                    },
                  ),

                //? KT Tab UI
                FilterItemType.kt => FilterListViewWidget(
                    metalList: preValCon.metalsList,
                    type: FilterItemType.kt,
                    onSelect: (value) {
                      con.selectedKt.value = value;
                    },
                  ),

                //? Delivery Tab UI
                FilterItemType.delivery => FilterListViewWidget(
                    deliveryList: preValCon.deliveriesList,
                    type: FilterItemType.delivery,
                    onSelect: (value) {
                      con.selectedDelivery.value = value;
                    },
                  ),

                //? Tag Tab UI
                FilterItemType.production => FilterListViewWidget(
                    deliveryList: preValCon.productNamesList,
                    type: FilterItemType.production,
                    onSelect: (value) {
                      con.selectedProductNames.value = value;
                    },
                  ),

                //? Collection Tab UI
                FilterItemType.collection => FilterListViewWidget(
                    filterTabList: con.collectionList,
                    type: FilterItemType.collection,
                    onSelect: (value) {
                      con.selectedCollections.value = value;
                    },
                  )
              },
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  height: 30.h,
                  title: "Clear All",
                  buttonType: ButtonType.outline,
                  onPressed: () {
                    con.clearAllFilters();
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
                    await ProductRepository.getFilterProductsListAPI(
                      productsListType: ProductsListType.normal,
                      loader: con.isLoader,
                      categoryId: con.categoryId,
                      subCategoryId: con.subCategoryId,
                      minMetal: con.minMetalWt.value,
                      maxMetal: con.maxMetalWt.value,
                      minDiamond: con.minDiamondWt.value,
                      maxDiamond: con.maxDiamondWt.value,
                      minMrp: con.selectMrp['min'],
                      maxMrp: con.selectMrp['max'],
                      inStock: con.isAvailable?.value,
                      genderList: con.selectedGender,
                      diamondList: con.selectedDiamonds,
                      ktList: con.selectedKt,
                      deliveryList: con.selectedDelivery,
                      productionNameList: con.selectedProductNames,
                      colectionList: con.selectedCollections,
                    ).then((value) => Get.back());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider get separateDivider => Divider(height: defaultPadding / 2, indent: defaultPadding, endIndent: defaultPadding);
}
