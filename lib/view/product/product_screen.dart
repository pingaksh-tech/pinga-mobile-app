import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/view/category/components/category_tile.dart';
import 'package:pingaksh_mobile/view/product/components/sort_filter_button.dart';
import 'package:pingaksh_mobile/widgets/checkbox_title_tile.dart';
import 'package:pingaksh_mobile/widgets/product_tile.dart';

import '../../res/app_bar.dart';
import 'product_controller.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController con = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          title: con.categoryName.value,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  SortAndFilterButton(
                    title: "Sort",
                    isFilterButton: false,
                    image: AppAssets.sortIcon,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Obx(
                          () => Container(
                            width: Get.width,
                            padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                              border: Border.all(color: Theme.of(context).iconTheme.color!.withAlpha(15)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Sort by",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.titleStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ),
                                    AppIconButton(
                                      splashColor: Theme.of(context).scaffoldBackgroundColor,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      icon: SvgPicture.asset(AppAssets.crossIcon),
                                    ),
                                  ],
                                ),
                                ListView.separated(
                                  separatorBuilder: (context, index) => const Divider(height: 0),
                                  shrinkWrap: true,
                                  itemCount: con.sortWithPriceList.length,
                                  itemBuilder: (context, index) => Obx(
                                    () => CheckBoxWithTitleTile(
                                      isCheck: (con.selectPrice.value == con.sortWithPriceList[index]).obs,
                                      title: con.sortWithPriceList[index],
                                      isMultiSelection: false,
                                      onTap: () {
                                        con.selectPrice.value = con.sortWithPriceList[index];
                                        con.updateSortingList();
                                      },
                                      onChanged: (value) {
                                        con.selectPrice.value = con.sortWithPriceList[index];
                                        con.updateSortingList();
                                      },
                                    ),
                                  ),
                                ),
                                const Divider(height: 0),
                                ListView.separated(
                                  separatorBuilder: (context, index) => const Divider(height: 0),
                                  shrinkWrap: true,
                                  itemCount: con.sortWithTimeList.length,
                                  itemBuilder: (context, index) => Obx(
                                    () => CheckBoxWithTitleTile(
                                      isCheck: (con.selectNewestOrOldest.value == con.sortWithTimeList[index]).obs,
                                      title: con.sortWithTimeList[index],
                                      isMultiSelection: false,
                                      onTap: () {
                                        con.selectNewestOrOldest.value = con.sortWithTimeList[index];
                                        con.updateSortingList();
                                      },
                                      onChanged: (value) {
                                        con.selectNewestOrOldest.value = con.sortWithTimeList[index];
                                        con.updateSortingList();
                                      },
                                    ),
                                  ),
                                ),
                                const Divider(height: 0),
                                CheckBoxWithTitleTile(
                                  title: "Most Ordered",
                                  isCheck: con.isMostOrder,
                                  isMultiSelection: false,
                                  onTap: () {
                                    con.isMostOrder.value = !con.isMostOrder.value;
                                    con.updateSortingList();
                                  },
                                  onChanged: (value) {
                                    con.isMostOrder.value = !con.isMostOrder.value;
                                    con.updateSortingList();
                                  },
                                ).paddingOnly(bottom: defaultPadding / 3),
                                Wrap(
                                  runSpacing: defaultPadding / 2,
                                  spacing: defaultPadding / 2,
                                  children: List.generate(
                                    con.sortList.length,
                                    (index) => Container(
                                      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.5, vertical: defaultPadding / 3.5).copyWith(right: defaultPadding / 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            con.sortList[index],
                                            style: AppTextStyle.subtitleStyle(context).copyWith(
                                              color: Theme.of(context).colorScheme.surface,
                                              fontSize: 12.sp,
                                            ),
                                          ).paddingOnly(right: 3.w),
                                          AppIconButton(
                                            size: 15.h,
                                            onPressed: () {
                                              String removedSorting = con.sortList[index];
                                              con.sortList.remove(con.sortList[index]);
                                              if (con.sortWithTimeList.contains(removedSorting)) {
                                                con.selectNewestOrOldest.value = '';
                                              } else if (con.sortWithPriceList.contains(removedSorting)) {
                                                con.selectPrice.value = '';
                                              } else if (removedSorting == 'Most Ordered') {
                                                con.isMostOrder.value = false;
                                              }
                                            },
                                            icon: SvgPicture.asset(
                                              AppAssets.crossIcon,
                                              color: Theme.of(context).colorScheme.surface, // ignore: deprecated_member_use
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: defaultPadding),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppButton(
                                          flexibleHeight: true,
                                          buttonType: ButtonType.outline,
                                          borderColor: Theme.of(context).primaryColor,
                                          title: "Clear All",
                                          titleStyle: AppTextStyle.appButtonStyle(context).copyWith(color: Theme.of(context).primaryColor),
                                          onPressed: () {
                                            con.sortList.clear();
                                            con.selectNewestOrOldest.value = '';
                                            con.selectPrice.value = '';
                                            con.isMostOrder.value = false;
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      defaultPadding.horizontalSpace,
                                      Expanded(
                                        child: AppButton(
                                          flexibleHeight: true,
                                          title: "Apply",
                                          onPressed: () => Get.back(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  SortAndFilterButton(
                    title: "Filter",
                    image: AppAssets.filter,
                    onTap: () => Get.toNamed(AppRoutes.filterScreen),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  AppIconButton(
                    icon: SvgPicture.asset(
                      con.isProductViewChange.isTrue ? AppAssets.appIcon : AppAssets.appListIcon,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
                      height: 18.sp,
                    ),
                    onPressed: () {
                      con.isProductViewChange.value = !con.isProductViewChange.value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding).copyWith(top: 0),
          children: [
            Divider(
              height: 2.h,
              thickness: 1.5,
              indent: defaultPadding / 2,
              endIndent: defaultPadding / 2,
            ),
            Wrap(
              children: List.generate(
                con.productList.length,
                (index) => con.isProductViewChange.isTrue
                    ? ProductTile(
                        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen),
                        imageUrl: con.productList[index]["image"],
                        productName: con.productList[index]["productName"],
                        productPrice: con.productList[index]["price"],
                      )
                    : CategoryTile(
                        categoryName: con.productList[index]["productName"],
                        subTitle: UiUtils.amountFormat(con.productList[index]["price"]),
                        imageUrl: con.productList[index]["image"],
                        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen),
                        fontSize: 14.sp,
                      ).paddingOnly(left: defaultPadding / 2, right: defaultPadding / 2, top: defaultPadding / 1.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
