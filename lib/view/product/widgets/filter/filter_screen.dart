import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/view/product/widgets/filter/filter_controller.dart';
import 'package:pingaksh_mobile/widgets/filter_listview_widget.dart';

import '../../../../exports.dart';
import '../../../../widgets/checkbox_title_tile.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final FilterController con = Get.put(FilterController());

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
                itemCount: con.filterTypeList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: AppColors.lightGrey.withOpacity(0.8),
                ),
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      bool isSelected = con.selectFilter.value == con.filterTypeList[index];
                      int activeCount = con.getActiveFilterCount(con.filterTypeList[index]);
                      return GestureDetector(
                        onTap: () {
                          con.filterCategoryType(index: index);
                          con.selectFilter.value = con.filterTypeList[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.5),
                          alignment: Alignment.centerLeft,
                          color: isSelected ? Theme.of(context).colorScheme.surface : AppColors.lightGrey.withOpacity(0.3),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  con.filterTypeList[index],
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.titleStyle(context).copyWith(fontSize: 14.sp, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
                                ),
                              ),
                              if (activeCount != 0)
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
            const VerticalDivider(width: 0),
            Expanded(
              flex: 2,
              child: switch (con.filterType.value) {
                FilterType.range => Padding(
                    padding: EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item name",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(left: 0, bottom: defaultPadding / 5),
                        AppTextField(
                          hintText: "Enter item name",
                          controller: con.itemNameCon.value,
                          contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                        ),
                        Divider(height: defaultPadding * 1.2),
                        Text(
                          "Metal WT",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(left: 0, bottom: defaultPadding / 5),
                        Text(
                          "${con.minMetalWt.value.toStringAsFixed(2)} - ${con.maxMetalWt.value.toStringAsFixed(2)}",
                          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
                        ).paddingOnly(left: 0),
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
                FilterType.available => FilterListViewWidget(filterTabList: con.stockAvailableList),

                //? Gender Tab UI
                FilterType.gender => FilterListViewWidget(filterTabList: con.genderList),

                //? Brand Tab UI
                FilterType.brand => FilterListViewWidget(filterTabList: con.brandList),

                //? KT Tab UI
                FilterType.kt => FilterListViewWidget(filterTabList: con.ktList),
                //? Delivery Tab UI
                FilterType.delivery => FilterListViewWidget(filterTabList: con.deliveryList),
                //? Tag Tab UI
                FilterType.tag => FilterListViewWidget(filterTabList: con.tagList),
                //? Collection Tab UI
                FilterType.collection => FilterListViewWidget(filterTabList: con.collectionList),
                //? Complexity Tab UI
                FilterType.complexity => FilterListViewWidget(filterTabList: con.complexityList),
                //? SubComplexity Tab UI
                FilterType.subComplexity => FilterListViewWidget(filterTabList: con.subComplexityList),

                //? BestSeller Tab UI
                FilterType.bestSeller => ListView.separated(
                    itemCount: con.bestSellerList.length,
                    itemBuilder: (context, index) => Obx(
                      () => CheckBoxWithTitleTile(
                        isMultiSelection: false,
                        onChanged: (_) {
                          con.selectSeller.value = con.bestSellerList[index];
                        },
                        onTap: () {
                          con.selectSeller.value = con.bestSellerList[index];
                        },
                        isCheck: (con.selectSeller.value == con.bestSellerList[index]).obs,
                        title: con.bestSellerList[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: defaultPadding / 2,
                      indent: defaultPadding,
                      endIndent: defaultPadding,
                    ),
                  ),

                //? Latest Design Tab UI
                FilterType.latestDesign => ListView.separated(
                    itemCount: con.latestDesignList.length,
                    itemBuilder: (context, index) => Obx(
                      () => CheckBoxWithTitleTile(
                        isMultiSelection: false,
                        onChanged: (_) {
                          con.selectLatestDesign.value = con.latestDesignList[index];
                        },
                        onTap: () {
                          con.selectLatestDesign.value = con.latestDesignList[index];
                        },
                        isCheck: (con.selectLatestDesign.value == con.latestDesignList[index]).obs,
                        title: con.latestDesignList[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: defaultPadding / 2,
                      indent: defaultPadding,
                      endIndent: defaultPadding,
                    ),
                  ),
              },
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Text(
                    "Clear All",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appButtonStyle(context).copyWith(color: Theme.of(context).primaryColor),
                  ).paddingSymmetric(vertical: defaultPadding / 1.5),
                  onTap: () {
                    con.clearAllFilters();
                  },
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
}
