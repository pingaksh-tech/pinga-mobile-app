import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/sub_category/sub_category_model.dart';
import '../../../../data/model/wishlist/wishlist_model.dart';
import '../../../../data/repositories/wishlist/wishlist_repository.dart';

class WishlistController extends GetxController {
  Rx<SubCategoryModel> category = SubCategoryModel().obs;
  RxList<AllWishlistModel> productsList = <AllWishlistModel>[].obs;

  RxBool loader = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;

  @override
  void onReady() async {
    super.onReady();
    await WishlistRepository.getWishlistAPI(loader: loader);
    manageScrollController();
  }

  /// Pagination
  void manageScrollController() async {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.value && paginationLoader.isFalse) {
            /// PAGINATION CALL
            /// GET CATEGORIES API
            WishlistRepository.getWishlistAPI(loader: paginationLoader, isInitial: false);
          }
        }
      },
    );
  }
}
