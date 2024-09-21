import 'package:get/get.dart';

import '../../../../data/model/cart/stock_model.dart';
import '../../../../data/repositories/cart/cart_repository.dart';

class CartStockController extends GetxController {
  RxList<StockList> stockList = <StockList>[].obs;
  RxString productName = "".obs;
  @override
  void onReady() {
    super.onReady();
    CartRepository.getStockAPI();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["productName"].runtimeType == String) {
        productName.value = Get.arguments["productName"];
      }
    }
  }
}
