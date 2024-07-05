import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../data/repositories/cart/cart_repository.dart';
import '../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../exports.dart';
import '../../../res/app_bar.dart';
import '../../../res/app_dialog.dart';
import '../../../widgets/pull_to_refresh_indicator.dart';
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
              child: PreferredSize(
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
                        commonDebounce(
                          callback: () async {
                            return WatchlistRepository.getWatchlistAPI(searchText: con.searchCon.value.text.trim());
                          },
                        );

                        con.showCloseButton.value = true;
                      } else {
                        con.showCloseButton.value = false;
                      }
                    },
                  ),
                ),
              )),
          body: PullToRefreshIndicator(
            onRefresh: () => WatchlistRepository.getWatchlistAPI(isPullToRefresh: true),
            child: con.watchList.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.all(defaultPadding).copyWith(top: 10.h),
                    // physics: const RangeMaintainingScrollPhysics(),
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
                              arguments: {
                                "watchlistName": con.watchList[index].name,
                                "watchlistId": con.watchList[index].id?.value ?? "",
                                "type": ProductsListType.watchlist,
                              },
                            );
                          },
                          child: WatchlistTile(
                            name: con.watchList[index].name,
                            noOfItem: con.watchList[index].watchListItemCount ?? 0,
                            createdBy: "${LocalStorage.userModel.firstName ?? ""} ${LocalStorage.userModel.lastName ?? ""}",
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
                            cartOnPressed: () async {
                              /// ADD WATCHLIST TO CART
                              await CartRepository.addWatchlistToCartAPI(watchlistId: con.watchList[index].id?.value ?? "");
                            },
                            shareOnPressed: () async {
                              /// share wishlist
                              await Share.share(
                                "Name : ${con.watchList[index].name}\nNo of Items : ${con.watchList[index].watchListItemCount ?? 0}\nCreated By : ${LocalStorage.userModel.firstName}",
                              );
                            },
                            deleteOnPressed: () {
                              AppDialogs.cartDialog(
                                context,
                                buttonTitle: "NO",
                                contentText: "Are you sure?\nYou want to remove this watchlist?",
                                onPressed: () async {
                                  /// DELETE WATCHLIST API
                                  await WatchlistRepository.deleteWatchlistAPI(watchlistId: con.watchList[index].id?.value ?? "");
                                },
                              );
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
          ));
    });
  }
}
