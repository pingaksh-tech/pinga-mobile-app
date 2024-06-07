import 'package:get/get.dart';
import '../data/model/cart/product_detail_model.dart';
import '../data/model/predefined_model/predefined_model.dart';
import '../data/repositories/cart/cart_repository.dart';
import '../data/repositories/product/product_repository.dart';
import '../exports.dart';

class PreValueController extends GetxController {
  RxList<ProductDetail> cartProductDetailList = <ProductDetail>[].obs;
  RxMap<String, dynamic> predefineResponse = <String, dynamic>{}.obs;

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  Future<void> fetchData() async {
    printData(key: "Calling...", value: "FetchData");
    await ProductRepository.getPredefineValueAPI();
    await CartRepository.getProductDetailAPI();
  }

  /// Check predefine value
  Future<List<SizeModel>> checkHasPreValue(String slug, {required String type}) async {
    if (predefineResponse['data'][slug] == null) {
      return await ProductRepository.getPredefineValueAPI().then((value) {
        if (!isValEmpty(value) && value['data'][slug] != null) {
          return List<SizeModel>.from(predefineResponse['data'][slug][type].map((x) => SizeModel.fromJson(x)));
        } else {
          return [];
        }
      });
    } else {
      if (predefineResponse['data'][slug][type] == null) {
        // API
        return await ProductRepository.getPredefineValueAPI().then((value) {
          if (!isValEmpty(value) && value['data'][slug][type] != null) {
            return List<SizeModel>.from(predefineResponse['data'][slug][type].map((x) => SizeModel.fromJson(x)));
          } else {
            return [];
          }
        });
      } else {
        return List<SizeModel>.from(predefineResponse['data'][slug][type].map((x) => SizeModel.fromJson(x)));
      }
    }
  }
}
