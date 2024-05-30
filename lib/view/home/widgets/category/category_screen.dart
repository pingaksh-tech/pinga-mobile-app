import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
        title: "Rang Tarang",
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
        child: Column(
          children: [
            AppTextField(
              hintText: "Search",
              fillColor: AppColors.lightGrey.withOpacity(0.3),
              controller: con.searchCon.value,
              padding: EdgeInsets.only(bottom: defaultPadding),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius),
                ),
                borderSide: BorderSide.none,
              ),
              textFieldType: TextFieldType.search,
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: defaultPadding * 2),
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
            ),
          ],
        ),
      ),
    );
  }
}
