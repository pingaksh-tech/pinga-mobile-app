import 'package:get/get.dart';

import '../../data/model/product/product_model.dart';
import '../../data/repositories/product/product_repository.dart';

class ProductController extends GetxController {
  RxBool isLike = false.obs;

  RxString categoryName = "".obs;
  RxBool isProductViewChange = true.obs;

  RxString selectPrice = "".obs;
  RxString selectNewestOrOldest = "".obs;
  RxBool isMostOrder = false.obs;

  RxList<String> sortList = <String>[].obs;
  RxList<ProductListModel> productsList = <ProductListModel>[].obs;
  RxList<ProductListModel> wishlistList = <ProductListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["categoryName"].runtimeType == String) {
        categoryName.value = Get.arguments["categoryName"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    ProductRepository.productListApi();
  }

  final RxList sortWithPriceList = [
    "Price - Low to high",
    "Price - High to Low",
  ].obs;

  final RxList sortWithTimeList = [
    "Newest First",
    "Oldest First",
  ].obs;

  void updateSortingList() {
    sortList.clear();

    if (selectNewestOrOldest.value.isNotEmpty) {
      sortList.add(selectNewestOrOldest.value);
    }

    if (selectPrice.value.isNotEmpty) {
      sortList.add(selectPrice.value);
    }

    if (isMostOrder.value) {
      sortList.add("Most Ordered");
    }
  }
}
