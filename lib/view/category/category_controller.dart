import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxString brandTitle = "".obs;
  RxBool showCloseButton = false.obs;

  List<Map<String, dynamic>> categoryList = [
    {
      "catName": "Ring",
      "subTitle": "Available 4098",
    },
    {
      "catName": "Earrings",
      "subTitle": "Available 4058",
    },
    {
      "catName": "Pendants",
      "subTitle": "Available 2198",
    },
    {
      "catName": "Bangles",
      "subTitle": "Available 3598",
    },
    {
      "catName": "Necklace",
      "subTitle": "Available 3598",
    },
    {
      "catName": "Bangles",
      "subTitle": "Available 3598",
    },
    {
      "catName": "Earrings",
      "subTitle": "Available 3598",
    },
  ];
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["brandName"].runtimeType == String) {
        brandTitle.value = Get.arguments["brandName"];
      }
    }
  }
}
