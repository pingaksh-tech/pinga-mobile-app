import 'package:get/get.dart';

import '../../../../data/model/product/variant_product_model.dart';
import '../../../../data/repositories/product/product_repository.dart';

class VariantController extends GetxController {
  RxList<ProductVariant> variantList = <ProductVariant>[].obs;
  RxBool isSize = true.obs;
  RxString category = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['isSize'].runtimeType == bool) {
        isSize.value = Get.arguments['isSize'];
      }
      if (Get.arguments['category'].runtimeType == String) {
        category.value = Get.arguments['category'];
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();

    /// API CALL
    await ProductRepository.getProductVariantAPI(isProductFlow: true);
  }
}
