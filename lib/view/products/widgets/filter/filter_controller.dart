import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/model/filter/gender_model.dart';
import '../../../../data/model/filter/mrp_model.dart';
import '../../../../data/model/filter/stock_available_model.dart';
import '../../../../data/repositories/filter/filter_repository.dart';
import '../../../../exports.dart';

class FilterController extends GetxController {
  RxBool isLoader = false.obs;

  RxList<FilterItemType> filterOptions = FilterItemType.values.obs;
  RxList<int> applyFilterCounts = <int>[].obs;

  RxDouble minMetalWt = 0.01.obs;
  RxDouble maxMetalWt = 200.0.obs;
  RxDouble minDiamondWt = 0.01.obs;
  RxDouble maxDiamondWt = 20.0.obs;
  RxString selectSeller = "".obs;
  RxString selectLatestDesign = "".obs;

  RxString selectFilter = "Range".obs;
  Rx<TextEditingController> itemNameCon = TextEditingController().obs;
  Rx<FilterItemType> filterType = FilterItemType.range.obs;

  RxBool isAvailable = true.obs;
  RxList<StockAvailableList> availableList = <StockAvailableList>[].obs;
  RxList<Product> genderList = <Product>[].obs;

  /// ================  MRP ==================>
  Rx<TextEditingController> mrpFromCon = TextEditingController().obs;
  Rx<TextEditingController> mrpToCon = TextEditingController().obs;

  RxList<MrpModel> mrpList = [
    MrpModel(label: "upto 25,000".obs, min: 0.obs, max: 25000.obs),
    MrpModel(label: "25,001 - 50,000".obs, min: 25001.obs, max: 50000.obs),
    MrpModel(label: "50,001 - 75,000".obs, min: 50001.obs, max: 75000.obs),
    MrpModel(label: "75,001 - 1,00,000".obs, min: 75001.obs, max: 100000.obs),
    MrpModel(label: "1,00,001 to above".obs, min: 100001.obs),
  ].obs;
  Rx<MrpModel> selectMrp = MrpModel().obs;

  final RxList<String> selectedDiamonds = <String>[].obs;
  final RxList<String> selectedGender = <String>[].obs;
  final RxList<String> selectedKt = <String>[].obs;
  final RxList<String> selectedDelivery = <String>[].obs;
  final RxList<String> selectedProductNames = <String>[].obs;
  final RxList<String> selectedCollections = <String>[].obs;

  String subCategoryId = "";
  String categoryId = "";
  String watchlistId = "";
  ProductsListType productsListType = ProductsListType.normal;
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    applyFilterCounts.addAll(List.generate(filterOptions.length, (index) => 0));

    if (Get.arguments != null) {
      if (Get.arguments['subCategoryId'].runtimeType == String) {
        subCategoryId = Get.arguments['subCategoryId'];
        categoryId = Get.arguments['categoryId'];
      }
      if (Get.arguments['productListType'].runtimeType == ProductsListType) {
        productsListType = Get.arguments['productListType'];
      }
      if (Get.arguments['watchlistId'].runtimeType == String) {
        watchlistId = Get.arguments['watchlistId'];
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await FilterRepository.stockAvailableList();
  }

  void onSilderChangeCount() {
    if (minMetalWt >= 0.01 &&
        maxMetalWt <= 200.0 &&
        minDiamondWt >= 0.01 &&
        maxDiamondWt <= 20.0) {
      if (count == 0) {
        count++;
      }
    }
  }

//? Clear All Filter
  void clearAllFilters() {
    minMetalWt.value = 0.01;
    maxMetalWt.value = 200.0;
    minDiamondWt.value = 0.01;
    maxDiamondWt.value = 20.0;

    selectedProductNames.clear();
    selectedDelivery.clear();
    selectedKt.clear();
    selectedDiamonds.clear();
    selectedCollections.clear();
    selectedGender.clear();
    selectMrp.value = MrpModel();

    selectSeller.value = "";
    selectLatestDesign.value = "";
    count = 0;

    applyFilterCounts.value =
        (List.generate(filterOptions.length, (index) => 0));
  }

  /* void rangeCount() {
    int range = 0;
    if (minMetalWt.value >= 0.01 && maxMetalWt.value < 200.0) {
      printOkStatus("dn");
      if (range == 0) {
        range = 1;
        count += range;
        printOkStatus(count);
      }
    } else {
      if (range == 1) {
        range = 0;
        count -= 1;
        printOkStatus(count);
      }
    }
  } */

// void getCount() {
//   rangeCount();
//   if (selectMrp != {"label": "".obs, "min": 0, "max": 0}.obs) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedGender.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedDiamonds.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedKt.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedDelivery.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedProductNames.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
//
//   if (selectedCollections.isNotEmpty) {
//     count++;
//   } else {
//     count--;
//   }
// }
//? Count Active filter
//   int getActiveFilterCount(String filterType) {
//     switch (filterType) {
//       case "Range":
//         return rangeCount();
//       case "Gender":
//         return genderList.where((gender) => false /*gender["isChecked"].textValue*/).length;
//       case "Diamond":
//         return diamondList.where((brand) => false /*brand["isChecked"].textValue*/).length;
//
//       case "KT":
//         return ktList.where((kt) => false /*kt["isChecked"].textValue*/).length;
//       case "Delivery":
//         return deliveryList.where((delivery) => false /*delivery["isChecked"].textValue*/).length;
//       case "Production Name":
//         return productionNameList.where((tag) => false /*tag["isChecked"].textValue*/).length;
//       case "Collection":
//         return collectionList.where((collection) => false /*collection["isChecked"].textValue*/).length;
//       default:
//         return 0;
//     }
//   }
}
