import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          title: con.brandTitle.value,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 1.5),
          child: Column(
            children: [
              AppTextField(
                hintText: "Search",
                controller: con.searchCon.value,
                padding: EdgeInsets.only(bottom: defaultPadding),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultRadius),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
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
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: defaultPadding * 2),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CategoryTile(
                    categoryName: con.categoryList[index]["catName"],
                    subTitle: con.categoryList[index]["subTitle"],
                    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReyjIyudrWYKWlI5MNBSLHfg1OGjAgbP2xAA&s",
                    onTap: () => Get.toNamed(
                      AppRoutes.productScreen,
                      arguments: {"categoryName": con.categoryList[index]["catName"]},
                    ),
                  ),
                  itemCount: con.categoryList.length,
                  separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
