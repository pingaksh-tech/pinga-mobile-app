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
                itemCount: con.filterTypeList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: AppColors.lightGrey.withOpacity(0.8),
                ),
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      bool isSelected = con.selectFilter.value == con.filterTypeList[index];
                      bool isActive = con.isFilterActive(con.filterTypeList[index]);
                      return GestureDetector(
                        onTap: () {
                          con.filterCategoryType(index: index);
                          con.selectFilter.value = con.filterTypeList[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.5),
                          alignment: Alignment.centerLeft,
                          color: isSelected ? Theme.of(context).colorScheme.surface : AppColors.lightGrey.withOpacity(0.3),
                          child: Column(
                            children: [
                              // const Icon(Icons.price_change),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      con.filterTypeList[index],
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.titleStyle(context).copyWith(fontSize: 14.sp, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
                                    ),
                                  ),
                                  if (isActive)
                                    Container(
                                      width: 8.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
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
                          "${UiUtils.amountFormat(con.minPrice.value.toString(), decimalDigits: 0)} - ${UiUtils.amountFormat(con.maxPrice.value.toString(), decimalDigits: 0)}",
                          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
                        ).paddingOnly(left: 0),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(
                              trackHeight: 2,
                            ),
                          ),
                          child: RangeSlider(
                            values: RangeValues(con.minPrice.value, con.maxPrice.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 10000,
                            min: 5000,
                            onChanged: (value) {
                              con.minPrice.value = value.start;
                              con.maxPrice.value = value.end;
                            },
                          ),
                        ),
                        const Divider(height: 0),
                        Text(
                          "Diamond WT",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).paddingOnly(bottom: defaultPadding / 5, top: defaultPadding / 2),
                        Text(
                          "${UiUtils.amountFormat(con.minPrice.value.toString(), decimalDigits: 0)} - ${UiUtils.amountFormat(con.maxPrice.value.toString(), decimalDigits: 0)}",
                          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
                        ),
                        Theme(
                          data: ThemeData(
                            sliderTheme: const SliderThemeData(
                              trackHeight: 2,
                            ),
                          ),
                          child: RangeSlider(
                            values: RangeValues(con.minPrice.value, con.maxPrice.value),
                            activeColor: Theme.of(context).primaryColor,
                            max: 10000,
                            min: 5000,
                            onChanged: (value) {
                              con.minPrice.value = value.start;
                              con.maxPrice.value = value.end;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                FilterType.available => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Available"),
                      Expanded(
                        child: FilterListViewWidget(
                          filterTabList: con.stockAvailableList,
                        ),
                      ),
                    ],
                  ).paddingOnly(left: defaultPadding),
                FilterType.gender => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemCount: con.genderList.length,
                    itemBuilder: (context, index) => CheckBoxWithTitleTile(
                      title: con.genderList[index]["title"],
                      isCheck: con.genderList[index]["isChecked"],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: defaultPadding / 2,
                      indent: defaultPadding,
                      endIndent: defaultPadding,
                    ),
                  ),
                FilterType.kt => Container(),
                FilterType.brand => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemBuilder: (context, index) => CheckBoxWithTitleTile(
                      title: con.brandList[index]["title"],
                      isCheck: con.brandList[index]["isChecked"],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: defaultPadding / 2,
                      indent: defaultPadding,
                      endIndent: defaultPadding,
                    ),
                    itemCount: con.brandList.length,
                  ),
                FilterType.jewellery => ListView.separated(
                    physics: const RangeMaintainingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                    itemBuilder: (context, index) => CheckBoxWithTitleTile(
                      title: con.jewelryTypeList[index]["title"],
                      isCheck: con.jewelryTypeList[index]["isChecked"],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: defaultPadding / 2,
                      indent: defaultPadding,
                      endIndent: defaultPadding,
                    ),
                    itemCount: con.jewelryTypeList.length,
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
