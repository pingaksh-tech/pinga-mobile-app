import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../widgets/product_tile.dart';
import '../category/components/category_tile.dart';
import 'components/sort_filter_button.dart';
import 'product_controller.dart';
import 'widgets/sort/sorting_bottomsheet.dart';

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

          /// SORTING AND FILTERS
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
                    iconSize: 16.5.sp,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SortingBottomSheet(),
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
                      con.isProductViewChange.isFalse ? AppAssets.appIcon : AppAssets.listIcon,
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
            Text(
              "Total Products 4150",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subText),
              textAlign: TextAlign.center,
            ).paddingOnly(top: defaultPadding / 3),

            /// PRODUCTS
            Wrap(
              children: List.generate(
                con.productsList.length,
                (index) => con.isProductViewChange.isTrue
                    ? ProductTile(
                        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen),
                        imageUrl: con.productsList[index].product?.productImage ?? "",
                        productName: con.productsList[index].product?.title ?? "",
                        productPrice: con.productsList[index].product?.price.toString() ?? "",
                      )
                    : CategoryTile(
                        categoryName: con.productsList[index].product?.title ?? "",
                        subTitle: con.productsList[index].product?.price.toString() ?? "",
                        imageUrl: con.productsList[index].product?.productImage ?? "",
                        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen),
                        fontSize: 14.sp,
                      ).paddingOnly(
                        left: defaultPadding / 2,
                        right: defaultPadding / 2,
                        top: defaultPadding / 1.2,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
