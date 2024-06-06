import 'package:get/get.dart';

import '../../../data/model/cart/stock_model.dart';
import '../../../data/repositories/cart/cart_repository.dart';

class CartStockController extends GetxController {
  RxList<StockList> stockList = <StockList>[].obs;
  @override
  void onReady() {
    super.onReady();
    CartRepository.getStockAPI();
  }
}
