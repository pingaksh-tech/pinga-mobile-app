import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/model/watchlist/watchlist_model.dart';
import '../../../../data/repositories/watchlist/watchlist_repository.dart';

class AddWatchlistController extends GetxController {
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
  RxString diamond = "".obs;

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
      if (Get.arguments['diamond'].runtimeType == String) {
        diamond.value = Get.arguments['diamond'];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();

    /// GET WATCHLIST
    WatchlistRepository.getWatchlistAPI(loader: loader, isPullToRefresh: true);
  }

  void checkDisableButton() {
    if (watchlistId.value.id != null && watchlistId.value.id!.isNotEmpty || nameCon.value.text.isNotEmpty) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }
}
