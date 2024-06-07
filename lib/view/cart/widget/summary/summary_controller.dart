import 'package:get/get.dart';

class SummaryController extends GetxController {
  RxList<Map<String, dynamic>> summaryList = [
    {"deliveryDay": "15 Days", "quantity": "680", "price": "2867536", "delivery": "Delivery"},
    {"deliveryDay": "55 Days", "quantity": "680", "price": "2867536"},
    {"deliveryDay": "15 Days", "quantity": "680", "price": "2867536"},
  ].obs;
}
