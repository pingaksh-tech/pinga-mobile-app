import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../exports.dart';

class OrderFilterController extends GetxController {
  Rx<OrderFilterType> filterType = OrderFilterType.type.obs;
  RxString selectUserType = "".obs;
  RxList<String> userType = [
    "Sellers",
    "Retailer",
  ].obs;

  Rx<TextEditingController> startDateCon = TextEditingController().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<TextEditingController> endDateCon = TextEditingController().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxList<RetailerModel> retailerList = <RetailerModel>[].obs;
  Rx<TextEditingController> retailerCon = TextEditingController().obs;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
}
