import 'package:get/get.dart';

import '../data/model/cart/product_detail_model.dart';
import '../data/model/product/product_colors_model.dart';
import '../data/model/product/product_diamond_model.dart';
import '../data/model/product/product_size_model.dart';
import '../data/repositories/cart/cart_repository.dart';
import '../data/repositories/product/product_repository.dart';

class DialogController extends GetxController {
  RxList<SizeModel> productSizeList = <SizeModel>[].obs;
  RxList<ColorModel> productColorList = <ColorModel>[].obs;
  RxList<Diamond> productDiamondList = <Diamond>[].obs;
  RxList<ProductDetail> cartProductDetailList = <ProductDetail>[].obs;

  @override
  void onReady() async {
    super.onReady();

    await ProductRepository.getProductSizeAPI();
    await ProductRepository.getProductColorAPI();
    await ProductRepository.getProductDiamondAPI();
    await CartRepository.getProductDetailAPI();
  }
}
