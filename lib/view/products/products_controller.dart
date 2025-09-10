import 'dart:async';

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

  RxInt totalProducts = 0.obs;

  /// SEARCH FIELD
  Rx<TextEditingController> searchTEC = TextEditingController().obs;
  Rx<FocusNode> searchFocusNode = FocusNode().obs;
  Timer? searchDebounce;

  String get getSearchText => searchTEC.value.text.trim();
  RxBool showCloseButton = false.obs;

  /// PAGINATION
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
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

  RxBool isPlatinumBrand = false.obs;

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

      if (Get.arguments["isPlatinumBrand"].runtimeType == bool) {
        isPlatinumBrand.value = Get.arguments["isPlatinumBrand"] ?? false;
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

  @override
  void onClose() {
    searchDebounce?.cancel();
    searchTEC.value.dispose();
    searchFocusNode.value.dispose();
    super.onClose();
  }

  /// API
  Future<void> getProductList({RxBool? loader}) async {
    final FilterController con = Get.find<FilterController>();

    /// GET ALL PRODUCTS
    await ProductRepository.getFilterProductsListAPI(
      loader: loader,
      productsListType: productListType.value,
      watchListId: watchlistId.value,
      categoryId: categoryId.value,
      subCategoryId: subCategory.value.id ?? "",
      inStock: filterCon.isAvailable.value,
      searchText: getSearchText,

      /// Filter
      minMetal: con.minMetalWt.value,
      retailerModel: con.selectedRetailer?.value,
      maxMetal: con.maxMetalWt.value,
      minDiamond: con.minDiamondWt.value,
      maxDiamond: con.maxDiamondWt.value,
      minMrp: con.selectMrp.value.label == "customs".obs ? int.parse(con.mrpFromCon.value.text) : con.selectMrp.value.min?.value,
      maxMrp: con.selectMrp.value.label == "customs".obs ? int.parse(con.mrpToCon.value.text) : con.selectMrp.value.max?.value,
      genderList: con.selectedGender,
      diamondList: con.selectedDiamonds,
      ktList: con.selectedKt,
      deliveryList: con.selectedDelivery,
      productionNameList: con.selectedProductNames,
      collectionList: con.selectedCollections,
      sortBy: [
        if (selectPrice.value.isNotEmpty) "inventory_total_price:${selectPrice.value.split("/").last}",
        if (!isValEmpty(selectNewestOrOldest.value)) "createdAt:${selectNewestOrOldest.value.split("/").last}",
      ],
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
    final FilterController con = Get.find<FilterController>();

    ///  PRODUCTS
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == /*/ 1.5 <*/ scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// GET PRODUCTS API
            await ProductRepository.getFilterProductsListAPI(
              loader: paginationLoader,
              productsListType: productListType.value,
              watchListId: watchlistId.value,
              categoryId: categoryId.value,
              subCategoryId: subCategory.value.id ?? "",
              isInitial: false,
              searchText: getSearchText,

              /// Filter
              minMetal: con.minMetalWt.value,
              maxMetal: con.maxMetalWt.value,
              minDiamond: con.minDiamondWt.value,
              maxDiamond: con.maxDiamondWt.value,
              retailerModel: con.selectedRetailer?.value,
              minMrp: con.selectMrp.value.label == "customs".obs ? int.parse(con.mrpFromCon.value.text) : con.selectMrp.value.min?.value,
              maxMrp: con.selectMrp.value.label == "customs".obs ? int.parse(con.mrpToCon.value.text) : con.selectMrp.value.max?.value,
              inStock: con.isAvailable.value,
              genderList: con.selectedGender,
              diamondList: con.selectedDiamonds,
              ktList: con.selectedKt,
              deliveryList: con.selectedDelivery,
              productionNameList: con.selectedProductNames,
              collectionList: con.selectedCollections,
              sortBy: [
                if (selectPrice.value.isNotEmpty) "inventory_total_price:${selectPrice.value.split("/").last}",
                if (!isValEmpty(selectNewestOrOldest.value)) "createdAt:${selectNewestOrOldest.value.split("/").last}",
              ],
            );
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
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();

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
