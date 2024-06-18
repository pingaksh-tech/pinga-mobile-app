import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'order_filter_controller.dart';

class OrderFilterScreen extends StatelessWidget {
  OrderFilterScreen({super.key});

  final OrderFilterController con = Get.put(OrderFilterController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "Filter",
        ),
        body: Row(
          children: [
            //? Filter Type ListView
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: OrderFilterType.values.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      bool isSelected = con.filterType.value != OrderFilterType.values[index];
                      return GestureDetector(
                        onTap: () {
                          con.filterType.value = OrderFilterType.values[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.5),
                          alignment: Alignment.centerLeft,
                          color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).scaffoldBackgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  OrderFilterType.values[index].label,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.titleStyle(context).copyWith(fontSize: 14.sp, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
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
            //? Filter type UI
            Expanded(
              flex: 2,
              child: switch (con.filterType.value) {
                OrderFilterType.type => Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User",
                          style: titleTextStyle,
                        ).paddingOnly(bottom: defaultPadding / 3),
                        InputDecorator(
                          decoration: InputDecoration(
                            fillColor: const Color(0x1EB4B4B4),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                              borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.1)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding / 2).copyWith(left: defaultPadding / 1.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              elevation: 1,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              isExpanded: true,
                              hint: const Text('Please Select'),
                              value: con.selectUserType.value.isEmpty ? null : con.selectUserType.value,
                              onChanged: (newValue) {
                                con.selectUserType.value = newValue ?? "";
                              },
                              items: con.userType.map<DropdownMenuItem<String>>(
                                (String userType) {
                                  return DropdownMenuItem<String>(
                                    value: userType,
                                    child: Text(
                                      userType,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                //? Filter Type date UI
                OrderFilterType.date => Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Date",
                          style: titleTextStyle,
                        ).paddingOnly(bottom: defaultPadding / 3),
                        AppTextField(
                          textFieldType: TextFieldType.date,
                          controller: con.startDateCon.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultPadding / 1.5).copyWith(right: 0),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          hintText: "Select start date",
                          selectedDate: con.startDate.value,
                          suffixIconSize: 20.w,
                          onDateOrTimeChange: (value) {
                            if (value.runtimeType == DateTime) {
                              con.startDateCon.value.text = UiUtils.convertDateToDotSeparate(value);
                              con.startDate.value = value;
                            }
                          },
                        ),
                        defaultPadding.verticalSpace,
                        Text(
                          "End Date",
                          style: titleTextStyle,
                        ).paddingOnly(bottom: defaultPadding / 3),
                        AppTextField(
                          textFieldType: TextFieldType.date,
                          controller: con.endDateCon.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultPadding / 1.5),
                          hintText: "Select end date",
                          selectedDate: con.endDate.value,
                          suffixIconSize: 20.w,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          onDateOrTimeChange: (value) {
                            if (value.runtimeType == DateTime) {
                              con.endDateCon.value.text = UiUtils.convertDateToDotSeparate(value);
                              con.endDate.value = value;
                            }
                          },
                        ),
                      ],
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

  TextStyle? get titleTextStyle => Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp);
}
