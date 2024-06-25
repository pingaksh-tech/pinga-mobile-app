import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/banner/banner_model.dart';
import '../../data/model/category/category_model.dart';
import '../../data/repositories/banner/banner_repository.dart';
import '../../data/repositories/category/category_repository.dart';

class HomeController extends GetxController {
  RxBool bannerLoader = true.obs;
  RxList<BannerModel> bannersList = <BannerModel>[].obs;

  RxBool categoryLoader = true.obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 50.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET CATEGORIES API
            CategoryRepository.getCategoriesAPI(isInitial: false, loader: paginationLoader);
          }
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();

    /// GET BANNERS API
    BannerRepository.getBannersAPI(isLoader: bannerLoader);

    /// GET CATEGORIES API
    CategoryRepository.getCategoriesAPI(loader: categoryLoader);

    /// SCROLL LISTENER INITIALISATION
    manageScrollController();
  }
}
