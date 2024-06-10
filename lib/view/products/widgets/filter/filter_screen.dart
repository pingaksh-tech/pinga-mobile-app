import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/checkbox_title_tile.dart';
import '../../../../widgets/filter_listview_widget.dart';
import 'filter_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final FilterController con = Get.put(FilterController());
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
              flex: 1,
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
                          alignment: Alignment.centerLeft,
                          color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).scaffoldBackgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  FilterItemType.values[index].label,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.titleStyle(context).copyWith(fontSize: 14.sp, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
                                ),
                              ),

                              ///?Active filter count design
                              /*   if (activeCount != 0)
                                Container(
                                  height: 15.h,
                                  width: 15.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    activeCount.toString(),
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: Theme.of(context).colorScheme.surface,
                                          fontSize: 10.sp,
                                        ),
                                  ),
                                ), */
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
                FilterItemType.rang => Padding(
                    padding: EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metal WT",
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
                            max: 12,
                            min: 0,
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
                            max: 50,
                            min: 0,
                            onChanged: (value) {
                              con.minDiamondWt.value = value.start;
                              con.maxDiamondWt.value = value.end;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                //? Available Tab UI
                FilterItemType.available => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemBuilder: (context, index) => CheckBoxWithTitleTile(
                      title: con.availableList[index].title ?? "",
                      isCheck: (con.availableList[index].isChecked?.value ?? true).obs,
                    ),
                    separatorBuilder: (context, index) => separateDivider,
                    itemCount: con.availableList.length,
                  ),

                //? Gender Tab UI
                FilterItemType.gender => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemBuilder: (context, index) => CheckBoxWithTitleTile(
                      title: con.genderList[index].title ?? "",
                      isCheck: RxBool(con.genderList[index].isChecked ?? false),
                    ),
                    separatorBuilder: (context, index) => separateDivider,
                    itemCount: con.genderList.length,
                  ),

                //? diamond Type Tab UI
                FilterItemType.diamond => FilterListViewWidget(filterTabList: con.diamondList),

                //? KT Tab UI
                FilterItemType.kt => FilterListViewWidget(filterTabList: con.ktList),

                //? Delivery Tab UI
                FilterItemType.delivery => FilterListViewWidget(filterTabList: con.deliveryList),

                //? Tag Tab UI
                FilterItemType.production => FilterListViewWidget(filterTabList: con.productionNameList),

                //? Collection Tab UI
                FilterItemType.collection => FilterListViewWidget(filterTabList: con.collectionList)
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
                  onPressed: () {},
                ),
              ),
              defaultPadding.horizontalSpace,
              Expanded(
                child: AppButton(
                  height: 30.h,
                  title: "Apply",
                  onPressed: () => Get.back(),
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
