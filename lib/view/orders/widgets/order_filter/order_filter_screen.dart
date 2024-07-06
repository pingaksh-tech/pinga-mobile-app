import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/orders/orders_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_dialog.dart';
import '../../orders_controller.dart';
import 'order_filter_controller.dart';

class OrderFilterScreen extends StatelessWidget {
  OrderFilterScreen({super.key});

  final OrderFilterController con = Get.put(OrderFilterController());
  final OrdersController ordersController = Get.find<OrdersController>();

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
                      bool isSelected = con.filterType.value == OrderFilterType.values[index];
                      return GestureDetector(
                        onTap: () {
                          con.filterType.value = OrderFilterType.values[index];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.5),
                          alignment: Alignment.center,
                          color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                OrderFilterType.values[index].icon,
                                height: 19.h,
                              ),
                              Text(
                                OrderFilterType.values[index].label,
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
            const VerticalDivider(width: 0),
            //? Filter type UI
            Expanded(
              flex: 2,
              child: switch (con.filterType.value) {
                OrderFilterType.type => Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          title: "Retailers",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultPadding / 1.5),
                          readOnly: true,
                          controller: con.retailerCon.value,
                          hintText: "Select Retailers",
                          padding: EdgeInsets.only(bottom: defaultPadding, top: defaultPadding / 2),
                          suffixIcon: con.retailerCon.value.text.isEmpty
                              ? SvgPicture.asset(
                                  AppAssets.downArrow,
                                  height: 10,
                                )
                              : SvgPicture.asset(
                                  AppAssets.crossIcon,
                                  height: 20,
                                ),
                          suffixOnTap: con.retailerCon.value.text.isNotEmpty
                              ? () async {
                                  FocusScope.of(context).unfocus();

                                  con.retailerCon.value.clear();
                                  con.retailerId = "";
                                }
                              : null,
                          onTap: () {
                            AppDialogs.retailerSelect(
                              context,
                              selectedRetailer: con.retailerId.obs,
                            )?.then(
                              (value) {
                                if (value != null && (value.runtimeType == RetailerModel)) {
                                  final RetailerModel retailerModel = (value as RetailerModel);
                                  con.retailerModel.value = retailerModel;
                                  con.retailerCon.value.text = con.retailerModel.value.businessName ?? "";
                                  con.retailerId = con.retailerModel.value.id?.value ?? "";
                                }
                              },
                            );
                          },
                        ),
                        /*   Text(
                          "User",
                          style: titleTextStyle,
                        ).paddingOnly(bottom: defaultPadding / 3), */
                        /*  InputDecorator(
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
                        ), */
                      ],
                    ),
                  ),

                //? Filter Type date UI
                OrderFilterType.date => Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          title: "Start Date",
                          textFieldType: TextFieldType.date,
                          controller: con.startDateCon.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultPadding / 1.5).copyWith(right: 0),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          hintText: "Select start date",
                          selectedDate: con.startDate.value,
                          suffixIconSize: 20.w,
                          validation: con.startDateValidation.value,
                          errorMessage: con.dateError.value,
                          suffixIcon: con.startDateCon.value.text.isNotEmpty
                              ? SvgPicture.asset(
                                  AppAssets.crossIcon,
                                  height: 20,
                                )
                              : null,
                          suffixOnTap: con.startDateCon.value.text.isNotEmpty
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  con.startDateCon.value.clear();
                                  con.startDateValidation.value = true;
                                }
                              : null,
                          onDateOrTimeChange: (value) {
                            if (value.runtimeType == DateTime) {
                              con.startDateCon.value.text = UiUtils.convertDateToDotSeparate(value);
                              con.startDate.value = value;
                              con.startDateValidation.value = true;
                            }
                          },
                        ),
                        defaultPadding.verticalSpace,
                        AppTextField(
                          title: "End Date",
                          textFieldType: TextFieldType.date,
                          controller: con.endDateCon.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultPadding / 1.5),
                          hintText: "Select end date",
                          selectedDate: con.endDate.value,
                          validation: con.endDateValidation.value,
                          errorMessage: con.dateError.value,
                          suffixIconSize: 20.w,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          suffixIcon: con.endDateCon.value.text.isNotEmpty
                              ? SvgPicture.asset(
                                  AppAssets.crossIcon,
                                  height: 20,
                                )
                              : null,
                          suffixOnTap: con.endDateCon.value.text.isNotEmpty
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  con.endDateCon.value.clear();
                                  con.endDateValidation.value = true;
                                }
                              : null,
                          onDateOrTimeChange: (value) {
                            if (value.runtimeType == DateTime) {
                              con.endDateCon.value.text = UiUtils.convertDateToDotSeparate(value);
                              con.endDate.value = value;
                              con.endDateValidation.value = true;
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
                  onPressed: () {
                    con.startDateCon.value.clear();
                    con.endDateCon.value.clear();
                    con.retailerCon.value.clear();
                    con.retailerId = "";
                    con.startDateValidation.value = true;
                    con.endDateValidation.value = true;
                    con.dateError.value = "";
                  },
                ),
              ),
              defaultPadding.horizontalSpace,
              Expanded(
                child: AppButton(
                  height: 30.h,
                  title: "Apply",
                  onPressed: () {
                    if (con.validateDates()) {
                      OrdersRepository.getAllOrdersAPI(
                        endDate: con.endDateCon.value.text.isNotEmpty ? con.endDate.value : null,
                        startDate: con.startDateCon.value.text.isNotEmpty ? con.startDate.value : null,
                        retailerId: con.retailerId,
                        loader: ordersController.isLoading,
                      ).then(
                        (value) {
                          int filterCount = con.countAppliedFilters();
                          Get.back(result: filterCount);
                        },
                      );
                    }
                  },
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
