import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/model/product/products_model.dart';
import '../../../../data/model/watchlist/watchlist_model.dart';
import '../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../exports.dart';

class AddWatchListController extends GetxController {
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValidation = true.obs;
  RxString nameError = ''.obs;

  RxBool disableButton = true.obs;
  RxBool loader = true.obs;

  Rx<WatchList> watchlistId = WatchList().obs;
  RxList<WatchList> selectedList = <WatchList>[].obs;

  RxString inventoryId = "".obs;
  RxString sizeId = "".obs;
  RxString metalId = "".obs;
  RxInt quantity = 0.obs;
  RxString diamondClarity = "".obs;
  RxBool isMultiDiamond = false.obs;
  List<DiamondListModel> diamonds = [];

  Rx<WatchListType> watchListType = WatchListType.normal.obs;

  List<String> cartIds = [];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['inventoryId'].runtimeType == String) {
        inventoryId.value = Get.arguments['inventoryId'];
      }
      if (Get.arguments['quantity'].runtimeType == int) {
        quantity.value = Get.arguments['quantity'];
      }
      if (Get.arguments['sizeId'].runtimeType == String) {
        sizeId.value = Get.arguments['sizeId'];
      }
      if (Get.arguments['metalId'].runtimeType == String) {
        metalId.value = Get.arguments['metalId'];
      }
      if (Get.arguments['diamondClarity'].runtimeType == String) {
        diamondClarity.value = Get.arguments['diamondClarity'];
      }
      if (Get.arguments['diamond'].runtimeType == List<DiamondListModel>) {
        diamonds = Get.arguments['diamond'];
      }
      if (Get.arguments['isMultiDiamond'].runtimeType == bool) {
        isMultiDiamond.value = Get.arguments['isMultiDiamond'];
      }
      if (Get.arguments['watchListType'].runtimeType == WatchListType) {
        watchListType.value = Get.arguments['watchListType'];
      }
     
      if (Get.arguments['cartIds'].runtimeType == List<String>) {
        cartIds = Get.arguments['cartIds'];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();

    /// GET WATCHLIST
    WatchListRepository.getWatchListAPI(loader: loader);
  }

  void checkDisableButton() {
    if (watchlistId.value.id != null && watchlistId.value.id!.isNotEmpty || nameCon.value.text.isNotEmpty) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }
}
