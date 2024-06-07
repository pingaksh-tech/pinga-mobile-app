import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/cart/cart_model.dart';
import '../../data/repositories/cart/cart_repository.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<CartItemModel> productsList = <CartItemModel>[].obs;
  RxList<CartItemModel> selectedList = <CartItemModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble totalQuantity = 0.0.obs;
  RxDouble selectedPrice = 0.0.obs;
  Timer? updateCartDebounce;
  RxBool isCartItemSelected = false.obs;

  @override
  void onReady() {
    super.onReady();
    CartRepository.cartListApi();
    calculateTotalPrice();
    calculateQuantity();
  }

  num calculateTotalPrice() {
    List<num> priceList = productsList.map((element) => (element.product?.price ?? 1)).toList();
    List<int> quantityList = productsList.map((element) => (element.quantity.value)).toList();
    num totalPrices = 0;
    for (int i = 0; i < priceList.length; i++) {
      totalPrices = totalPrices + quantityList[i] * priceList[i];
    }
    totalPrice.value = double.tryParse(totalPrices.toString()) ?? 0.0;
    return totalPrice.value;
  }

  num calculateQuantity() {
    List<int> quantityList = productsList.map((element) => (element.quantity.value)).toList();
    num quantity = 0;
    for (int i = 0; i < quantityList.length; i++) {
      quantity = quantity + quantityList[i];
    }
    totalQuantity.value = double.tryParse(quantity.toString()) ?? 0.0;
    return totalQuantity.value;
  }

  num calculateSelectedItemPrice() {
    List<num> priceList = selectedList.map((element) => (element.product?.price ?? 1)).toList();
    List<int> quantityList = selectedList.map((element) => (element.quantity.value)).toList();
    num price = 0;
    for (int i = 0; i < priceList.length; i++) {
      price = price + quantityList[i] * priceList[i];
    }
    selectedPrice.value = double.tryParse(price.toString()) ?? 0.0;
    return selectedPrice.value;
  }

  Future<void> removeProductFromCart(BuildContext context, {required int index}) async {
    Get.back();
    productsList.removeAt(index);

    /// TEMP
    calculateTotalPrice();

    ///
    /* await CartDialogs.cartItemRemoveDialog(
      context: context,
      deleteNote: "Would you like to remove item form cart?",
      onTap: () async {
        await CartRepository.addOrRemoveProductInCart(productID: productsList[index].product?.id ?? "", currentValue: true).then(
          (value) {
            Get.back();
            productsList.removeAt(index);
            // if (Get.isRegistered<HomeController>()) {
            //   final HomeController homeCon = Get.find<HomeController>();
            //   int myIndex = homeCon.homeProductList.indexWhere((element) => element.id == con.productsList[index].product?.id);
            //   if (myIndex != -1) {
            //     homeCon.homeProductList[myIndex].cart?.value = value;
            //   }
            // }
          },
        );
      },
    );*/
  }
}
