import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/data/model/watchlist/watchlist_model.dart';
import 'package:pingaksh_mobile/data/repositories/watchlist/watchlist_repository.dart';

class AddWatchlistController extends GetxController {
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValidation = true.obs;
  RxString nameError = ''.obs;

  RxBool select = false.obs;
  RxBool disableButton = true.obs;

  RxList<WatchlistModel> watchList = <WatchlistModel>[].obs;
  RxList<WatchlistModel> selectedList = <WatchlistModel>[].obs;

  bool validate() {
    if (nameCon.value.text.trim().isEmpty) {
      nameValidation.value = false;
      nameError.value = 'Enter watchlist name';
    } else {
      nameValidation.value = true;
    }

    return nameValidation.isTrue;
  }

  void checkDisableButton() {
    if (selectedList.isNotEmpty || nameCon.value.text.isNotEmpty) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }

  @override
  void onReady() {
    super.onReady();
    WatchlistRepository.watchlistAPI();
  }
}
