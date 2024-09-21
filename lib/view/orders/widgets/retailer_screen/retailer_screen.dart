import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/orders/orders_repository.dart';
import '../../../../exports.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/custom_radio_button.dart';
import 'retailer_controller.dart';

class RetailerScreen extends StatelessWidget {
  RetailerScreen({super.key});
  final RetailerController con = Get.put(RetailerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.only(top: defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius / 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Retailer",
                        style: AppTextStyle.titleStyle(context).copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      AppIconButton(
                        size: 26.h,
                        icon: SvgPicture.asset(AppAssets.crossIcon),
                        onPressed: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
                defaultPadding.verticalSpace,
                AppTextField(
                  controller: con.searchCon.value,
                  hintText: 'Search',
                  textInputAction: TextInputAction.search,
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding / 1.4),
                    child: SvgPicture.asset(
                      AppAssets.search,
                      height: 22,
                      width: 22,
                      color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                    ),
                  ),
                  onChanged: (value) {
                    if (con.searchCon.value.text.isNotEmpty) {
                      /// DEBOUNCE
                      commonDebounce(
                        callback: () async {
                          return OrdersRepository.getRetailerApi(searchText: con.searchCon.value.text.trim(), loader: con.isLoading);
                        },
                      );
                      con.showCloseButton.value = true;
                    } else {
                      con.showCloseButton.value = false;
                    }
                  },
                  suffixIcon: con.showCloseButton.isTrue
                      ? Center(
                          child: SvgPicture.asset(
                            AppAssets.crossIcon,
                            color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                          ),
                        )
                      : null,
                  suffixOnTap: con.showCloseButton.isTrue
                      ? () async {
                          FocusScope.of(context).unfocus();
                          con.showCloseButton.value = false;
                          con.searchCon.value.clear();

                          /// CLEAR SEARCH API
                          OrdersRepository.getRetailerApi(searchText: con.searchCon.value.text.trim(), loader: con.isLoading);
                        }
                      : null,
                ),
                (defaultPadding / 1.4).verticalSpace,

                /// Records
                Expanded(
                  child: con.isLoading.isFalse
                      ? con.retailerList.isNotEmpty
                          ? Column(
                              children: [
                                ListView.separated(
                                  physics: const RangeMaintainingScrollPhysics(),
                                  itemCount: con.retailerList.length,
                                  shrinkWrap: true,
                                  controller: con.scrollController,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(
                                      con.retailerList[index].businessName ?? '',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                                    ),
                                    trailing: AppRadioButton(
                                      isSelected: (con.retailerList[index].id?.value == con.retailerId.value).obs,
                                    ),
                                    onTap: () {
                                      Get.back(result: con.retailerList[index]);
                                    },
                                  ),
                                  separatorBuilder: (context, index) => Divider(height: 1.h),
                                ),

                                /// PAGINATION LOADER
                                Visibility(
                                  visible: con.paginationLoader.isTrue,
                                  child: retailerShimmer(),
                                ),
                              ],
                            )
                          : const Center(
                              child: EmptyElement(title: "Retailers not available"),
                            )
                      : ListView.separated(
                          padding: EdgeInsets.all(defaultPadding),
                          separatorBuilder: (context, index) => (defaultPadding).verticalSpace,
                          itemBuilder: (context, index) => retailerShimmer(),
                          itemCount: 20,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget retailerShimmer() {
    return Row(
      children: [
        ShimmerUtils.shimmer(
          child: ShimmerUtils.shimmerContainer(
            height: 15,
            width: Get.width * 0.4,
            borderRadiusSize: defaultRadius,
          ),
        ),
        const Spacer(),
        ShimmerUtils.shimmer(
          child: ShimmerUtils.shimmerContainer(
            height: 22,
            width: 22,
            borderRadiusSize: defaultRadius,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
      ],
    );
  }
}
