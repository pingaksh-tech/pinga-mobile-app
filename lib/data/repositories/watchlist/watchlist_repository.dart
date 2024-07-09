import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/collections/watch_list/watch_list_controller.dart';
import '../../../view/drawer/widgets/wishlist/wishlist_controller.dart';
import '../../model/watchlist/single_watchlist_model.dart';
import '../../model/watchlist/watchlist_model.dart';

class WatchListRepository {
  /// ***********************************************************************************
  ///                                     CREATE WATCHLIST API
  /// ***********************************************************************************

  static Future<void> createWatchlistAPI({
    required ProductsListType productListType,
    required String inventoryId,
    required String watchlistName,
    required int quantity,
    required String metalId,
    required String sizeId,
    required String diamondClarity,
    String? remark,
    List<Map<String, dynamic>>? diamonds,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createAndGetWatchlistAPI,
          body: {
            "name": watchlistName,
            "inventory_id": inventoryId,
            "quantity": quantity,
            "metal_id": metalId,
            if (!isValEmpty(sizeId)) "size_id": sizeId,
            if (!isValEmpty(diamondClarity)) "diamond_clarity": diamondClarity,
            if (!isValEmpty(diamonds)) "diamonds": diamonds,
            if (!isValEmpty(remark)) "remark": remark,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              if (response['data'] != null) {
                if (productListType == ProductsListType.wishlist) {
                  if (isRegistered<WishlistController>()) {
                    final WishlistController wishlistCon = Get.find<WishlistController>();

                    int index = wishlistCon.productsList.indexWhere((element) => element.inventoryId == inventoryId);
                    if (index != -1) {
                      wishlistCon.productsList.removeAt(index);
                    }
                  }
                }
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     GET WATCHLIST API
  /// ***********************************************************************************

  static Future<void> getWatchListAPI({
    String? searchText,
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    final WatchListController con = Get.find<WatchListController>();

    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.watchList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createAndGetWatchlistAPI,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
            "search": searchText,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetWatchListModel model = GetWatchListModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.watchList.value = model.data?.watchLists ?? [];
                } else {
                  con.watchList.addAll(model.data?.watchLists ?? []);
                }

                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                con.page.value += currentPage;
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     DELETE WATCHLIST API
  /// ***********************************************************************************

  static Future<void> deleteWatchlistAPI({
    required String watchlistId,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.deleteApiCall(
          apiUrl: ApiUrls.getAndDeleteSingleWatchListAPI(watchlistId: watchlistId),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSingleWatchlistModel model = GetSingleWatchlistModel.fromJson(response);

              if (model.data != null) {
                if (isRegistered<WatchListController>()) {
                  final WatchListController con = Get.find<WatchListController>();

                  int index = con.watchList.indexWhere((element) => element.id?.value == watchlistId);
                  if (index != -1) {
                    con.watchList.removeAt(index);
                  }
                }
                Get.back();
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "deleteWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                ADD CART TO WATCHLIST API
  /// ***********************************************************************************
  static Future<dynamic> addCartToWatchlistAPI({
    RxBool? isLoader,
    required String watchlistName,
    required List<String> cartIds,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.postApiCall(
          apiUrl: ApiUrls.cartToWatchlistPOST,
          body: {
            "name": watchlistName,
            "cartIds": cartIds,
          },
        ).then(
          (response) async {
            if (response != null) {
              /// Get WatchList api
              await getWatchListAPI();
            }
            isLoader?.value = false;
            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "addCartToWatchlistAPI", errText: e);
      }
    }
  }
}
