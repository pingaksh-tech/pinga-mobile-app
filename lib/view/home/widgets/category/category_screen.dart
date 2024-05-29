import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/view/home/widgets/category/category_controller.dart';

import '../../components/category_tile.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController con = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor,
          title: "Rang Tarang",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              AppTextField(
                hintText: "Search",
                fillColor: AppColors.lightGrey.withOpacity(0.3),
                padding: EdgeInsets.only(bottom: defaultPadding / 1.5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultRadius),
                  ),
                  borderSide: BorderSide.none,
                ),
                textFieldType: TextFieldType.search,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lightGrey,
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius - 3),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: defaultPadding / 3, horizontal: defaultPadding / 3),
                  labelColor: Theme.of(context).scaffoldBackgroundColor,
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                  unselectedLabelColor: Colors.black.withOpacity(0.4),
                  unselectedLabelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                  automaticIndicatorColorAdjustment: true,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorWeight: double.minPositive,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius - 4),
                    color: Theme.of(context).primaryColor,
                  ),
                  labelPadding: EdgeInsets.all(defaultPadding / 1.5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: List.generate(
                    con.tabList.length,
                    (index) => Text(
                      con.tabList[index],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.only(top: defaultPadding / 1.5, bottom: defaultPadding * 2),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CategoryTile(
                        categoryName: con.categoryList[index]["catName"],
                        subTitle: con.categoryList[index]["subTitle"],
                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReyjIyudrWYKWlI5MNBSLHfg1OGjAgbP2xAA&s",
                        onTap: () => Get.toNamed(AppRoutes.productScreen),
                      ),
                      itemCount: con.categoryList.length,
                      separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: defaultPadding / 1.5, bottom: defaultPadding * 2),
                      itemBuilder: (context, index) => CategoryTile(
                        categoryName: con.categoryList[index]["catName"],
                        subTitle: con.categoryList[index]["subTitle"],
                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReyjIyudrWYKWlI5MNBSLHfg1OGjAgbP2xAA&s",
                        onTap: () => Get.toNamed(AppRoutes.productScreen),
                      ),
                      itemCount: con.categoryList.length,
                      separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
