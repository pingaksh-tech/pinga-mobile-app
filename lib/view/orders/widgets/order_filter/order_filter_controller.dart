import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../orders_controller.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/orders/orders_repository.dart';
import '../../../../exports.dart';

class OrderFilterController extends GetxController {
  Rx<OrderFilterType> filterType = OrderFilterType.type.obs;
  RxList<int> applyFilterCounts = <int>[].obs;
  RxInt filterCount = 0.obs;

  RxString selectUserType = "".obs;
  RxList<String> userType = [
    "Sellers",
    "Retailer",
  ].obs;

  Rx<TextEditingController> startDateCon = TextEditingController().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<TextEditingController> endDateCon = TextEditingController().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  Rx<TextEditingController> retailerCon = TextEditingController().obs;
  String retailerId = "";
  Rx<RetailerModel> retailerModel = RetailerModel().obs;

  RxBool startDateValidation = true.obs;
  RxBool endDateValidation = true.obs;
  RxString dateError = "".obs;
  bool validateDates() {
    if (startDateCon.value.text.trim().isNotEmpty &&
        endDateCon.value.text.trim().isEmpty) {
      dateError.value = "Please select end date";
      endDateValidation.value = false;
    } else if (endDateCon.value.text.trim().isNotEmpty &&
        startDateCon.value.text.trim().isEmpty) {
      dateError.value = "Please select start date";
      startDateValidation.value = false;
    } else {
      startDateValidation.value = true;
      endDateValidation.value = true;
    }
    return startDateValidation.value && endDateValidation.value;
  }

  @override
  void onInit() {
    super.onInit();
    applyFilterCounts
        .addAll(List.generate(OrderFilterType.values.length, (index) => 0));
  }

  void countAppliedFilters() {
    int count = 0;
    if (retailerCon.value.text.isNotEmpty) count++;
    if (endDateCon.value.text.isNotEmpty &&
        startDateCon.value.text.isNotEmpty) {
      count++;
    }
    filterCount.value = count;
  }

  void clearFilter() {
    final OrdersController ordersController = Get.find<OrdersController>();

    OrdersRepository.getAllOrdersAPI(
            loader: ordersController.isLoading, isInitial: true)
        .then(
      (value) {
        Get.back();
      },
    );
    startDateCon.value.clear();
    endDateCon.value.clear();
    retailerCon.value.clear();
    retailerId = "";
    startDateValidation.value = true;
    endDateValidation.value = true;
    dateError.value = "";
    countAppliedFilters();
    applyFilterCounts.value =
        (List.generate(OrderFilterType.values.length, (index) => 0));
  }
}
