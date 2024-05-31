import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum FilterType { range, available, gender, brand, kt, delivery, tag, collection, complexity, subComplexity, bestSeller, latestDesign }

class FilterController extends GetxController {
  RxDouble minMetalWt = 0.0.obs;
  RxDouble maxMetalWt = 12.0.obs;
  RxDouble minDiamondWt = 0.0.obs;
  RxDouble maxDiamondWt = 50.0.obs;
  RxString selectSeller = "".obs;
  RxString selectLatestDesign = "".obs;

  Rx<TextEditingController> itemNameCon = TextEditingController().obs;
  RxList<String> filterTypeList = [
    "Range",
    "Available",
    "Gender",
    "Brand",
    "KT",
    "Delivery",
    "Tag",
    "Collection",
    "Complexity",
    "Sub Complexity",
    "Best Sellers",
    "Latest Design",
  ].obs;

  RxString selectFilter = "Range".obs;
  Rx<FilterType> filterType = FilterType.range.obs;

  void filterCategoryType({required int index}) {
    switch (index) {
      case 0:
        filterType.value = FilterType.range;
        break;
      case 1:
        filterType.value = FilterType.available;
        break;
      case 2:
        filterType.value = FilterType.gender;
        break;
      case 3:
        filterType.value = FilterType.brand;
        break;
      case 4:
        filterType.value = FilterType.kt;
        break;
      case 5:
        filterType.value = FilterType.delivery;
        break;
      case 6:
        filterType.value = FilterType.tag;
        break;
      case 7:
        filterType.value = FilterType.collection;
        break;
      case 8:
        filterType.value = FilterType.complexity;
        break;
      case 9:
        filterType.value = FilterType.subComplexity;
        break;
      case 10:
        filterType.value = FilterType.bestSeller;
        break;
      case 11:
        filterType.value = FilterType.latestDesign;
        break;
    }
  }

  final List<Map<String, dynamic>> brandList = [
    {"title": "OroKraft", "isChecked": false.obs},
    {"title": "Rare Solitaire", "isChecked": false.obs},
    {"title": "Platinum", "isChecked": false.obs},
    {"title": "Rang Tarang", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> stockAvailableList = [
    {"title": "In Stock Available Only", "isChecked": false.obs},
    {"title": "Family Products Only", "isChecked": false.obs},
    {"title": "Wear It Items Only", "isChecked": false.obs},
    {"title": "Try On Items Only", "isChecked": false.obs},
  ];
  final List<Map<String, dynamic>> genderList = [
    {"title": "Male", "isChecked": false.obs},
    {"title": "Female", "isChecked": false.obs},
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
  final List<Map<String, dynamic>> tagList = [
    {"title": "Anantam", "isChecked": false.obs},
    {"title": "Celebration", "isChecked": false.obs},
    {"title": "Tvamev", "isChecked": false.obs},
    {"title": "Rista", "isChecked": false.obs},
    {"title": "Shine Forever", "isChecked": false.obs},
    {"title": "Ghoomar", "isChecked": false.obs},
  ];
  final List<Map<String, dynamic>> complexityList = [
    {"title": "Band (3)", "isChecked": false.obs},
    {"title": "Broad (4)", "isChecked": false.obs},
    {"title": "Classic (1)", "isChecked": false.obs},
    {"title": "Dual Shank (1)", "isChecked": false.obs},
    {"title": "Regular (6)", "isChecked": false.obs},
    {"title": "Split Shank (5)", "isChecked": false.obs},
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
  final List<Map<String, dynamic>> subComplexityList = [
    {"title": "Beads (3)", "isChecked": false.obs},
    {"title": "Cluster (4)", "isChecked": false.obs},
    {"title": "Promise (1)", "isChecked": false.obs},
    {"title": "Hero (3)", "isChecked": false.obs},
    {"title": "Fancy (2)", "isChecked": false.obs},
    {"title": "Floral (1)", "isChecked": false.obs},
    {"title": "Cut Out (2)", "isChecked": false.obs},
  ];
  final RxList<String> bestSellerList = [
    "Sold in your Store",
    "Sold in your City",
    "Sold in your State",
    "Sold in all India",
  ].obs;
  final RxList<String> latestDesignList = [
    "Last 30 days",
    "Last 90 days",
    "Last 180 days",
  ].obs;
  void clearAllFilters() {
    minMetalWt.value = 0.0;
    maxMetalWt.value = 12.0;
    for (var available in stockAvailableList) {
      available["isChecked"].value = false;
    }
    for (var gender in genderList) {
      gender["isChecked"].value = false;
    }
    for (var brand in brandList) {
      brand["isChecked"].value = false;
    }
    for (var kt in ktList) {
      kt["isChecked"].value = false;
    }
    for (var delivery in deliveryList) {
      delivery["isChecked"].value = false;
    }
    for (var tag in tagList) {
      tag["isChecked"].value = false;
    }
    for (var collection in collectionList) {
      collection["isChecked"].value = false;
    }
    for (var complexity in complexityList) {
      complexity["isChecked"].value = false;
    }
    for (var subComplexity in subComplexityList) {
      subComplexity["isChecked"].value = false;
    }
    selectSeller.value = "";
    selectLatestDesign.value = "";
  }

  int getActiveFilterCount(String filterType) {
    switch (filterType) {
      case "Range":
        return ((minMetalWt.value > 0.0 || maxMetalWt.value < 12.0 || minDiamondWt.value > 0.0 || maxDiamondWt.value > 50.0 ? 1 : 0));
      case "Gender":
        return genderList.where((gender) => gender["isChecked"].value).length;
      case "Brand":
        return brandList.where((brand) => brand["isChecked"].value).length;
      case "Available":
        return stockAvailableList.where((item) => item["isChecked"].value).length;
      case "KT":
        return ktList.where((kt) => kt["isChecked"].value).length;
      case "Delivery":
        return deliveryList.where((delivery) => delivery["isChecked"].value).length;
      case "Tag":
        return tagList.where((tag) => tag["isChecked"].value).length;
      case "Collection":
        return collectionList.where((collection) => collection["isChecked"].value).length;
      case "Complexity":
        return complexityList.where((complexity) => complexity["isChecked"].value).length;
      case "Sub Complexity":
        return subComplexityList.where((subComplexity) => subComplexity["isChecked"].value).length;
      default:
        return 0;
    }
  }
}
