import 'package:get/get.dart';

import '../../../../data/model/sub_category/sub_category_model.dart';
import '../../../../data/model/product/product_model.dart';

class WishlistController extends GetxController {
  Rx<SubCategoryModel> category = SubCategoryModel().obs;
  RxList<ProductListModel> productsList = <ProductListModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    // ProductRepository.getProductsListAPI();
  }
}
