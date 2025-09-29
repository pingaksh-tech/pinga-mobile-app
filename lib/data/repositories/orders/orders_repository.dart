import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/bottombar/bottombar_controller.dart';
import '../../../view/cart/cart_controller.dart';
import '../../../view/orders/orders_controller.dart';
import '../../../view/orders/widgets/order_detail/order_detail_controller.dart';
import '../../../view/orders/widgets/retailer_screen/retailer_controller.dart';
import '../../api/api_class.dart';
import '../../model/cart/retailer_model.dart';
import '../../model/order/order_list_model.dart';
import '../../model/order/single_order_model.dart';
import '../cart/cart_repository.dart';

class OrdersRepository {
  /// ***********************************************************************************
  ///                                CREATE ORDER API
  /// ***********************************************************************************
  static Future<void> createOrder({
    required String retailerId,
    required String orderType,
    required int quantity,
    required String subTotal,
    required List<Map<String, dynamic>> cartItems,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createOrGetOrder,
          receiveTimeout: HttpUtil.orderCreateAPITimeOut,
          sendTimeout: HttpUtil.orderCreateAPITimeOut,
          body: {
            "retailer_id": retailerId,
            "order_type": orderType,
            "qty": quantity,
            "sub_total": subTotal,
            "orderItems": cartItems,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              /// All Order api
              await getAllOrdersAPI(isPullToRefresh: true);

              /// Get cart api
              await CartRepository.getCartApi(isPullToRefresh: true);

              if (isRegistered<CartController>()) {
                final CartController con = Get.find<CartController>();
                con.cartList.removeWhere((item) => con.selectedList.contains(item));
                con.selectedList.clear();
              }
              do {
                Get.back();
              } while (Get.currentRoute != AppRoutes.bottomBarScreen);
              if (isRegistered<BottomBarController>()) {
                BottomBarController bottomCon = Get.find<BottomBarController>();
                bottomCon.currentBottomIndex.value = 3;
              }
              UiUtils.toast("Order Created Successfully");
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createOrderApi", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                    GET ALL ORDERS
  /// ***********************************************************************************

  static Future<dynamic> getAllOrdersAPI({
    bool isInitial = true,
    RxBool? loader,
    bool isPullToRefresh = false,
    DateTime? startDate,
    DateTime? endDate,
    String? retailerId,
  }) async {
    ///
    if (await getConnectivityResult() && isRegistered<OrdersController>()) {
      final OrdersController con = Get.find<OrdersController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.orderList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createOrGetOrder,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
            if (!isValEmpty(startDate)) "start_date": startDate?.toIso8601String(),
            if (!isValEmpty(endDate)) "end_date": endDate?.toIso8601String(),
            if (!isValEmpty(retailerId)) "retailer_id": retailerId,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetOrderModel model = GetOrderModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.orderList.value = model.data?.orders ?? [];
                } else {
                  con.orderList.addAll(model.data?.orders ?? []);
                }
                con.orderCounts.value = model.data?.orderCounts ?? OrderCounts();
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
        printErrors(type: "getOrderList", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                 GET ORDER DETAIL
  /// ***********************************************************************************

  static Future<dynamic> getSingleOrderAPI({RxBool? loader, required String orderId}) async {
    ///
    if (await getConnectivityResult() && isRegistered<OrderDetailController>()) {
      final OrderDetailController con = Get.find<OrderDetailController>();

      try {
        loader?.value = true;

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getSingleOrderDetailGET(orderId: orderId),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSingleOrderDetailModel model = GetSingleOrderDetailModel.fromJson(response);

              if (model.data != null) {
                con.orderDetailModel.value = model.data!;
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
        printErrors(type: "getSingleOrderAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                 GET RETAILER API
  /// ***********************************************************************************
  static Future<dynamic> getRetailerApi({
    bool isInitial = true,
    RxBool? loader,
    required String searchText,
  }) async {
    ///
    if (await getConnectivityResult()) {
      final RetailerController con = Get.find<RetailerController>();

      try {
        loader?.value = true;
        // if (isInitial) {
        //   con.retailerList.clear();
        //   con.page.value = 1;
        //   con.nextPageAvailable.value = true;
        // }
        if (isInitial) {
          con.retailerList.clear();
          con.page.value = 1;
          con.nextPageAvailable.value;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getRetailerApi,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
            "search": searchText,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetRetailerModel model = GetRetailerModel.fromJson(response);

              if (model.data != null) {
                if (isInitial) {
                  con.retailerList.assignAll(model.data?.retailers ?? []);
                } else {
                  con.retailerList.addAll(model.data?.retailers ?? []);
                }

                con.page.value++;
                con.nextPageAvailable.value = model.data?.page != model.data?.totalPages;

                loader?.value = false;

                // con.retailerList.addAll(model.data?.retailers ?? []);
                // int currentPage = (model.data!.page ?? 1);
                // con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                // con.page.value += currentPage;
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
}
