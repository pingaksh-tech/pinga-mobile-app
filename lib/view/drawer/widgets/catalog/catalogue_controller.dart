import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/model/home/catalogue_model.dart';
import '../../../../data/repositories/home/catalogue_repository.dart';

class CatalogueController extends GetxController {
  RxList<Catalogue> catalogueList = <Catalogue>[].obs;

  RxBool loader = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;

  @override
  void onReady() {
    super.onReady();
    CatalogueRepository.getCatalogue(loader: loader);
    manageScrollController();
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET CATALOGUE API
            CatalogueRepository.getCatalogue(loader: paginationLoader, isInitial: false);
          }
        }
      },
    );
  }
}
