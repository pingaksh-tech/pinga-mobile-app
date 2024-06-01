import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/data/model/watchlist/watchlist_model.dart';
import 'package:pingaksh_mobile/data/repositories/watchlist/watchlist_repository.dart';

class WatchListController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxBool searchValidation = true.obs;
  RxString searchError = ''.obs;

  RxList<WatchlistModel> watchList = <WatchlistModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    WatchlistRepository.watchlistAPI();
  }
}
