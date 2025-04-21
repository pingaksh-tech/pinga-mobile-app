import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/repositories/cart/cart_repository.dart';
import '../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../exports.dart';
import '../../../res/app_bar.dart';
import '../../../res/app_dialog.dart';
import '../../../res/empty_element.dart';
import '../../../widgets/pull_to_refresh_indicator.dart';
import 'components/watchlist_tile.dart';
import 'watch_list_controller.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({super.key});

  final WatchListController con = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
                        ? () async {
                            FocusScope.of(context).unfocus();
                            con.showCloseButton.value = false;
                            con.searchCon.value.clear();
                            await WatchListRepository.getWatchListAPI(searchText: con.searchCon.value.text.trim(), loader: con.loader);
                          }
                        : null,
                    onChanged: (_) {
                      if (con.searchCon.value.text.isNotEmpty) {
                        commonDebounce(
                          callback: () async {
                            return WatchListRepository.getWatchListAPI(searchText: con.searchCon.value.text.trim(), loader: con.loader);
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
              onRefresh: () => WatchListRepository.getWatchListAPI(isPullToRefresh: true),
              child: ListView(
                controller: con.scrollController,
                padding: EdgeInsets.all(defaultPadding).copyWith(top: 10.h),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  con.loader.isFalse
                      ? con.watchList.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: con.watchList.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: defaultPadding,
                              ),
                              itemBuilder: (context, index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.productScreen,
                                        arguments: {
                                          "watchlistName": con.watchList[index].name,
                                          "watchlistId": con.watchList[index].id?.value ?? "",
                                          "type": ProductsListType.watchlist,
                                          // "categoryId": con.watchList[index].?.value
                                          // 'catagory' :  con.watchList[index].?.value,
                                        },
                                      );
                                    },
                                    child: WatchlistTile(
                                      name: con.watchList[index].name,
                                      noOfItem: con.watchList[index].watchListItemCount ?? 0,
                                      createdBy: "${LocalStorage.userModel.firstName ?? ""} ${LocalStorage.userModel.lastName ?? ""}",
                                      downloadOnPressed: () async {
                                        WatchListRepository.resetDownloadRequest();

                                        Get.toNamed(
                                          AppRoutes.pdfPreviewScreen,
                                          arguments: {
                                            "title": con.watchList[index].name,
                                            "isFromCatalog":false,
                                            "catalogueId": con.watchList[index].id?.value ?? "",
                                          },
                                        );
                                        /*   Get.toNamed(
                                          AppRoutes.watchpdfViewerScreen,
                                          arguments: {
                                            "title": con.watchList[index].name,
                                            "watchId": con.watchList[index].id
                                                    ?.value ??
                                                "",
                                          },
                                        ); */
                                      },
                                      cartOnPressed: () async {
                                        /// ADD WATCHLIST TO CART
                                        await CartRepository.addWatchlistToCartAPI(watchlistId: con.watchList[index].id?.value ?? "");
                                      },
                                      deleteOnPressed: () {
                                        AppDialogs.cartDialog(
                                          context,
                                          buttonTitle: "NO",
                                          contentText: "Are you sure?\nYou want to remove this watchlist?",
                                          onPressed: () async {
                                            /// DELETE WATCHLIST API
                                            await WatchListRepository.deleteWatchlistAPI(watchlistId: con.watchList[index].id?.value ?? "");
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: (con.paginationLoader.value && index + 1 == con.watchList.length),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 100),
                                      child: watchListShimmer(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : EmptyElement(
                              title: "Watchlist is empty",
                              imagePath: AppAssets.emptyData,
                              padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                            )
                      : ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => watchListShimmer(),
                          itemCount: 10,
                        ),
                ],
              )),
        );
      },
    );
  }

  Widget watchListShimmer() {
    return ShimmerUtils.shimmer(
      child: ShimmerUtils.shimmerContainer(
        borderRadiusSize: defaultRadius,
        height: Get.height * 0.16,
      ),
    );
  }
}
