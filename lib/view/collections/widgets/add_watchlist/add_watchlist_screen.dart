import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/model/watchlist/watchlist_model.dart';
import '../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/pull_to_refresh_indicator.dart';
import '../../watch_list/components/watchlist_tile.dart';
import '../../watch_list/watch_list_controller.dart';
import 'add_watchlist_controller.dart';

class AddWatchListScreen extends StatelessWidget {
  AddWatchListScreen({super.key});

  final AddWatchListController con = Get.put(AddWatchListController());
  final WatchListController watchlistCon = Get.find<WatchListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: "Add to watch"),
      body: Obx(
        () {
          return PullToRefreshIndicator(
            onRefresh: () => WatchListRepository.getWatchListAPI(isPullToRefresh: true),
            child: ListView(
              padding: EdgeInsets.all(defaultPadding),
              children: [
                con.loader.isFalse
                    ? watchlistCon.watchList.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 136.h),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: watchlistCon.watchList.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: defaultPadding / 1.5,
                            ),
                            itemBuilder: (context, index) => Obx(() {
                              return WatchlistTile(
                                name: watchlistCon.watchList[index].name,
                                noOfItem: watchlistCon.watchList[index].watchListItemCount ?? 0,
                                createdBy: LocalStorage.userModel.firstName,
                                isShowButtons: false,
                                selected: (con.watchlistId.value.id?.value == watchlistCon.watchList[index].id?.value).obs,
                                onPressed: () {
                                  if (con.watchlistId.value.id?.value == watchlistCon.watchList[index].id?.value) {
                                    con.watchlistId.value = WatchList();
                                  } else {
                                    con.watchlistId.value = watchlistCon.watchList[index];
                                  }

                                  con.checkDisableButton();
                                },
                                onChanged: (_) {
                                  if (con.watchlistId.value.id == watchlistCon.watchList[index].id) {
                                    con.watchlistId.value = WatchList();
                                  } else {
                                    con.watchlistId.value = watchlistCon.watchList[index];
                                  }

                                  con.checkDisableButton();
                                },
                              );
                            }),
                          )
                        : Center(
                            child: EmptyElement(
                              title: "Watchlist not available",
                              padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                            ),
                          )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: 10,
                        separatorBuilder: (context, index) => SizedBox(
                          height: defaultPadding / 1.5,
                        ),
                        itemBuilder: (context, index) => ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(
                            borderRadiusSize: defaultRadius,
                            height: Get.height * 0.11,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Obx(() {
        return Container(
          decoration: BoxDecoration(
            boxShadow: defaultShadowAllSide,
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultRadius * 2),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AppTextField(
                title: "Add Watch list",
                hintText: "Enter watchlist name",
                contentPadding: EdgeInsets.all(defaultPadding / 1.2),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
                textInputAction: TextInputAction.done,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultRadius),
                  ),
                  borderSide: BorderSide.none,
                ),
                controller: con.nameCon.value,
                validation: con.nameValidation.value,
                errorMessage: con.nameError.value,
                onChanged: (value) {
                  con.checkDisableButton();
                },
              ),
              AppButton(
                title: "Add",
                disableButton: con.disableButton.value,
                padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (con.nameCon.value.text.trim().isNotEmpty || (con.watchlistId.value.id != null && con.watchlistId.value.id!.isNotEmpty)) {
                    // con.watchList.add(
                    //   WatchlistModel(id: con.watchList.length.toString(), name: con.nameCon.value.text.trim(), noOfItem: 45, createdBy: "Guest"),
                    // );
                    /// CREATE WATCHLIST
                    WatchListRepository.createWatchlistAPI(
                      productListType: ProductsListType.normal,
                      watchlistName: (con.watchlistId.value.id != null && con.watchlistId.value.id!.isNotEmpty) ? con.watchlistId.value.name ?? "" : con.nameCon.value.text.trim(),
                      inventoryId: con.inventoryId.value,
                      sizeId: con.sizeId.value,
                      metalId: con.metalId.value,
                      quantity: con.quantity.value,
                      diamondClarity: con.diamondClarity.value,
                      diamonds: List.generate(
                        con.diamonds.length,
                        (index) => {
                          "diamond_clarity": con.diamonds[index].diamondClarity?.value ?? "",
                          "diamond_shape": con.diamonds[index].diamondShape ?? "",
                          "diamond_size": con.diamonds[index].diamondSize ?? "",
                          "diamond_count": con.diamonds[index].diamondCount ?? 0,
                          "_id": con.diamonds[index].id ?? "",
                        },
                      ),
                    );
                    con.nameCon.value.clear();
                    Get.back();
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
