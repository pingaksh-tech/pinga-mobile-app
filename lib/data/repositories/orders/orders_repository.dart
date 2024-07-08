import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/orders/orders_controller.dart';
import '../../../view/orders/widgets/order_detail/order_detail_controller.dart';
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
              getAllOrdersAPI(isPullToRefresh: true);
              CartRepository.getCartApi(isPullToRefresh: true);
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
        printErrors(type: "getCartList", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                 GET ORDER DETAIL
  /// ***********************************************************************************

  static Future<dynamic> getSingleProductAPI({RxBool? loader, required String orderId}) async {
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
}
