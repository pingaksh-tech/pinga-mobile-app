import 'package:get/get.dart';
import 'package:pingaksh_mobile/data/model/product/product_colors_model.dart';
import 'package:pingaksh_mobile/data/model/product/product_size_model.dart';
import 'package:pingaksh_mobile/data/repositories/product/product_repository.dart';

class DialogController extends GetxController {
  RxList<SizeModel> productSizeList = <SizeModel>[].obs;
  RxList<ColorModel> productColorList = <ColorModel>[].obs;

  @override
  void onReady() async {
    super.onReady();

    await ProductRepository.getProductSizeAPI();
    await ProductRepository.getProductColorAPI();
  }
}
