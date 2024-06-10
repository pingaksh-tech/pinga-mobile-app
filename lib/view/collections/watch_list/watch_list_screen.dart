import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../exports.dart';
import '../../../res/app_bar.dart';
import 'components/watchlist_tile.dart';
import 'watch_list_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../res/empty_element.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({super.key});

  final WatchListController con = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          showBackIcon: false,
          child: con.watchList.isNotEmpty
              ? PreferredSize(
                  preferredSize: Size.fromHeight(40.h),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: defaultShadow(context)),
                    child: AppTextField(
                      hintText: "Search",
                      contentPadding: EdgeInsets.all(defaultPadding / 1.2),
                      fillColor: AppColors.background,
                      textInputAction: TextInputAction.search,
                      controller: con.searchCon.value,
                      validation: con.searchValidation.value,
                      errorMessage: con.searchError.value,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(defaultRadius),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding / 1.4),
                        child: SvgPicture.asset(
                          AppAssets.search,
                          height: 22,
                          width: 22,
                          color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                        ),
                      ),
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
                      onChanged: (_) {
                        if (con.searchCon.value.text.isNotEmpty) {
                          con.showCloseButton.value = true;
                        } else {
                          con.showCloseButton.value = false;
                        }
                      },
                    ),
                  ),
                )
              : null,
        ),
        body: con.watchList.isNotEmpty
            ? ListView(
                padding: EdgeInsets.all(defaultPadding).copyWith(top: 10.h),
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
                          arguments: {"watchlistName": con.watchList[index].name},
                        );
                      },
                      child: WatchlistTile(
                        name: con.watchList[index].name,
                        noOfItem: con.watchList[index].noOfItem,
                        createdBy: con.watchList[index].createdBy,
                        downloadOnPressed: () async {
                          // Convert into CSV
                          /*     con.rows.add(con.row);
                          List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(con.rows.toString());

                          String csv = const ListToCsvConverter().convert(rowsAsListOfValues);
                          printYellow(csv);
                          String dir = (await getTemporaryDirectory()).path ?? '';
                          String filePath = "$dir/list.csv";

                          File file = File(filePath);
                          await file.writeAsString(csv);

                          printOkStatus(filePath);

                          final result = await Share.shareXFiles([XFile(filePath)], text: '');
                          if (result.status == ShareResultStatus.success) {
                            printOkStatus('Thank you for sharing!');
                          }*/
                        },
                        cartOnPressed: () {
                          UiUtils.toast("Added Successfully");
                        },
                        shareOnPressed: () async {
                          /// share wishlist
                          await Share.share(
                            "Name : ${con.watchList[index].name}\nNo of Items : ${con.watchList[index].noOfItem}\nCreated By : ${con.watchList[index].createdBy}",
                          );
                        },
                        deleteOnPressed: () {
                          int selectIndex = con.watchList.indexWhere(
                            (e) => e.id == con.watchList[index].id,
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
            : const EmptyElement(
                title: "Watchlist is empty",
                imagePath: AppAssets.emptyData,
              ),
      );
    });
  }
}
