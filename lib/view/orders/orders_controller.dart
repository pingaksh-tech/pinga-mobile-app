import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/order/order_list_model.dart';
import '../../data/repositories/orders/orders_repository.dart';

class OrdersController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList<OrderModel> orderList = <OrderModel>[].obs;
  RxInt page = 1.obs;
  RxInt itemLimit = 6.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool isLoading = false.obs;
  RxBool paginationLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    manageScrollController();
  }

  @override
  void onReady() {
    super.onReady();
    OrdersRepository.getAllOrdersAPI(loader: isLoading);
  }

  void manageScrollController() async {
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.isTrue && paginationLoading.isFalse) {
            /// PAGINATION CALL
            /// GET CATEGORIES API
            await OrdersRepository.getAllOrdersAPI(isInitial: false, loader: paginationLoading);
          }
        }
      },
    );
  }
}

///product detail controller
/* lass OrderProductDetailController extends GetxController {
  RxInt current = 0.obs;
  final CarouselController controller = CarouselController();

  Rx<OrderListResult> orderProductDetail = OrderListResult().obs;
  RxBool isOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["isOrder"].runtimeType == bool) {
        isOrder.value = Get.arguments["isOrder"];
        if (isOrder.isTrue) {
          if (Get.arguments["productDetail"].runtimeType == OrderListResult) {
            orderProductDetail.value = Get.arguments["productDetail"];
            printData(key: "OrderProductData", value: orderProductDetail.value.id);
          }
        }
      }
    }
  }
}
 */