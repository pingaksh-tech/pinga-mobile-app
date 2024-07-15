import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../exports.dart';
import '../../../../widgets/checkbox_title_tile.dart';
import '../../products_controller.dart';

class SortingBottomSheet extends StatelessWidget {
  final ProductsListType productsListType;
  final String watchlistId;

  SortingBottomSheet({super.key, required this.productsListType, required this.watchlistId});

  final ProductsController con = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
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
              padding: EdgeInsets.only(top: defaultPadding / 2),
              itemCount: con.sortWithPriceList.length,
              itemBuilder: (context, index) => Obx(
                () => CheckBoxWithTitleTile(
                  isCheck: (con.selectPrice.value == con.sortWithPriceList[index]).obs,
                  title: con.sortWithPriceList[index].toString().split("/").first,
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
                  title: con.sortWithTimeList[index].split("/").first,
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
            ).paddingOnly(bottom: defaultPadding / 3),

            //? Most order sorting
            // const Divider(height: 0),
            /*   CheckBoxWithTitleTile(
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
            ).paddingOnly(bottom: defaultPadding / 3), */
            Wrap(
              runSpacing: defaultPadding / 2,
              spacing: defaultPadding / 2,
              children: List.generate(
                con.sortList.length,
                (index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 3.5).copyWith(right: defaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius - 2),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        con.sortList[index].toString().split("/").first,
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
                      height: 30.h,
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
                        disableButton: (con.selectPrice.value.isEmpty && con.selectNewestOrOldest.value.isEmpty /*  && con.isMostOrder.isFalse */),
                        loader: con.isLoader.value,
                        height: 30.h,
                        title: "Apply",
                        onPressed: () async {
                          if (con.sortList.isNotEmpty) {
                            await ProductRepository.getFilterProductsListAPI(
                              watchListId: watchlistId,
                              productsListType: con.productListType.value,
                              categoryId: con.categoryId.value,
                              subCategoryId: con.subCategory.value.id ?? "",
                              loader: con.loader,
                              sortBy: [
                                if (con.selectPrice.value.isNotEmpty) "inventory_total_price:${con.selectPrice.value.split("/").last}",
                                if (!isValEmpty(con.selectNewestOrOldest.value)) "createdAt:${con.selectNewestOrOldest.value.split("/").last}",
                              ],
                            );

                            Get.back();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
