import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/predefine_value_controller.dart';
import '../../data/model/category/category_model.dart';
import '../../data/model/product/products_model.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/product/product_repository.dart';
import '../../exports.dart';
import '../home/home_controller.dart';
import 'widgets/filter/filter_controller.dart';

class ProductsController extends GetxController {
  RxBool isLoader = false.obs;
  // RxBool isSizeAvailable = false.obs;
  RxString categoryId = "".obs;

  Rx<CategoryModel> currentCategory = CategoryModel().obs;
  // RxBool isFancyDiamond = false.obs;

  RxString categoryName = "".obs;
  Rx<SubCategoryModel> subCategory = SubCategoryModel().obs;
  RxBool isProductViewChange = true.obs;

  RxString selectPrice = "".obs;
  RxString selectNewestOrOldest = "".obs;
  RxBool isMostOrder = false.obs;

  RxList<String> sortList = <String>[].obs;
  RxList<InventoryModel> inventoryProductList = <InventoryModel>[].obs;

  Rx<ProductsListType> productListType = ProductsListType.normal.obs;
  RxString watchlistId = "".obs;

  /// PAGINATION
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 10.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  RxBool loader = true.obs;

  final HomeController homeCon = Get.find<HomeController>();
  final FilterController filterCon = Get.find<FilterController>();

  final RxList sortWithPriceList = [
    "Price - Low to high/1",
    "Price - High to Low/-1",
  ].obs;

  final RxList sortWithTimeList = [
    "Newest First/1",
    "Oldest First/-1",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    filterCon.clearAllFilters();

    if (Get.arguments != null) {
      if (Get.arguments["category"].runtimeType == SubCategoryModel) {
        subCategory.value = Get.arguments["category"];
        filterCon.subCategoryId = subCategory.value.id ?? "";
      }
      if (Get.arguments["categoryId"].runtimeType == String) {
        categoryId.value = Get.arguments["categoryId"];
        filterCon.categoryId = categoryId.value;
      }
      if (Get.arguments["watchlistName"].runtimeType == String) {
        categoryName.value = Get.arguments["watchlistName"];
      }
      if (Get.arguments["type"].runtimeType == ProductsListType) {
        productListType.value = Get.arguments["type"];
        filterCon.productsListType = Get.arguments["type"];
      }
      if (Get.arguments["watchlistId"].runtimeType == String) {
        watchlistId.value = Get.arguments["watchlistId"];
        filterCon.watchlistId = Get.arguments["watchlistId"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    ProductRepository.getPredefineValueAPI();

    getProductList(loader: loader);
    manageScrollController();
  }

  /// API
  Future<void> getProductList({RxBool? loader}) async {
    /// GET ALL PRODUCTS
    await ProductRepository.getFilterProductsListAPI(
      loader: loader,
      productsListType: productListType.value,
      watchListId: watchlistId.value,
      categoryId: categoryId.value,
      subCategoryId: subCategory.value.id ?? "",
    );

    // int index = homeCon.categoriesList.indexWhere((element) => element.id == categoryId.value);
    // if (index != -1) {
    //   currentCategory.value = homeCon.categoriesList[index];

    //   if (currentCategory.value.id == "667cbcc3dd04772674c966c4") {
    //     isFancyDiamond.value = true;
    //   }
    // }
    preValueAvailable();
  }

  void manageScrollController() {
    ///  PRODUCTS
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// GET PRODUCTS API
            await ProductRepository.getFilterProductsListAPI(
                loader: paginationLoader,
                productsListType: productListType.value,
                watchListId: watchlistId.value,
                categoryId: categoryId.value,
                subCategoryId: subCategory.value.id ?? "",
                isInitial: false);
          }
        }
      },
    );
  }

  void updateSortingList() {
    sortList.clear();

    if (selectNewestOrOldest.value.isNotEmpty) {
      sortList.add(selectNewestOrOldest.value);
    }

    if (selectPrice.value.isNotEmpty) {
      sortList.add(selectPrice.value);
    }

    /*  if (isMostOrder.value) {
      sortList.add("Most Ordered");
    } */
  }

  Future<void> preValueAvailable() async {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon =
          Get.find<PreDefinedValueController>();

      for (var element in preValueCon.categoryWiseSizesList) {
        if (productListType.value == ProductsListType.normal) {
          if (element.id?.value == subCategory.value.id) {
            // isSizeAvailable.value = true;
            break;
          }
        } else {
          for (var e in inventoryProductList) {
            if (element.id?.value == e.subCategoryId) {
              // isSizeAvailable.value = true;
              break;
            }
          }
        }
      }
    }
  }
}
