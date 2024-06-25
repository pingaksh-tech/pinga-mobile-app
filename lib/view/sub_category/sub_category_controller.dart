import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../data/model/latest_products/latest_products_model.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/latest_products/latest_products_repository.dart';
import '../../data/repositories/sub_category/sub_category_repository.dart';

class SubCategoryController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  Timer? searchDebounce;

  String get getSearchText => searchCon.value.text.trim();
  RxString categoryName = "".obs;
  RxString categoryId = "".obs;
  RxBool showCloseButton = false.obs;

  /// SUB CATEGORIES
  RxBool loaderSubCategory = true.obs;
  RxList<SubCategoryModel> subCategoriesList = <SubCategoryModel>[].obs;
  ScrollController scrollControllerSubCategory = ScrollController();
  RxInt pageNumberSubCategory = 1.obs;
  RxInt pageLimitSubCategory = 10.obs;
  RxBool nextPageAvailableSubCategory = true.obs;
  RxBool paginationLoaderSubCategory = false.obs;

  /// LATEST PRODUCTS
  RxBool loaderLatestProd = true.obs;
  RxList<LatestProductsModel> latestProductList = <LatestProductsModel>[].obs;
  ScrollController scrollControllerLatestProd = ScrollController();
  RxInt pageNumberLatestProd = 1.obs;
  RxInt pageLimitLatestProd = 10.obs;
  RxBool nextPageAvailableLatestProd = true.obs;
  RxBool paginationLoaderLatestProd = false.obs;

  /// SCROLL LISTENER
  void manageScrollController() async {
    /// SUB CATEGORIES
    scrollControllerSubCategory.addListener(
      () {
        if (scrollControllerSubCategory.position.maxScrollExtent == scrollControllerSubCategory.position.pixels) {
          if (nextPageAvailableSubCategory.value && paginationLoaderSubCategory.isFalse) {
            /// PAGINATION CALL
            /// GET SUB-CATEGORIES API
            SubCategoryRepository.getSubCategoriesAPI(isInitial: false, loader: paginationLoaderSubCategory, searchText: getSearchText);
          }
        }
      },
    );

    /// LATEST PRODUCTS
    scrollControllerLatestProd.addListener(
      () {
        if (scrollControllerLatestProd.position.maxScrollExtent == scrollControllerLatestProd.position.pixels) {
          if (nextPageAvailableLatestProd.value && paginationLoaderLatestProd.isFalse) {
            /// PAGINATION CALL
            /// GET LATEST PRODUCTS API
            // SubCategoryRepository.getSubCategoriesAPI(isInitial: false, loader: paginationLoaderLatestProd, searchText: getSearchText);
          }
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["categoryName"].runtimeType == String) {
        categoryName.value = Get.arguments["categoryName"] ?? "";
      }
      if (Get.arguments["categoryId"].runtimeType == String) {
        categoryId.value = Get.arguments["categoryId"] ?? "";
      }
    }
  }

  @override
  void onReady() {
    super.onReady();

    /// GET SUB-CATEGORIES API
    SubCategoryRepository.getSubCategoriesAPI(loader: loaderSubCategory, searchText: getSearchText);

    /// GET LATEST PRODUCTS API
    LatestProductsRepository.getLatestProductsAPI(loader: loaderLatestProd);

    /// SCROLL LISTENER INITIALISATION
    manageScrollController();
  }
}
