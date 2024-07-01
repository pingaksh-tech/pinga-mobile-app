import 'package:get/get.dart';

import '../../../controller/predefine_value_controller.dart';
import '../../../exports.dart';
import '../../../view/cart/cart_controller.dart';
import '../../../view/cart/widget/checkout/checkout_controller.dart';
import '../../../view/cart/widget/stock/cart_stock_controller.dart';
import '../../model/cart/cart_model.dart';
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

  static Future<dynamic> getCartApi({bool isInitial = true, bool isPullToRefresh = false, RxBool? loader}) async {
    ///
    if (await getConnectivityResult() && isRegistered<CartController>()) {
      final CartController con = Get.find<CartController>();

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
          apiUrl: ApiUrls.getCartList,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetCartModel model = GetCartModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.cartList.value = model.data?.cartList ?? [];
                } else {
                  con.cartList.addAll(model.data?.cartList ?? []);
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
        printErrors(type: "getCartList", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                 DELETE API
  /// ***********************************************************************************

  static Future<dynamic> deleteCartAPi({RxBool? isLoader, String? cartId}) async {
    try {
      if (await getConnectivityResult()) {
        isLoader?.value = true;
        await APIFunction.deleteApiCall(apiUrl: ApiUrls.deleteCartApi(cartId: !isValEmpty(cartId) ? cartId : "")).then(
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
                  con.cartList.removeWhere((item) => con.selectedList.contains(item));
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
  ///                                 GET RETAILER API
  /// ***********************************************************************************
  static Future<dynamic> getRetailerApi({bool isInitial = true, RxBool? loader}) async {
    ///
    if (await getConnectivityResult() && isRegistered<CheckoutController>()) {
      final CheckoutController con = Get.find<CheckoutController>();

      try {
        loader?.value = true;
        if (isInitial) {
          con.retailerList.clear();
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getRetailerApi,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetRetailerModel model = GetRetailerModel.fromJson(response);

              if (model.data != null) {
                con.retailerList.addAll(model.data?.retailers ?? []);
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
        printErrors(type: "getRetailerList", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                       UPDATE QUANTITY
  /// ***********************************************************************************

  static Future<void> updateQuantityAPI({required String productId, required bool doIncrease}) async {
    final CartController cartCon = Get.find<CartController>();

    /// TEMP
    cartCon.calculateTotalPrice();

    ///
    try {
      await APIFunction.putApiCall(apiUrl: "${ApiUrls.cartUpdatePUT}$productId", body: {"action": doIncrease ? "+" : "-"}).then(
        (response) async {
          printOkStatus("Cart Updated Successfully");
          cartCon.calculateTotalPrice();
        },
      );
    } catch (e) {
      printErrors(type: "Error", errText: "$e");
    }
  }

  /// ***********************************************************************************
  ///                               ADD or REMOVE PRODUCT IN CART
  /// ***********************************************************************************
  static Future<bool> addOrRemoveProductInCart({required String productID, required bool currentValue, RxBool? isLoading}) async {
    try {
      isLoading?.value = true;
      await APIFunction.putApiCall(apiUrl: "${ApiUrls.addOrRemoveCart}$productID", loader: isLoading).then(
        (response) async {
          currentValue = !currentValue;
          UiUtils.toast(response["message"]);
        },
      );

      return currentValue;
    } catch (e) {
      printErrors(type: "addOrRemoveProductInCart", errText: "$e");
      return currentValue;
    } finally {
      isLoading?.value = false;
    }
  }

  /// ***********************************************************************************
  ///                                       PLACE ORDER
  /// ***********************************************************************************
/*
  static Future<void> placeOrderAPI() async {
    final CartController cartCon = Get.find<CartController>();
    try {
      cartCon.isLoading.value = true;

      await APIFunction.postApiCall(
        apiUrl: ApiUrls.placeOrderPOST,
        loader: cartCon.isLoading,
      ).then(
        (response) async {
          // if (Get.isRegistered<HomeController>()) {
          //   HomeController homeCon = Get.find<HomeController>();
          //   for (int i = 0; i < homeCon.homeProductList.length; i++) {
          //     homeCon.homeProductList[i].cart = false.obs;
          //   }
          // }
          cartCon.isLoading.value = false;
          UiUtils.toast("Order Placed Successfully");
          Get.find<BottomBarController>().onBottomBarTap(3);
        },
      );
    } catch (e) {
      printErrors(type: "Error", errText: "$e");
      UiUtils.toast("PLease try again");
      cartCon.isLoading.value = false;
    } finally {}
  }
 */
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
