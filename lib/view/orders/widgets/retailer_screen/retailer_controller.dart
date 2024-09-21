import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/orders/orders_repository.dart';

class RetailerController extends GetxController {
  RxList<RetailerModel> retailerList = <RetailerModel>[].obs;
  Rx<RetailerModel> retailerModel = RetailerModel().obs;
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxString retailerId = "".obs;

  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  RxBool showCloseButton = false.obs;
  @override
  void onReady() {
    super.onReady();
    OrdersRepository.getRetailerApi(searchText: searchCon.value.text.trim(), loader: isLoading);
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["id"].runtimeType == String) {
        retailerId.value = Get.arguments["id"];
      }
    }
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET CATEGORIES API
            OrdersRepository.getRetailerApi(isInitial: false, loader: paginationLoader, searchText: searchCon.value.text.trim());
          }
        }
      },
    );
  }
}
