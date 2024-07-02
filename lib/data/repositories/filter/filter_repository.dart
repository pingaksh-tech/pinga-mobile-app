import 'package:get/get.dart';

import '../../../view/products/widgets/filter/filter_controller.dart';
import '../../model/filter/gender_model.dart';
import '../../model/filter/stock_available_model.dart';

class FilterRepository {
  static Map<String, dynamic> availableList = {
    "success": true,
    "message": "Stock fetched successfully",
    "data": {
      "products": [
        {"title": "In Stock Available Only", "isChecked": false},
      ],
    }
  };

  static Map<String, dynamic> genderList = {
    "success": true,
    "message": "Stock fetched successfully",
    "data": {
      "products": [
        {"title": "Male", "isChecked": false},
        {"title": "Female", "isChecked": false}
      ]
    }
  };

  /// ***********************************************************************************
  ///                                     GET PRODUCT LIST
  /// ***********************************************************************************
  static Future<void> stockAvailableList() async {
    final FilterController filterCon = Get.find<FilterController>();
    GetStockAvailableModel model = GetStockAvailableModel.fromJson(availableList /*response*/);
    filterCon.availableList.value = model.data?.products ?? [];
  }

  /// ***********************************************************************************
  ///                                     GET PRODUCT LIST
  /// ***********************************************************************************
  static Future<void> genderListAPI() async {
    final FilterController filterCon = Get.find<FilterController>();
    GetGenderModel model = GetGenderModel.fromJson(genderList);
    filterCon.genderList.value = model.data?.products ?? [];
  }
}
