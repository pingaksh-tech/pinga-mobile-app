import 'package:get/get.dart';

import '../../../../data/model/product/variant_product_model.dart';
import '../../../../data/repositories/product/product_repository.dart';

class VariantsTabController extends GetxController {
  RxList<ProductVariant> variantList = <ProductVariant>[].obs;

  @override
  void onReady() async {
    super.onReady();

    /// API CALL
    await ProductRepository.getProductVariantAPI();
  }
}
