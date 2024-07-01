import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/predefine_value_controller.dart';
import '../../data/model/common/splash_model.dart';
import '../../data/model/predefined_model/predefined_model.dart';
import '../../exports.dart';

class ProductDetailsController extends GetxController {
  Rx<ScrollController> scrollController = ScrollController().obs;

  RxInt currentPage = 0.obs;
  Rx<PageController> imagesPageController = PageController().obs;
  RxList<String> productImages = [
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-wm_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-4_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-2_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-3_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-R-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-W-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133_1800x1800.jpg?v=1715687513",
    "https://kisna.com/cdn/shop/files/our-promise-7-Days_adf02756-37a0-41e4-bc54-0a7ca584cfe2_1800x1800.webp?v=1715687519",
  ].obs;

  RxBool isLike = false.obs;
  RxBool isSize = true.obs;

  Rx<SizeModel> selectedSize = SizeModel().obs;
  Rx<MetalModel> selectedColor = MetalModel().obs;
  Rx<DiamondModel> selectedDiamond = DiamondModel().obs;
  RxString selectedRemark = "".obs;
  RxString productCategory = "".obs;

  /// Set Default Select Value Of Product
  Future<void> predefinedValue() async {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      List<MetalModel> colorList = preValueCon.metalsList;
      List<SizeModel> sizeList = await preValueCon.checkHasPreValue(productCategory.value, type: SelectableItemType.size.slug);
      List<DiamondModel> diamondList = preValueCon.diamondsList;
      selectedColor.value = colorList[0];
      if (sizeList.isNotEmpty) {
        selectedSize.value = sizeList[0];
      }
      selectedDiamond.value = diamondList[0];
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['category'].runtimeType == String) {
        productCategory.value = Get.arguments['category'];
      }
      if (Get.arguments['isSize'].runtimeType == bool) {
        isSize.value = Get.arguments['isSize'];
      }
      predefinedValue();
    }
  }
}
