import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewController extends GetxController {
  RxInt currentPage = 0.obs;
  Rx<PageController> imagesPageController = PageController().obs;
  RxList<String> imageList = <String>[].obs;
  RxString productName = "".obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['imageList'].runtimeType == RxList<String>) {
        imageList = Get.arguments['imageList'];
      }
      if (Get.arguments['name'].runtimeType == String) {
        productName.value = Get.arguments['name'];
      }
    }
  }
}
