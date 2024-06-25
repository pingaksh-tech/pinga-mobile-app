import 'package:get/get.dart';

import '../../controller/predefine_value_controller.dart';
import '../../data/model/sub_category/sub_category_model.dart';
import '../../data/model/product/product_model.dart';
import '../../data/repositories/product/product_repository.dart';
import '../../exports.dart';

class ProductController extends GetxController {
  RxBool isLike = false.obs;
  RxBool isSizeAvailable = true.obs;

  RxString categoryName = "".obs;
  Rx<SubCategoryModel> category = SubCategoryModel().obs;
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
      if (Get.arguments["category"].runtimeType == SubCategoryModel) {
        category.value = Get.arguments["category"];
      }
      if (Get.arguments["watchlistName"].runtimeType == String) {
        categoryName.value = Get.arguments["watchlistName"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    ProductRepository.productListApi();
    preValueAvailable();
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

  Future<void> preValueAvailable() async {
    if (isRegistered<PreValueController>()) {
      final PreValueController preValueCon = Get.find<PreValueController>();

      await preValueCon.checkHasPreValue(category.value.id ?? '', type: SelectableItemType.size.slug).then(
        (value) {
          isSizeAvailable.value = value.isNotEmpty;
        },
      );
    }
  }
}
