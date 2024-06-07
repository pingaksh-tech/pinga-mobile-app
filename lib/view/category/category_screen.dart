import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_network_image.dart';
import '../../res/tab_bar.dart';
import '../products/components/cart_icon_button.dart';
import 'category_controller.dart';
import 'components/category_tile.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController con = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: MyAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
            title: con.brandTitle.value,
            actions: const [CartIconButton()],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40.h),
              child: Column(
                children: [
                  AppTextField(
                    hintText: "Search",
                    controller: con.searchCon.value,
                    padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    textFieldType: TextFieldType.search,
                    contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.3, horizontal: defaultPadding),
                    suffixIcon: con.showCloseButton.isTrue
                        ? Center(
                            child: SvgPicture.asset(
                              AppAssets.crossIcon,
                              color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                            ),
                          )
                        : null,
                    suffixOnTap: con.showCloseButton.isTrue
                        ? () {
                            FocusScope.of(context).unfocus();
                            con.showCloseButton.value = false;
                            con.searchCon.value.clear();
                          }
                        : null,
                    onChanged: (value) {
                      if (con.searchCon.value.text.isNotEmpty) {
                        con.showCloseButton.value = true;
                      } else {
                        con.showCloseButton.value = false;
                      }
                    },
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
                    tabs: [
                      const Text(
                        "Category",
                      ),
                      Text(
                        "Latest Product (${con.latestProductList.length})",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.all(defaultPadding),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CategoryTile(
                          categoryName: con.categoryList[index].catName ?? "",
                          subTitle: con.categoryList[index].productAvailable ?? "",
                          imageUrl: con.categoryList[index].image ?? "",
                          onTap: () => Get.toNamed(
                            AppRoutes.productScreen,
                            arguments: {
                              "category": con.categoryList[index],
                            },
                          ),
                        ),
                        itemCount: con.categoryList.length,
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(defaultPadding),
                        itemBuilder: (context, index) => AppNetworkImage(
                          height: Get.height / 8,
                          width: double.infinity,
                          imageUrl: con.latestProductList[index],
                          fit: BoxFit.cover,
                          boxShadow: defaultShadowAllSide,
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        itemCount: con.latestProductList.length,
                        separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
