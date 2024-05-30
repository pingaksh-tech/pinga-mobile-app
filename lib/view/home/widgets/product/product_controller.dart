import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isCheck = true.obs;
  final List<Map<String, dynamic>> sortOptions = [
    {"title": "Price - Low to high", "isChecked": false.obs},
    {"title": "Price - High to Low", "isChecked": false.obs},
    {"title": "Newest First", "isChecked": false.obs},
    {"title": "Oldest First", "isChecked": false.obs},
    {"title": "Most Ordered", "isChecked": false.obs},
  ];
}
