import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/model/home/catalogue_model.dart';
import '../../../../data/repositories/home/catalogue_repository.dart';

class CatalogueController extends GetxController {
  RxList<Catalogue> catalogueList = <Catalogue>[].obs;

  RxBool loader = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 10.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;

  @override
  void onReady() {
    super.onReady();
    CatalogueRepository.getCatalogue(loader: loader);
  }
}
