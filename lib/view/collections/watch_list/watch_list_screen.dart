import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/view/collections/watch_list/components/watchlist_tile.dart';
import 'package:pingaksh_mobile/view/collections/watch_list/watch_list_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../res/empty_element.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({super.key});

  final WatchListController con = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: "Watchlist",
          bottom: con.watchList.isNotEmpty
              ? PreferredSize(
                  preferredSize: Size.fromHeight(40.h),
                  child: AppTextField(
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(defaultPadding / 1.2),
                    fillColor: AppColors.background,
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    textFieldType: TextFieldType.search,
                    textInputAction: TextInputAction.search,
                    controller: con.searchCon.value,
                    validation: con.searchValidation.value,
                    errorMessage: con.searchError.value,
                  ),
                )
              : null,
        ),
        body: con.watchList.isNotEmpty
            ? ListView(
                padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
                physics: const RangeMaintainingScrollPhysics(),
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: con.watchList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: defaultPadding,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productScreen,
                          arguments: {"categoryName": con.watchList[index]['name']},
                        );
                      },
                      child: WatchlistTile(
                        name: con.watchList[index]['name'],
                        noOfItem: con.watchList[index]['no_of_item'],
                        createdBy: con.watchList[index]['created_by'],
                        downloadOnPressed: () {},
                        shareOnPressed: () async {
                          /// share wishlist
                          await Share.share(
                            "Name : ${con.watchList[index]['name']}\nNo of Items : ${con.watchList[index]['no_of_item']}\nCreated By : ${con.watchList[index]['created_by']}",
                          );
                        },
                        deleteOnPressed: () {
                          int selectIndex = con.watchList.indexWhere(
                            (e) => e['id'] == con.watchList[index]['id'],
                          );
                          if (selectIndex != -1) {
                            con.watchList.removeAt(selectIndex);
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
            : EmptyElement(
                title: "Watchlist is empty",
                imagePath: AppAssets.emptyData,
              ),
      );
    });
  }
}
