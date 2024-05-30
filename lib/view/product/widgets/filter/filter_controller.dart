import 'package:get/get.dart';

enum FilterType { range, gender, brand, jewellery }

class FilterController extends GetxController {
  RxDouble minPrice = 5000.0.obs;
  RxDouble maxPrice = 10000.0.obs;

  RxList<String> filterTypeList = ["Range", "Gender", "Brand", "Jewellery Types"].obs;

  RxString selectFilter = "Range".obs;
  Rx<FilterType> filterType = FilterType.range.obs;

  void filterCategoryType({required int index}) {
    switch (index) {
      case 0:
        filterType.value = FilterType.range;
        break;
      case 1:
        filterType.value = FilterType.gender;
        break;
      case 2:
        filterType.value = FilterType.brand;
        break;
      case 3:
        filterType.value = FilterType.jewellery;
        break;
    }
  }

  final List<Map<String, dynamic>> brandList = [
    {"title": "OroKraft", "isChecked": false.obs},
    {"title": "Rare Solitaire", "isChecked": false.obs},
    {"title": "Platinum", "isChecked": false.obs},
    {"title": "Rang Tarang", "isChecked": false.obs},
    {"title": "Kalayan", "isChecked": false.obs},
  ];

  final List<Map<String, dynamic>> jewelryTypeList = [
    {"title": "Diamond", "isChecked": false.obs},
    {"title": "Gold", "isChecked": false.obs},
  ];
  final List<Map<String, dynamic>> genderList = [
    {"title": "Male", "isChecked": false.obs},
    {"title": "Female", "isChecked": false.obs},
  ];
  void clearAllFilters() {
    minPrice.value = 5000.0;
    maxPrice.value = 10000.0;
    for (var gender in genderList) {
      gender["isChecked"].value = false;
    }
    for (var brand in brandList) {
      brand["isChecked"].value = false;
    }
    for (var jewelry in jewelryTypeList) {
      jewelry["isChecked"].value = false;
    }
  }

  bool isFilterActive(String filterType) {
    switch (filterType) {
      case "Range":
        return minPrice.value > 5000.0 || maxPrice.value < 10000.0;
      case "Gender":
        return genderList.any((gender) => gender["isChecked"].value);

      case "Brand":
        return brandList.any((brand) => brand["isChecked"].value);
      case "Jewellery Types":
        return jewelryTypeList.any((jewelry) => jewelry["isChecked"].value);
      default:
        return false;
    }
  }
}
