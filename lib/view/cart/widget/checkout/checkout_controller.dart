import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/cart_model.dart';
import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/cart/cart_repository.dart';

class CheckoutController extends GetxController {
  RxInt quantity = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  String retailerId = "";
  RxList<CartModel> cartList = <CartModel>[].obs;

  /// Order Type
  Rx<TextEditingController> orderTypeCon = TextEditingController().obs;

  /// Retailer Listing
  RxList<RetailerModel> retailerList = <RetailerModel>[].obs;
  Rx<RetailerModel> retailerModel = RetailerModel().obs;
  Rx<TextEditingController> retailerCon = TextEditingController().obs;

  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  @override
  void onReady() {
    super.onReady();
    CartRepository.getRetailerApi(loader: isLoading);
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["subQuantity"].runtimeType == int) {
        quantity.value = Get.arguments["subQuantity"];
      }
      if (Get.arguments["subTotal"].runtimeType == double) {
        totalPrice.value = Get.arguments["subTotal"];
      }
      if (Get.arguments["cartList"].runtimeType == RxList<CartModel>) {
        cartList = Get.arguments["cartList"];
      }
    }
  }
}
