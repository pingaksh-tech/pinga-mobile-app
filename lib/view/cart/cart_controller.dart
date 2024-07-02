import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/cart/cart_model.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/cart/cart_repository.dart';

class CartController extends GetxController {
  Rx<SubCategoryModel> category = SubCategoryModel().obs;

  /// Cart Total item count
  Rx<CartsDetails> cartDetail = CartsDetails().obs;

  /// Cart List pagination
  RxList<CartModel> cartList = <CartModel>[].obs;
  RxBool cartLoader = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;

  RxList<CartModel> selectedList = <CartModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalQuantity = 0.obs;
  RxInt selectedQuantity = 0.obs;

  RxDouble selectedPrice = 0.0.obs;
  Timer? updateCartDebounce;
  RxBool isCartItemSelected = false.obs;

  @override
  void onReady() {
    super.onReady();
    CartRepository.getCartApi(loader: cartLoader);
    manageScrollController();
    calculateTotalPrice();
    calculateQuantity();
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET CATEGORIES API
            CartRepository.getCartApi(isInitial: false, loader: paginationLoader);
          }
        }
      },
    );
  }

  num calculateTotalPrice() {
    List<num> priceList = cartList.map((element) => (element.inventoryTotalPrice ?? 1)).toList();
    List<int> quantityList = cartList.map((element) => (element.quantity ?? 1)).toList();
    num totalPrices = 0;
    for (int i = 0; i < priceList.length; i++) {
      totalPrices = totalPrices + quantityList[i] * priceList[i];
    }
    totalPrice.value = double.tryParse(totalPrices.toString()) ?? 0.0;
    return totalPrice.value;
  }

  num calculateSelectedItemPrice() {
    List<num> priceList = selectedList.map((element) => (element.inventoryTotalPrice ?? 1)).toList();
    List<int> quantityList = selectedList.map((element) => (element.quantity ?? 1)).toList();
    num price = 0;
    for (int i = 0; i < priceList.length; i++) {
      price = price + quantityList[i] * priceList[i];
    }
    selectedPrice.value = double.tryParse(price.toString()) ?? 0.0;
    return selectedPrice.value;
  }

  int calculateQuantity() {
    List<int> quantityList = cartList.map((element) => (element.quantity ?? 1)).toList();
    num quantity = 0;
    for (int i = 0; i < quantityList.length; i++) {
      quantity = quantity + quantityList[i];
    }
    totalQuantity.value = quantity.toInt();
    return totalQuantity.value;
  }

  int calculateSelectedQue() {
    List<int> quantityList = selectedList.map((element) => (element.quantity ?? 1)).toList();
    num selectQuantity = 0;
    for (int i = 0; i < quantityList.length; i++) {
      selectQuantity = selectQuantity + quantityList[i];
    }
    selectedQuantity.value = selectQuantity.toInt();
    return selectedQuantity.value;
  }

  void decrementQuantity(CartModel item) {
    calculateTotalPrice();
    calculateQuantity();
    if (selectedList.contains(item)) {
      calculateSelectedItemPrice();
      calculateSelectedQue();
    }
  }

  void incrementQuantity(CartModel item) {
    calculateTotalPrice();
    calculateQuantity();
    if (selectedList.contains(item)) {
      calculateSelectedItemPrice();
      calculateSelectedQue();
    }
  }
}
