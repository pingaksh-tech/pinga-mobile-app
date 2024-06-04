import 'package:get/get.dart';
import 'package:pingaksh_mobile/data/model/product/variant_product_model.dart';
import 'package:pingaksh_mobile/data/repositories/product/product_repository.dart';

class VariantsController extends GetxController {
  RxList<ProductVariant> variantList = <ProductVariant>[].obs;
  RxInt quantity = 0.obs;

  RxString color = "-".obs;

  RxString size = "0".obs;

  @override
  void onReady() async {
    super.onReady();

    /// API CALL
    // await ProductRepository.getProductVariantAPI();
  }
}
