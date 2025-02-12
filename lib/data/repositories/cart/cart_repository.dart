import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../controller/predefine_value_controller.dart';
import '../../../exports.dart';
import '../../../view/cart/cart_controller.dart';
import '../../../view/cart/widget/stock/cart_stock_controller.dart';
import '../../../view/cart/widget/summary/summary_controller.dart';
import '../../../view/product_details/product_details_controller.dart';
import '../../model/cart/cart_model.dart';
import '../../model/cart/cart_summary_model.dart';
import '../../model/cart/product_detail_model.dart';
import '../../model/cart/stock_model.dart';
import '../../model/product/single_product_model.dart';

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
        {"id": "stock4", "value": "Yellow + White", "stock": "Color", "image": AppAssets.metalWeight},
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

  /// ***********************************************************************************
  ///                                 GET CART API
  /// ***********************************************************************************

  static Future<dynamic> getCartApi({
    bool isInitial = true,
    RxBool? loader,
    bool isPullToRefresh = false,
    bool isBackground = false,
  }) async {
    ///
    if (await getConnectivityResult() && isRegistered<CartController>()) {
      final CartController con = Get.find<CartController>();
      // con.cartList.clear();
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
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
              log(jsonEncode(response));
              if (model.data != null) {
                if (isPullToRefresh) {
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
              /// Get cart api
              await getCartApi(isPullToRefresh: true);

              // if (isRegistered<BaseController>()) {
              //   BaseController con = Get.find<BaseController>();
              //   if (!isValEmpty(cartId)) {
              //     int index = con.globalProductDetails
              //         .indexWhere((e) => e["productId"] == cartId);
              //     if (index != -1) {
              //       con.globalProductDetails.removeAt(index);
              //     }
              //   }
              // }
              if (isRegistered<CartController>()) {
                final CartController con = Get.find<CartController>();
                if (!isValEmpty(cartId)) {
                  int index = con.selectedList.indexWhere((e) => e.id == cartId);
                  if (index != -1) {
                    con.selectedList.removeAt(index);
                  }
                  con.cartList.refresh();
                  con.calculateSelectedQue();
                  con.calculateSelectedItemPrice();
                } else {
                  con.cartList.refresh();
                  con.cartList.clear();
                  con.selectedList.clear();
                }
              }
              UiUtils.toast("Cart Deleted Successfully");
              isLoader?.value = false;
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
              /// Get cart api
              await getCartApi(isPullToRefresh: true);
              // if (isRegistered<BaseController>()) {
              //   BaseController baseCon = Get.find<BaseController>();
              //   baseCon.globalProductDetails.removeWhere(
              //       (item) => selectedCartIds!.contains(item["productId"]));
              //   printBlue(baseCon.globalProductDetails);
              // }

              if (isRegistered<CartController>()) {
                final CartController con = Get.find<CartController>();
                con.cartList.removeWhere((item) => con.selectedList.contains(item));
                con.selectedList.clear();
                con.cartList.refresh();
                con.calculateSelectedQue();
                con.calculateSelectedItemPrice();
              }
            }
            UiUtils.toast("Cart Deleted Successfully");
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
  static Future<dynamic> addOrUpdateCartApi({
    RxBool? isLoader,
    String? cartId,
    required String inventoryId,
    required int quantity,
    required String metalId,
    required String sizeId,
    required String diamondClarity,
    required String remark,
    num? extraMetalWeight,
    List<Map<String, dynamic>>? diamonds,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.putApiCall(
          apiUrl: ApiUrls.cartUpdatePUT,
          body: {
            if (!isValEmpty(cartId)) "cart_id": cartId,
            "inventory_id": inventoryId,
            "quantity": quantity,
            "metal_id": metalId,
            if (!isValEmpty(sizeId)) "size_id": sizeId,
            if (!isValEmpty(remark)) "remark": remark,
            if (!isValEmpty(diamondClarity)) "diamond_clarity": diamondClarity,
            if (!isValEmpty(diamonds)) "diamonds": diamonds,
            if (!isValEmpty(extraMetalWeight)) "extra_metal_weight": extraMetalWeight,
          },
        ).then(
          (response) async {
            printData(
              value: response,
              key: "UpdateCart",
            );
            if (response != null) {
              /// Get cart api
              await getCartApi(isPullToRefresh: true);
              UiUtils.toast("Cart Updated Successfully");
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
              await getCartApi(isPullToRefresh: true);
              UiUtils.toast("Product add to cart successfully");
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
  ///                                 GET CART DETAIL
  /// ***********************************************************************************

  static Future<dynamic> getSingleCartItemAPI({RxBool? loader, required String cartId}) async {
    ///
    if (await getConnectivityResult() && isRegistered<ProductDetailsController>()) {
      final ProductDetailsController con = Get.find<ProductDetailsController>();

      try {
        loader?.value = true;

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getSingleCartDetailGET(cartId: cartId),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSingleProductModel model = GetSingleProductModel.fromJson(response);

              if (model.data != null) {
                con.productDetailModel.value = model.data!;
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
        printErrors(type: "getSingleCartAPI", errText: e);
      }
    } else {}
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
