import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/model/filter/gender_model.dart';
import '../../../../data/model/filter/stock_available_model.dart';
import '../../../../data/repositories/filter/filter_repository.dart';
import '../../../../exports.dart';

class FilterController extends GetxController {
  RxBool isLoader = false.obs;

  RxDouble minMetalWt = 0.01.obs;
  RxDouble maxMetalWt = 200.0.obs;
  RxDouble minDiamondWt = 0.01.obs;
  RxDouble maxDiamondWt = 20.0.obs;
  RxString selectSeller = "".obs;
  RxString selectLatestDesign = "".obs;

  Rx<TextEditingController> itemNameCon = TextEditingController().obs;
  RxString selectFilter = "Range".obs;
  Rx<FilterItemType> filterType = FilterItemType.range.obs;

  RxBool? isAvailable;
  RxList<StockAvailableList> availableList = <StockAvailableList>[].obs;
  RxList<Product> genderList = <Product>[].obs;

  /// ================  MRP ==================>
  Rx<TextEditingController> mrpFromCon = TextEditingController().obs;
  Rx<TextEditingController> mrpToCon = TextEditingController().obs;

  RxMap selectMrp = {"label": "".obs, "min": 0, "max": 0}.obs;
  RxList mrpList = [
    {"label": "upto 25,000".obs, "min": 0, "max": 25000},
    {"label": "25,001 - 50,000".obs, "min": 25001, "max": 50000},
    {"label": "50,001 - 75,000".obs, "min": 50001, "max": 75000},
    {"label": "75,001 - 1,00,000".obs, "min": 75001, "max": 100000},
    {"label": "1,00,001 to above".obs, "min": 100001, "max": 0},
  ].obs;

  final RxList<dynamic> selectedDiamonds = [].obs;
  final RxList<dynamic> selectedGender = [].obs;
  final RxList<dynamic> selectedKt = [].obs;
  final RxList<dynamic> selectedDelivery = [].obs;
  final RxList<dynamic> selectedProductNames = [].obs;
  final RxList<dynamic> selectedCollections = [].obs;

  final List<Map<String, dynamic>> diamondList = [
    {"title": "VVS-EF", "isChecked": false.obs},
    {"title": "VS-SI-GH", "isChecked": false.obs},
    {"title": "VS-SI-HI", "isChecked": false.obs},
    {"title": "SI-HI", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> ktList = [
    {"title": "14KT (55)", "isChecked": false.obs},
    {"title": "18KT (50)", "isChecked": false.obs},
    {"title": "950PT (32)", "isChecked": false.obs},
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
    minMetalWt.value = 0.01;
    maxMetalWt.value = 200.0;

    selectedProductNames.clear();
    selectedDelivery.clear();
    selectedKt.clear();
    selectedDiamonds.clear();
    selectedCollections.clear();
    selectedGender.clear();

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

  String subCategoryId = "";
  String categoryId = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['subCategoryId'].runtimeType == String) {
        subCategoryId = Get.arguments['subCategoryId'];
        categoryId = Get.arguments['categoryId'];
      }
    }
  }
}
