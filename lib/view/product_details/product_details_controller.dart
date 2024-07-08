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
  Rx<ScrollController> scrollController = ScrollController().obs;

  RxInt currentPage = 0.obs;
  Rx<PageController> imagesPageController = PageController().obs;

  RxBool isLike = false.obs;
  RxBool isSize = true.obs;
  RxBool isFancy = false.obs;

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
      if (Get.arguments['isSize'].runtimeType == bool) {
        isSize.value = Get.arguments['isSize'];
      }

      if (Get.arguments['isFancy'].runtimeType == bool) {
        isFancy.value = Get.arguments['isFancy'];
      }

      if (Get.arguments['inventoryId'].runtimeType == String) {
        inventoryId.value = Get.arguments['inventoryId'];
      }
      if (Get.arguments['cartId'].runtimeType == String) {
        cartId.value = Get.arguments['cartId'];
      }
      if (Get.arguments['name'].runtimeType == String) {
        productName.value = Get.arguments['name'];
        isLike = Get.arguments['like'] ?? false.obs;
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (isValEmpty(cartId)) {
      ProductRepository.getSingleProductAPI(inventoryId: inventoryId.value, loader: loader).then(
        (value) {
          predefinedValue();
          // priceChangeAPI();
        },
      );
    } else {
      CartRepository.getSingleCartItemAPI(cartId: cartId.value, loader: loader).then(
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
      diamondClarity: isFancy.isFalse ? selectedDiamond.value.name ?? "" : "",
      diamonds: isFancy.isTrue
          ? List.generate(
              productDetailModel.value.diamonds != null ? productDetailModel.value.diamonds!.length : 0,
              (index) => {
                "diamond_clarity": diamondList[index].diamondClarity?.value ?? "",
                "diamond_shape": diamondList[index].diamondShape ?? "",
                "diamond_size": diamondList[index].diamondSize ?? "",
                "diamond_count": diamondList[index].diamondCount ?? 0,
                "_id": diamondList[index].id ?? "",
              },
            )
          : [],
    ).then((value) {
      productDetailModel.value.priceBreaking?.total = value?.data?.inventoryTotalPrice?.value ?? 0;
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
      if (!isValEmpty(cartId)) {
        quantity.value = productDetailModel.value.cartQuantity ?? 0;
        isLike.value = productDetailModel.value.isWishList ?? false;
        extraMetalWt = productDetailModel.value.extraMetalWeight ?? 0;
      }
    }
  }
}
