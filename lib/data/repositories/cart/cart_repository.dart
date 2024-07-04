import 'package:get/get.dart';

import '../../../controller/predefine_value_controller.dart';
import '../../../exports.dart';
import '../../../view/cart/cart_controller.dart';
import '../../../view/cart/widget/stock/cart_stock_controller.dart';
import '../../../view/cart/widget/summary/summary_controller.dart';
import '../../model/cart/cart_model.dart';
import '../../model/cart/cart_summary_model.dart';
import '../../model/cart/product_detail_model.dart';
import '../../model/cart/retailer_model.dart';
import '../../model/cart/stock_model.dart';

class CartRepository {
  /// ***********************************************************************************
  ///                                       CART LIST
  /// ***********************************************************************************

  static Map<String, dynamic> stockList = {
    "success": true,
    "message": "Stock fetched successfully",
    "data": {
      "stocks": [
        {"id": "stock1", "value": "VVS-EF", "stock": "Diamond", "image": AppAssets.diamondIcon},
        {"id": "stock2", "value": "0.00 ct", "stock": "Diamond Wt", "image": AppAssets.diamondWeight},
        {"id": "stock3", "value": "2.86 gm", "stock": "Metal Wt", "image": AppAssets.metalWeight},
        {"id": "stock4", "value": "Yellow + White", "stock": "Color", "image": AppAssets.colorIcon},
        {"id": "stock4", "value": "16", "stock": "Size", "image": AppAssets.ringSizeIcon},
        {"id": "stock4", "value": "1", "stock": "Available quantity", "image": AppAssets.stockIcon}
      ]
    }
  };

  static Map<String, dynamic> productDetail = {
    "success": true,
    "message": "Product fetched successfully",
    "data": {
      "productDetail": [
        {"categoryName": "Metal", "value": "Gold"},
        {"categoryName": "Keratage", "value": "18KT"},
        {"categoryName": "Metal Wt", "value": "3.15"},
        {"categoryName": "Shape", "value": "Gold"},
        {"categoryName": "Stone", "value": "Diamond"},
        {"categoryName": "Stone quality", "value": "SI"},
        {"categoryName": "Stone Wt", "value": "0.30"}
      ]
    }
  };
  static Map<String, dynamic> summaryList = {
    "success": true,
    "message": "Product fetched successfully",
    "data": {
      "productDetail": [
        {
          "delivery": ["15 DAYS", "48 HOURS", "7 DAYS", "Immediate", "ORO - 15 Days"],
          "quantity": ["680", "480", "20", "1", ""],
        },
      ]
    }
  };

  /// ***********************************************************************************
  ///                                 GET CART API
  /// ***********************************************************************************

  static Future<dynamic> getCartApi({
    bool isInitial = true,
    RxBool? loader,
    bool background = false,
  }) async {
    ///
    if (await getConnectivityResult() && isRegistered<CartController>()) {
      final CartController con = Get.find<CartController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!background) {
            con.cartList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllCartGET,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetCartModel model = GetCartModel.fromJson(response);
              if (background) {
                con.cartList.clear();
              }

              if (model.data != null) {
                if (isInitial) {
                  con.cartList.value = model.data?.cartList ?? [];
                } else {
                  con.cartList.addAll(model.data?.cartList ?? []);
                }
                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                con.page.value += currentPage;
                con.cartDetail.value = model.data?.cartsDetails ?? CartsDetails();
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
        printErrors(type: "getCartList", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                 DELETE API
  /// ***********************************************************************************

  static Future<dynamic> deleteCartAPi({RxBool? isLoader, String? cartId, List<String>? selectedCartIds}) async {
    try {
      if (await getConnectivityResult()) {
        isLoader?.value = true;
        await APIFunction.deleteApiCall(
          apiUrl: ApiUrls.deleteCartApi(
            cartId: !isValEmpty(cartId) ? cartId : "",
          ),
        ).then(
          (response) async {
            if (response != null) {
              if (isRegistered<CartController>()) {
                final CartController con = Get.find<CartController>();
                if (!isValEmpty(cartId)) {
                  int index = con.cartList.indexWhere((e) => e.id == cartId);
                  if (index != -1) {
                    con.cartList.removeAt(index);
                  }
                } else {
                  con.cartList.clear();
                  con.selectedList.clear();
                }
              }
            }
            isLoader?.value = false;
            return response;
          },
        );
      }
    } catch (e) {
      isLoader?.value = false;
      printErrors(type: "deleteCartApi", errText: "$e");
    }
  }

  /// ***********************************************************************************
  ///                                MULTIPLE DELETE API
  /// ***********************************************************************************

  static Future<dynamic> multipleCartDelete({RxBool? isLoader, List<String>? selectedCartIds}) async {
    try {
      if (await getConnectivityResult()) {
        isLoader?.value = true;
        await APIFunction.deleteApiCall(
          apiUrl: ApiUrls.multiPleDelete,
          body: {
            "cartIds": selectedCartIds,
          },
        ).then(
          (response) async {
            if (response != null) {
              if (isRegistered<CartController>()) {
                final CartController con = Get.find<CartController>();

                con.cartList.removeWhere((item) => con.selectedList.contains(item));
                con.selectedList.clear();
              }
            }
            isLoader?.value = false;
            return response;
          },
        );
      }
    } catch (e) {
      isLoader?.value = false;
      printErrors(type: "deleteCartApi", errText: "$e");
    }
  }

  /// ***********************************************************************************
  ///                                 GET RETAILER API
  /// ***********************************************************************************
  static Future<dynamic> getRetailerApi({
    bool isInitial = true,
    RxBool? loader,
    required RxInt page,
    required RxInt itemLimit,
    required RxBool nextPageAvailable,
    required RxBool paginationLoader,
    required RxList<RetailerModel> retailerList,
  }) async {
    ///
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;
        if (isInitial) {
          retailerList.clear();
          page.value = 1;
          nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getRetailerApi,
          params: {
            "page": page.value,
            "limit": itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetRetailerModel model = GetRetailerModel.fromJson(response);

              if (model.data != null) {
                retailerList.addAll(model.data?.retailers ?? []);
                int currentPage = (model.data!.page ?? 1);
                nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                page.value += currentPage;
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
        printErrors(type: "getRetailerList", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                 GET CART SUMMARY API
  /// ***********************************************************************************
  static Future<dynamic> getCartSummaryAPI({RxBool? isLoader}) async {
    ///
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getCartSummary,
          loader: isLoader,
        ).then(
          (response) async {
            if (response != null) {
              if (isRegistered<SummaryController>()) {
                final SummaryController summaryCon = Get.find<SummaryController>();

                GetCartSummaryModel model = GetCartSummaryModel.fromJson(response);
                summaryCon.diamondSummaryList.value = model.data?.summary ?? [];
                summaryCon.totalDiamond.value = model.data?.totalDeliverySummary ?? TotalDeliverySummary();

                summaryCon.weightSummaryList.value = model.data?.weightSummary ?? [];
                summaryCon.totalWeight.value = model.data?.totalWeightSummary ?? TotalWeightSummary();
              }
              isLoader?.value = false;
            } else {
              isLoader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "getCartSummary", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                UPDATE CART API
  /// ***********************************************************************************
  static Future<dynamic> updateCartApi({
    RxBool? isLoader,
    required String cartId,
    required String inventoryId,
    required int quantity,
    required String metalId,
    required String sizeId,
    required String diamondClarity,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.putApiCall(
          apiUrl: ApiUrls.cartUpdatePUT,
          body: {
            "cart_id": cartId,
            "inventory_id": inventoryId,
            "quantity": quantity,
            "metal_id": metalId,
            "size_id": sizeId,
            "diamond_clarity": diamondClarity,
          },
        ).then(
          (response) async {
            if (response != null) {
              getCartApi(background: true);
            }
            isLoader?.value = false;
            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "UpdateCart", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                ADD WATCHLIST TO CART API
  /// ***********************************************************************************
  static Future<dynamic> addWatchlistToCartAPI({
    RxBool? isLoader,
    required String watchlistId,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.postApiCall(
          apiUrl: ApiUrls.addWatchlistToCart(watchlistId: watchlistId),
        ).then(
          (response) async {
            if (response != null && response['data'] == true) {
              UiUtils.toast("Added Successfully");
            }
            isLoader?.value = false;
            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "addWatchlistToCartAPI", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                     GET STOCK
  /// **********************************************************************************
  static Future<void> getStockAPI({RxBool? isLoader}) async {
    final CartStockController stockCon = Get.find<CartStockController>();
    GetStockModel model = GetStockModel.fromJson(stockList /*response*/);
    stockCon.stockList.value = model.stockModel?.stocks ?? [];
  }

  /// ***********************************************************************************
  ///                                     GET PRODUCT DETAIL
  /// **********************************************************************************
  static Future<void> getProductDetailAPI({RxBool? isLoader}) async {
    final PreDefinedValueController dialogCon = Get.find<PreDefinedValueController>();
    GetProductDetailModel model = GetProductDetailModel.fromJson(productDetail /*response*/);
    dialogCon.cartProductDetailList.value = model.data?.productDetail ?? [];
  }
}
