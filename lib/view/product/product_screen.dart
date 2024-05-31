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
            preferredSize: Size.fromHeight(25.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  SortAndFilterButton(
                    title: "Sort",
                    image: AppAssets.sortIcon,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          width: Get.width,
                          padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                            border: Border.all(color: Theme.of(context).iconTheme.color!.withAlpha(15)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                padding: EdgeInsets.only(bottom: defaultPadding),
                                separatorBuilder: (context, index) => const Divider(height: 0),
                                shrinkWrap: true,
                                itemCount: con.sortOptions.length,
                                itemBuilder: (context, index) => CheckBoxWithTitleTile(
                                  isCheck: con.sortOptions[index]["isChecked"],
                                  title: con.sortOptions[index]["title"],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      flexibleHeight: true,
                                      buttonType: ButtonType.outline,
                                      borderColor: Theme.of(context).primaryColor,
                                      title: "Clear All",
                                      titleStyle: AppTextStyle.appButtonStyle(context).copyWith(color: Theme.of(context).primaryColor),
                                      onPressed: () {
                                        for (var checkOption in con.sortOptions) {
                                          checkOption["isChecked"].value = false;
                                        }
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
                              )
                            ],
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
                        productName: "PLKMR7423746",
                        productPrice: con.productList[index]["price"],
                      )
                    : CategoryTile(
                        categoryName: "PLKMR7423746",
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
