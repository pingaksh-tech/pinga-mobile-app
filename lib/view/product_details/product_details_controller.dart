import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/predefine_value_controller.dart';
import '../../data/model/common/splash_model.dart';
import '../../data/model/product/products_model.dart';
import '../../data/model/product/single_product_model.dart';
import '../../data/repositories/cart/cart_repository.dart';
import '../../data/repositories/product/product_repository.dart';
import '../../exports.dart';

class ProductDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  /// DUPLICATE CONTROLLER RESOLVER
  var productIdStack = <String>[].obs;

  ///
  Rx<ScrollController> scrollController = ScrollController().obs;

  RxInt currentPage = 0.obs;
  Rx<PageController> imagesPageController = PageController().obs;

  RxBool isLike = false.obs;

  // RxBool isSizeAvailable = true.obs;
  RxBool isMultipleDiamondSelection = false.obs;

  Rx<DiamondModel> selectedSize = DiamondModel().obs;
  Rx<MetalModel> selectedMetal = MetalModel().obs;
  Rx<DiamondModel> selectedDiamond = DiamondModel().obs;
  RxList<DiamondListModel> diamondList = <DiamondListModel>[].obs;
  RxString selectedRemark = "".obs;
  RxString productCategory = "".obs;
  RxInt quantity = 0.obs;
  RxInt selectedIndex = 0.obs;

  RxDouble height = 200.0.obs;

  Rx<SingleProductModel> productDetailModel = SingleProductModel().obs;
  RxString inventoryId = "".obs;
  RxString remark = "".obs;
  RxString diamondClarity = "".obs;
  RxString sizeId = "".obs;
  RxString metalId = "".obs;
  RxString cartId = "".obs;
  RxString productName = "".obs;
  RxString selectDiamondCart = "".obs;
  num extraMetalPrice = 0;
  num extraMetalWt = 0.0;
  ProductsListType productsListTypeType = ProductsListType.normal;

  RxBool loader = true.obs;

  // RxMap<String, String> diamonds = <String, String>{}.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    if (Get.arguments != null) {
      if (Get.arguments['category'].runtimeType == String) {
        productCategory.value = Get.arguments['category'];
      }
      // if (Get.arguments['isSize'].runtimeType == bool) {
      //   isSizeAvailable.value = Get.arguments['isSize'];
      // }

      if (Get.arguments['isFancy'].runtimeType == bool) {
        isMultipleDiamondSelection.value = Get.arguments['isFancy'];
      }

      if (Get.arguments['inventoryId'].runtimeType == String) {
        inventoryId.value = Get.arguments['inventoryId'];
      }
      if (Get.arguments['cartId'].runtimeType == String) {
        cartId.value = Get.arguments['cartId'];
      }
      if (Get.arguments['name'].runtimeType == String) {
        productName.value = Get.arguments['name'];
      }
      if (Get.arguments['productsListTypeType'].runtimeType == ProductsListType) {
        productsListTypeType = Get.arguments['productsListTypeType'];
      }
      // isLike = Get.arguments['like'] ?? false.obs;

      if (Get.arguments['metalId'].runtimeType == String) {
        metalId.value = Get.arguments['metalId'];
      }
      if (Get.arguments['sizeId'].runtimeType == String) {
        sizeId.value = Get.arguments['sizeId'];
      }

      if (Get.arguments['diamondClarity'].runtimeType == String) {
        diamondClarity.value = Get.arguments['diamondClarity'];
      }
      if (Get.arguments['remark'].runtimeType == String) {
        selectedRemark.value = Get.arguments['remark'];
      }
      if (Get.arguments['quantity'].runtimeType == int) {
        quantity.value = Get.arguments['quantity'];
      }

      if (Get.arguments['diamonds'].runtimeType == List<DiamondListModel>) {
        diamondList.value = Get.arguments['diamonds'];
      }
    }
  }

  /// prefix values
  /// from inventory to product details
  // P-
  /// from cart to product details
  // C-

  @override
  void onReady() {
    super.onReady();

    if (isValEmpty(cartId)) {
      ProductRepository.getSingleProductAPI(inventoryId: inventoryId.value /*.substring(2)*/, sizeId: sizeId.value, metalId: metalId.value, diamondClarity: diamondClarity.value, diamondList: diamondList, loader: loader).then(
        (value) {
          predefinedValue();
          // priceChangeAPI();
        },
      );
    } else {
      CartRepository.getSingleCartItemAPI(cartId: cartId.value /*.substring(2)*/, loader: loader).then(
        (value) {
          predefinedValue();
          // priceChangeAPI();
        },
      );
    }
  }

  /// Product Pricing API
  Future<void> priceChangeAPI() async {
    await ProductRepository.getProductPriceAPI(
      inventoryId: inventoryId.value,
      sizeId: selectedSize.value.id?.value ?? "",
      metalId: selectedMetal.value.id?.value ?? "",
      diamondClarity: isMultipleDiamondSelection.value == false ? selectedDiamond.value.name ?? "" : "",
      diamonds: isMultipleDiamondSelection.value == true
          ? productDetailModel.value.diamonds!.isEmpty
              ? []
              : List.generate(
                  productDetailModel.value.diamonds != null ? productDetailModel.value.diamonds!.length : 0,
                  (index) => {
                    "diamond_clarity": productDetailModel.value.diamonds?[index].diamondClarity?.value ?? "",
                    "diamond_shape": productDetailModel.value.diamonds?[index].diamondShape ?? "",
                    "diamond_size": productDetailModel.value.diamonds?[index].diamondSize ?? "",
                    "diamond_count": productDetailModel.value.diamonds?[index].diamondCount ?? 0,
                    "_id": productDetailModel.value.diamonds?[index].id ?? "",
                  },
                )
          : [],
    ).then((value) {
      // productDetailModel.value.priceBreaking?.total = value?.data?.inventoryTotalPrice;
      quantity.value = value?.data?.cartQty?.quantity ?? 0;
      ProductRepository.getSingleProductAPI(inventoryId: inventoryId.value /*.substring(2)*/, sizeId: sizeId.value, metalId: metalId.value, diamondClarity: diamondClarity.value, diamondList: diamondList).then(
        (value) {
          predefinedValue();
          // priceChangeAPI();
        },
      );
    });
  }

  /// Set Default Select Value Of Product
  Future<void> predefinedValue() async {
    inventoryId.value = productDetailModel.value.inventoryId ?? "";
    int index = 0;
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      List<MetalModel> metalList = preValueCon.metalsList;
      List<CategoryWiseSize> allSizes = preValueCon.categoryWiseSizesList;
      List<DiamondModel> diamondList = preValueCon.diamondsList;

      /// Selected Diamond
      if (diamondList.isNotEmpty) {
        if (productDetailModel.value.diamonds != null && productDetailModel.value.diamonds!.isNotEmpty) {
          index = diamondList.indexWhere((element) => element.name == productDetailModel.value.diamonds?.first.diamondClarity?.value);
        }

        if (index != -1) {
          selectedDiamond.value = diamondList[index];
        } else {
          selectedDiamond.value = diamondList.first;
        }
      } else {
        printData(value: "Diamond list is empty");
        // Handle empty diamondList case here
      }

      /// Selected Metal
      if (metalList.isNotEmpty) {
        index = metalList.indexWhere((element) => element.id?.value == productDetailModel.value.metalId);
        if (index != -1) {
          selectedMetal.value = metalList[index];
        } else {
          selectedMetal.value = metalList.first;
        }
      } else {
        printData(value: "Metal list is empty");
        // Handle empty metalList case here
      }

      /// Selected Size
      if (allSizes.isNotEmpty) {
        RxList<DiamondModel> sizeList = <DiamondModel>[].obs;

        for (var element in allSizes) {
          if (element.id?.value == productCategory.value && element.data != null) {
            sizeList = element.data!.obs;

            index = sizeList.indexWhere((element) => element.id?.value == productDetailModel.value.sizeId);
            if (index != -1) {
              selectedSize.value = sizeList[index];
            } else {
              selectedSize.value = sizeList[0];
            }
          }
        }
      }
      quantity.value = productDetailModel.value.cartQuantity ?? 0;
      isLike.value = productDetailModel.value.isWishList ?? false;
      if (!isValEmpty(cartId)) {
        extraMetalWt = productDetailModel.value.extraMetalWeight ?? 0;
      }
    }
  }

  Timer? cartDebounce;

  void addToCartApi({required int quantity}) {
    if (cartDebounce?.isActive ?? false) cartDebounce?.cancel();
    cartDebounce = Timer(defaultSearchDebounceDuration, () async {
      // Add to cart api
      await CartRepository.addOrUpdateCartApi(
        inventoryId: inventoryId.value,
        quantity: quantity,
        remark: selectedRemark.value,
        extraMetalWeight: extraMetalWt != 0.0 ? extraMetalWt : null,
        metalId: selectedMetal.value.id?.value ?? "",
        sizeId: selectedSize.value.id?.value ?? "",
        diamondClarity: isMultipleDiamondSelection.isFalse ? selectedDiamond.value.shortName ?? "" : "",
        diamonds: isMultipleDiamondSelection.isTrue
            ? List.generate(
                productDetailModel.value.diamonds?.length ?? 0,
                (index) => {
                  "diamond_clarity": productDetailModel.value.diamonds?[index].diamondClarity?.value ?? "",
                  "diamond_shape": productDetailModel.value.diamonds?[index].diamondShape ?? "",
                  "diamond_size": productDetailModel.value.diamonds?[index].diamondSize ?? "",
                  "diamond_count": productDetailModel.value.diamonds?[index].diamondCount ?? 0,
                  "_id": productDetailModel.value.diamonds?[index].id ?? "",
                },
              )
            : null,
      );
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
