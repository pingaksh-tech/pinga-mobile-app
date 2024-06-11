import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';

class OrderFilterController extends GetxController {
  Rx<OrderFilterType> filterType = OrderFilterType.type.obs;
  RxString selectUserType = "".obs;
  RxList<String> userType = [
    "Sellers",
    "Buyer",
    "Admin",
  ].obs;

  Rx<TextEditingController> startDateCon = TextEditingController().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<TextEditingController> endDateCon = TextEditingController().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
}
