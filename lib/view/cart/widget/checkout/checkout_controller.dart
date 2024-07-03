import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/cart_model.dart';
import '../../../../data/model/cart/retailer_model.dart';

class CheckoutController extends GetxController {
  RxInt quantity = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  String retailerId = "";
  RxList<CartModel> cartList = <CartModel>[].obs;

  /// Order Type
  Rx<TextEditingController> orderTypeCon = TextEditingController().obs;

  /// Retailer Listing

  Rx<RetailerModel> retailerModel = RetailerModel().obs;
  Rx<TextEditingController> retailerCon = TextEditingController().obs;

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
