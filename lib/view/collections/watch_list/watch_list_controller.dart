import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/watchlist/watchlist_model.dart';
import '../../../data/repositories/watchlist/watchlist_repository.dart';

class WatchListController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;
  RxBool searchValidation = true.obs;
  RxString searchError = ''.obs;

  RxList<WatchList> watchList = <WatchList>[].obs;
  RxBool showCloseButton = false.obs;

  RxBool loader = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  @override
  void onReady() {
    super.onReady();
    WatchListRepository.getWatchListAPI(searchText: searchCon.value.text.trim(), loader: loader);
  }

  @override
  void onInit() {
    super.onInit();
    manageScrollController();
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET WatchList API
            WatchListRepository.getWatchListAPI(
              searchText: searchCon.value.text.trim(),
              loader: paginationLoader,
              isInitial: false,
            );
          }
        }
      },
    );
  }

  /// Download watchlist rows
// RxList<List<dynamic>> rows = <List<dynamic>>[].obs;
// RxList<dynamic> row = [].obs;
//
// @override
// void onInit() {
//   super.onInit();
//   row.addAll(["Id", "Name", "No of items", "Created by"]);
// }
}
