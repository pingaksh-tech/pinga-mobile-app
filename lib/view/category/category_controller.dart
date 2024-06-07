import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../data/repositories/category/category_repositery.dart';

import '../../data/model/category/category_model.dart';

class CategoryController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxString brandTitle = "".obs;
  RxBool showCloseButton = false.obs;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  List latestProductList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ06xpVjn4EZ1x-_Ezxvca-NrIwosqqsxFEXA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwTzWNTIXdGSzODVn7fhI1YMTcwRCHk1sbGQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJUifOy7j778xQdDP42I04C7Hu0LgEaHs69Q&s",
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

  @override
  void onReady() {
    super.onReady();
    CategoryRepository.categoryListApi();
  }
}
