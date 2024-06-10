import 'package:get/get.dart';

import '../../../../data/model/category/category_model.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../data/repositories/product/product_repository.dart';

class WishlistController extends GetxController {
  Rx<CategoryModel> category = CategoryModel().obs;
  RxList<ProductListModel> productsList = <ProductListModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    ProductRepository.productListApi(isWishlist: true);
  }
}
