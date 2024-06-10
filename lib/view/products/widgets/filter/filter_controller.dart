import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/model/filter/gender_model.dart';
import '../../../../data/model/filter/stock_available_model.dart';
import '../../../../data/repositories/filter/filter_repository.dart';
import '../../../../exports.dart';

class FilterController extends GetxController {
  RxDouble minMetalWt = 0.0.obs;
  RxDouble maxMetalWt = 12.0.obs;
  RxDouble minDiamondWt = 0.0.obs;
  RxDouble maxDiamondWt = 50.0.obs;
  RxString selectSeller = "".obs;
  RxString selectLatestDesign = "".obs;

  Rx<TextEditingController> itemNameCon = TextEditingController().obs;
  RxString selectFilter = "Range".obs;
  Rx<FilterItemType> filterType = FilterItemType.rang.obs;

  RxList<StockAvailableList> availableList = <StockAvailableList>[].obs;
  RxList<Product> genderList = <Product>[].obs;

  final List<Map<String, dynamic>> diamondList = [
    {"title": "VVS-EF", "isChecked": false.obs},
    {"title": "VS-SI-GH", "isChecked": false.obs},
    {"title": "VS-SI-HI", "isChecked": false.obs},
    {"title": "SI-HI", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> ktList = [
    {"title": "22KT (30)", "isChecked": false.obs},
    {"title": "18KT (50)", "isChecked": false.obs},
    {"title": "24KT (55)", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> deliveryList = [
    {"title": "30 Days", "isChecked": false.obs},
    {"title": "56 Hours", "isChecked": false.obs},
    {"title": "15 Days", "isChecked": false.obs},
  ];
  final List<Map<String, dynamic>> productionNameList = [
    {"title": "Anantam", "isChecked": false.obs},
    {"title": "Celebration", "isChecked": false.obs},
    {"title": "Tvamev", "isChecked": false.obs},
    {"title": "Rista", "isChecked": false.obs},
    {"title": "Shine Forever", "isChecked": false.obs},
    {"title": "Ghoomar", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> collectionList = [
    {"title": "Fashion (3)", "isChecked": false.obs},
    {"title": "Mens (2)", "isChecked": false.obs},
    {"title": "Ghoomar 6", "isChecked": false.obs},
    {"title": "Desire 4", "isChecked": false.obs},
    {"title": "Cluster (1)", "isChecked": false.obs},
    {"title": "Color Stone (5)", "isChecked": false.obs},
    {"title": "Crafting The Sparkle", "isChecked": false.obs},
  ];

//? Clear All Filter
  void clearAllFilters() {
    minMetalWt.value = 0.0;
    maxMetalWt.value = 12.0;

    for (var brand in diamondList) {
      brand["isChecked"].textValue = false;
    }
    for (var kt in ktList) {
      kt["isChecked"].textValue = false;
    }
    for (var delivery in deliveryList) {
      delivery["isChecked"].textValue = false;
    }
    for (var tag in productionNameList) {
      tag["isChecked"].textValue = false;
    }
    for (var collection in collectionList) {
      collection["isChecked"].textValue = false;
    }

    selectSeller.value = "";
    selectLatestDesign.value = "";
  }

  int rangeCount() {
    int range = 0;
    if ((minMetalWt.value > 0.0 || maxMetalWt.value < 12.0) && (minDiamondWt.value > 0.0 || maxDiamondWt.value < 50.0)) {
      range = 2;
    } else if (minMetalWt.value > 0.0 || maxMetalWt.value < 12.0) {
      range = 1;
    } else if (minDiamondWt.value > 0.0 || maxDiamondWt.value < 50.0) {
      range = 1;
    }
    return range;
  }

//? Count Active filter
  int getActiveFilterCount(String filterType) {
    switch (filterType) {
      case "Range":
        return rangeCount();
      case "Gender":
        return genderList.where((gender) => false /*gender["isChecked"].textValue*/).length;
      case "Diamond":
        return diamondList.where((brand) => false /*brand["isChecked"].textValue*/).length;

      case "KT":
        return ktList.where((kt) => false /*kt["isChecked"].textValue*/).length;
      case "Delivery":
        return deliveryList.where((delivery) => false /*delivery["isChecked"].textValue*/).length;
      case "Production Name":
        return productionNameList.where((tag) => false /*tag["isChecked"].textValue*/).length;
      case "Collection":
        return collectionList.where((collection) => false /*collection["isChecked"].textValue*/).length;
      default:
        return 0;
    }
  }

  @override
  void onReady() {
    super.onReady();
    FilterRepository.stockAvailableList();
    FilterRepository.genderListAPI();
  }
}
