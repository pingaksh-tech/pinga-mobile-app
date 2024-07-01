import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/cart/retailer_model.dart';
import '../../../../data/repositories/cart/cart_repository.dart';

class CheckoutController extends GetxController {
  Rx<TextEditingController> retailerCon = TextEditingController().obs;

  /// Retailer Listing
  RxList<RetailerModel> retailerList = <RetailerModel>[].obs;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxInt itemLimit = 20.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoader = false.obs;
  @override
  void onReady() {
    super.onReady();
    CartRepository.getRetailerApi(loader: isLoading);
  }
}
