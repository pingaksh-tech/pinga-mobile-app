import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/latest_products/latest_products_model.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/repositories/latest_products/latest_products_repository.dart';
import '../../data/repositories/sub_category/sub_category_repository.dart';
import '../../exports.dart';

class SubCategoryController extends GetxController with GetTickerProviderStateMixin {
  /// CATEGORY DETAILS
  RxString categoryName = "".obs;
  RxString categoryId = "".obs;

  /// TAB CONTROLLER AND LISTENERS
  late TabController tabController;

  void tabListerFunction() {
    tabController.addListener(
      () {
        if (tabController.indexIsChanging) {
          // printOkStatus("tab is animating. from active (getting the index) to inactive(getting the index) ");
        } else {
          /// TAB CHANGE
          switch (tabController.index) {
            case 0:
              printOkStatus("===>${tabController.index}");

            /// SUB CATEGORIES

            case 1:
              printWarning("===>${tabController.index}");
              searchFocusNode.value.unfocus();

            /// LATEST PRODUCTS
          }
        }
      },
    );
  }

  /// SEARCH FILED
  Rx<TextEditingController> searchTEC = TextEditingController().obs;
  Rx<FocusNode> searchFocusNode = FocusNode().obs;
  Timer? searchDebounce;

  String get getSearchText => searchTEC.value.text.trim();
  RxBool showCloseButton = false.obs;

  /// SUB CATEGORIES
  RxBool loaderSubCategory = true.obs;
  RxList<SubCategoryModel> subCategoriesList = <SubCategoryModel>[].obs;
  ScrollController scrollControllerSubCategory = ScrollController();
  RxInt pageNumberSubCategory = 1.obs;
  RxInt pageLimitSubCategory = 50.obs;
  RxBool nextPageAvailableSubCategory = true.obs;
  RxBool paginationLoaderSubCategory = false.obs;

  /// LATEST PRODUCTS
  RxBool loaderLatestProd = true.obs;
  RxList<LatestProductsModel> latestProductList = <LatestProductsModel>[].obs;
  ScrollController scrollControllerLatestProd = ScrollController();
  RxInt pageNumberLatestProd = 1.obs;
  RxInt pageLimitLatestProd = 50.obs;
  RxBool nextPageAvailableLatestProd = true.obs;
  RxBool paginationLoaderLatestProd = false.obs;

  /// SCROLL LISTENER
  void manageScrollController() async {
    /// SUB CATEGORIES
    scrollControllerSubCategory.addListener(
      () async {
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
            LatestProductsRepository.getLatestProductsAPI(isInitial: false, loader: paginationLoaderLatestProd);
          }
        }
      },
    );
  }

  RxBool isPlatinumBrand = false.obs;
  @override
  void onInit() {
    super.onInit();

    /// GET ARGUMENTS
    if (Get.arguments != null) {
      if (Get.arguments["categoryName"].runtimeType == String) {
        categoryName.value = Get.arguments["categoryName"] ?? "";
      }
      if (Get.arguments["categoryId"].runtimeType == String) {
        categoryId.value = Get.arguments["categoryId"] ?? "";
      }
      if (Get.arguments["isPlatinumBrand"].runtimeType == bool) {
        isPlatinumBrand.value = Get.arguments["isPlatinumBrand"] ?? false;
      }
    }

    /// TAB CONTROLLER INITIALISATION & ADD ITS LISTENER
    tabController = TabController(length: 2, vsync: this);
    tabListerFunction();
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

  @override
  void onClose() {
    tabController.dispose();
  }
}
