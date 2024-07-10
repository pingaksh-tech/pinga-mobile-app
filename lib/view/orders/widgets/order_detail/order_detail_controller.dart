import 'package:get/get.dart';

import '../../../../data/model/order/single_order_model.dart';
import '../../../../data/repositories/orders/orders_repository.dart';

class OrderDetailController extends GetxController {
  RxString orderId = "".obs;
  Rx<GetOrderDetailDataModel> orderDetailModel = GetOrderDetailDataModel().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['orderId'].runtimeType == String) {
        orderId.value = Get.arguments['orderId'];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    OrdersRepository.getSingleOrderAPI(orderId: orderId.value, loader: isLoading);
  }
}
