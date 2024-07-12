import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/drawer/widgets/wishlist/wishlist_controller.dart';
import '../../../view/products/products_controller.dart';
import '../../model/wishlist/wishlist_model.dart';

class WishlistRepository {
  /// ***********************************************************************************
  ///                                     CREATE WISHLIST API
  /// ***********************************************************************************

  static Future<void> createWishlistAPI({
    required ProductsListType productListType,
    required String inventoryId,
    required bool isWishlist,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createAndGetWishlistAPI,
          body: {
            "inventory_id": inventoryId,
            "is_wishlist": isWishlist,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              if (isWishlist == false) {
                if (productListType == ProductsListType.wishlist) {
                  if (isRegistered<WishlistController>()) {
                    final WishlistController wishlistCon = Get.find<WishlistController>();

                    int index = wishlistCon.productsList.indexWhere((element) => element.inventoryId == inventoryId);
                    if (index != -1) {
                      wishlistCon.productsList.removeAt(index);
                    }
                  }
                }
                if (Get.isRegistered<ProductsController>()) {
                  final ProductsController productsCon = Get.find<ProductsController>();
                  int index = productsCon.inventoryProductList.indexWhere((element) => element.id == inventoryId);
                  if (index != -1) {
                    productsCon.inventoryProductList[index].isWishlist?.value = false;
                  }
                }
              } else if (isWishlist == true) {
                if (Get.isRegistered<ProductsController>()) {
                  final ProductsController productsCon = Get.find<ProductsController>();
                  int index = productsCon.inventoryProductList.indexWhere((element) => element.id == inventoryId);
                  if (index != -1) {
                    productsCon.inventoryProductList[index].isWishlist?.value = true;
                  }
                }
              }

              UiUtils.toast(isWishlist == true ? "Product add successfully in wishlist" : "Product removed from wishlist successfully");
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createWishlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     GET WISHLIST API
  /// ***********************************************************************************

  static Future<void> getWishlistAPI({
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    final WishlistController con = Get.find<WishlistController>();

    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.productsList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createAndGetWishlistAPI,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetWishlistModel model = GetWishlistModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.productsList.value = model.data?.wishlists ?? [];
                } else {
                  con.productsList.addAll(model.data?.wishlists ?? []);
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
        printErrors(type: "getWishlistAPI", errText: e);
      }
    } else {}
  }
}
