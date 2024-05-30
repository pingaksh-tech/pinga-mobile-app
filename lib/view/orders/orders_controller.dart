import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/order/order_list_model.dart';
import '../../data/repositories/orders/orders_repository.dart';
import '../../exports.dart';

class OrdersController extends GetxController {
  RxBool isTypeLoading = false.obs;

  ScrollController scrollController = ScrollController();
  RxList<OrderListResult> orderProductList = <OrderListResult>[].obs;
  RxInt page = 1.obs;
  RxBool nextPageStop = true.obs;
  RxBool isLoading = false.obs;
  RxBool paginationLoading = false.obs;

  RxString selectedType = "All".obs;
  RxInt tabIndex = 0.obs;
  RxList<String> statusList = <String>["All", "Pending", "Accepted", "Rejected", "Completed"].obs;

  @override
  void onInit() {
    super.onInit();
    manageScrollController();
  }

  @override
  void onReady() {
    super.onReady();
    OrdersRepository.getAllOrdersAPI();
  }

  void manageScrollController() async {
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageStop.isTrue && paginationLoading.isFalse) {
            paginationLoading.value = true;
            await OrdersRepository.getAllOrdersAPI(isInitial: false);
          }
        }
      },
    );
  }
}

///product detail controller
class OrderProductDetailController extends GetxController {
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
