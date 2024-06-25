import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/sub_category/sub_category_repository.dart';

class SubCategoryController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxString brandTitle = "".obs;
  RxBool showCloseButton = false.obs;
  RxList<SubCategoryModel> categoryList = <SubCategoryModel>[].obs;

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
    SubCategoryRepository.getSubCategoryListApi();
  }
}
