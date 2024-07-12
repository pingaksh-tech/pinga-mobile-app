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

class ProductDetailsController extends GetxController {
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

  Rx<SingleProductModel> productDetailModel = SingleProductModel().obs;
  RxString inventoryId = "".obs;
  RxString cartId = "".obs;
  RxString productName = "".obs;
  num extraMetalPrice = 0;
  num extraMetalWt = 0.0;

  RxBool loader = true.obs;

  @override
  void onInit() {
    super.onInit();
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
      // isLike = Get.arguments['like'] ?? false.obs;
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
      ProductRepository.getSingleProductAPI(inventoryId: inventoryId.value /*.substring(2)*/, loader: loader).then(
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
      diamondClarity: isMultipleDiamondSelection.isFalse ? selectedDiamond.value.name ?? "" : "",
      diamonds: isMultipleDiamondSelection.isTrue
          ? List.generate(
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
      productDetailModel.value.priceBreaking?.total = value?.data?.inventoryTotalPrice;
      quantity.value = value?.data?.cartQty?.quantity ?? 0;
    });
  }

  /// Set Default Select Value Of Product
  Future<void> predefinedValue() async {
    int index = 0;
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      List<MetalModel> metalList = preValueCon.metalsList;
      List<CategoryWiseSize> allSizes = preValueCon.categoryWiseSizesList;
      List<DiamondModel> diamondList = preValueCon.diamondsList;

      /// Selected Diamond
      index = diamondList.indexWhere((element) => element.name == productDetailModel.value.diamonds?.first.diamondClarity?.value);
      if (index != -1) {
        selectedDiamond.value = diamondList[index];
      } else {
        selectedDiamond.value = diamondList.first;
      }

      /// Selected Metal
      index = metalList.indexWhere((element) => element.id?.value == productDetailModel.value.metalId);
      if (index != -1) {
        selectedMetal.value = metalList[index];
      } else {
        selectedMetal.value = metalList.first;
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
}
