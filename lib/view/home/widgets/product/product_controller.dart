import 'package:get/get.dart';

class ProductController extends GetxController {
  RxString categoryName = "".obs;
  final List<Map<String, dynamic>> sortOptions = [
    {"title": "Price - Low to high", "isChecked": false.obs},
    {"title": "Price - High to Low", "isChecked": false.obs},
    {"title": "Newest First", "isChecked": false.obs},
    {"title": "Oldest First", "isChecked": false.obs},
    {"title": "Most Ordered", "isChecked": false.obs},
  ];
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["categoryName"].runtimeType == String) {
        categoryName.value = Get.arguments["categoryName"];
      }
    }
  }
}
