import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/data/model/cart/cart_model.dart';

import '../../data/repositories/cart/cart_repository.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<CartItemModel> productsList = <CartItemModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  Timer? updateCartDebounce;

  @override
  void onReady() {
    super.onReady();
    CartRepository.cartListApi();
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

  Future<void> removeProductFromCart(BuildContext context, {required int index}) async {
    productsList.removeAt(index);
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
