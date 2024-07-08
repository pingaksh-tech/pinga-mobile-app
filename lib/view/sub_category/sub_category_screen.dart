import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../data/repositories/sub_category/sub_category_repository.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/tab_bar.dart';
import '../products/components/cart_icon_button.dart';
import 'Widgets/latest_products_tab/latest_products_tab_view.dart';
import 'Widgets/sub_categories_tab/sub_categories_tab_view.dart';
import 'sub_category_controller.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});

  final SubCategoryController con = Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          con.searchFocusNode.value.unfocus();
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: MyAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
              title: con.categoryName.value,
              actions:  [
                /* AppIconButton(
                  onPressed: () => Get.toNamed(AppRoutes.settingsScreen),
                  icon: SvgPicture.asset(
                    AppAssets.settingIcon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),*/
                CartIconButton()
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40.h),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.02), blurRadius: 4, spreadRadius: 3),
                        ],
                      ),
                      child: AppTextField(
                        hintText: "Search",
                        controller: con.searchTEC.value,
                        focusNode: con.searchFocusNode.value,
                        padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(defaultRadius),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        textInputAction: TextInputAction.search,
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.3, horizontal: defaultPadding),
                        onTap: () {
                          con.tabController.animateTo(0);
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
                                con.searchTEC.value.clear();

                                /// CLEAR SEARCH API
                                await SubCategoryRepository.getSubCategoriesAPI(loader: con.loaderSubCategory, searchText: con.getSearchText);
                              }
                            : null,
                        onChanged: (value) {
                          if (con.searchTEC.value.text.isNotEmpty) {
                            con.showCloseButton.value = true;
                          } else {
                            con.showCloseButton.value = false;
                          }

                          /// DEBOUNCE
                          if (con.searchDebounce?.isActive ?? false) con.searchDebounce?.cancel();
                          con.searchDebounce = Timer(
                            defaultSearchDebounceDuration,
                            () async {
                              /// Search API
                              await SubCategoryRepository.getSubCategoriesAPI(loader: con.loaderSubCategory, searchText: con.getSearchText);
                            },
                          );
                        },
                      ),
                    ),
                    (defaultPadding / 2).verticalSpace,
                  ],
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  (defaultPadding / 2).verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.textFiledBorder,
                      ),
                      borderRadius: BorderRadius.circular(defaultRadius - 3),
                    ),
                    child: MyTabBar(
                      controller: con.tabController,
                      tabs: [
                        const Text(
                          "Category",
                        ),
                        Text(
                          "Latest Product${isValZero(con.latestProductList.length) ? '' : ' (${con.latestProductList.length})'}",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: con.tabController,
                      children: [
                        /// SUB CATEGORIES
                        SubCategoriesTabView(),

                        /// LATEST PRODUCTS
                        LatestProductsTabView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
