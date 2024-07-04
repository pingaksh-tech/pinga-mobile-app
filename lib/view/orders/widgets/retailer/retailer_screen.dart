import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/cart/cart_repository.dart';
import '../../../../exports.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/custom_radio_button.dart';

class RetailerDialog extends StatefulWidget {
  final RxString id;
  const RetailerDialog({super.key, required this.id});

  @override
  State<RetailerDialog> createState() => _RetailerDialogState();
}

class _RetailerDialogState extends State<RetailerDialog> {
  RxList<RetailerModel> retailerList = <RetailerModel>[].obs;
  Rx<RetailerModel> retailerModel = RetailerModel().obs;
  Rx<TextEditingController> retailerCon = TextEditingController().obs;
  TextEditingController controller = TextEditingController();
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  @override
  void initState() {
    super.initState();
    CartRepository.getRetailerApi(
      itemLimit: itemLimit,
      nextPageAvailable: nextPageAvailable,
      paginationLoader: paginationLoader,
      page: page,
      retailerList: retailerList,
      loader: isLoading,
    );
    manageScrollController();
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET Retailer API
            CartRepository.getRetailerApi(
              itemLimit: itemLimit,
              nextPageAvailable: nextPageAvailable,
              paginationLoader: paginationLoader,
              page: page,
              retailerList: retailerList,
              loader: paginationLoader,
              isInitial: false,
            );
          }
        }
      },
    );
  }

  // int index = retailerList.indexWhere((element) => element.id == retailerId.obs);
  //           if (index != -1) {
  //             con.retailerModel.value = con.retailerList[index];
  //           }
  // isValEmpty(con.retailerId.obs) ? con.retailerId.obs : RxString(con.retailerList[0].id?.value ?? ""),

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
                if (retailerList.isNotEmpty)
                  AppTextField(
                    controller: controller,
                    hintText: 'Search',
                    textInputAction: TextInputAction.search,
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                    onChanged: (value) {},
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding / 1.4),
                      child: SvgPicture.asset(
                        AppAssets.search,
                        height: 22,
                        width: 22,
                        color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                      ),
                    ),
                    suffixIcon: controller.text.trim().isNotEmpty
                        ? Center(
                            child: SvgPicture.asset(
                              AppAssets.crossIcon,
                              color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                            ),
                          )
                        : null,
                    suffixOnTap: () {
                      FocusScope.of(context).unfocus();
                      controller.clear();
                    },
                  ),
                (defaultPadding / 1.4).verticalSpace,

                /// Records
                Expanded(
                  child: isLoading.isFalse
                      ? retailerList.isNotEmpty
                          ? Column(
                              children: [
                                ListView.separated(
                                  physics: const RangeMaintainingScrollPhysics(),
                                  itemCount: retailerList.length,
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(
                                      retailerList[index].businessName ?? '',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                                    ),
                                    trailing: AppRadioButton(
                                      isSelected: (retailerList[index].id?.value == widget.id.value).obs,
                                    ),
                                    onTap: () {
                                      Get.back(result: retailerList[index]);
                                    },
                                  ),
                                  separatorBuilder: (context, index) => Divider(height: 1.h),
                                ),

                                /// PAGINATION LOADER
                                Visibility(
                                  visible: paginationLoader.isTrue,
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
