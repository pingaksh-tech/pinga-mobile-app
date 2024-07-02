import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../controller/predefine_value_controller.dart';
import '../../data/model/product/products_model.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/product/product_repository.dart';
import '../../exports.dart';

class ProductsController extends GetxController {
  RxBool isLoader = false.obs;
  RxBool isSizeAvailable = false.obs;
  RxString categoryId = "".obs;
  RxInt totalCount = 0.obs;

  RxString categoryName = "".obs;
  Rx<SubCategoryModel> subCategory = SubCategoryModel().obs;
  RxBool isProductViewChange = true.obs;

  RxString selectPrice = "".obs;
  RxString selectNewestOrOldest = "".obs;
  RxBool isMostOrder = false.obs;
  RxBool isDisableButton = true.obs;

  RxList<String> sortList = <String>[].obs;
  RxList<InventoryModel> inventoryProductList = <InventoryModel>[].obs;
  RxList<InventoryModel> wishlistList = <InventoryModel>[].obs;

  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 10.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  RxBool loader = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["category"].runtimeType == SubCategoryModel) {
        subCategory.value = Get.arguments["category"];
      }
      if (Get.arguments["categoryId"].runtimeType == String) {
        categoryId.value = Get.arguments["categoryId"];
      }
      if (Get.arguments["watchlistName"].runtimeType == String) {
        categoryName.value = Get.arguments["watchlistName"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    ProductRepository.getPredefineValueAPI();
    preValueAvailable();
    printOkStatus(subCategory.value.id);
    ProductRepository.getFilterProductsListAPI(categoryId: categoryId.value, productsListType: ProductsListType.normal, subCategoryId: subCategory.value.id ?? "");
  }

  final RxList sortWithPriceList = [
    "Price - Low to high/1",
    "Price - High to Low/-1",
  ].obs;

  final RxList sortWithTimeList = [
    "Newest First/1",
    "Oldest First/-1",
  ].obs;

  void updateSortingList() {
    sortList.clear();

    if (selectNewestOrOldest.value.isNotEmpty) {
      sortList.add(selectNewestOrOldest.value);
    }

    if (selectPrice.value.isNotEmpty) {
      sortList.add(selectPrice.value);
    }

    if (isMostOrder.value) {
      sortList.add("Most Ordered");
    }
  }

  Future<void> preValueAvailable() async {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();

      for (var element in preValueCon.categoryWiseSizesList) {
        if (element.id?.value == subCategory.value.id) {
          isSizeAvailable.value = true;
          break;
        }
      }
    }
  }
}
