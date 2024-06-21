import 'package:get/get.dart';

import '../../data/model/category/category_model.dart';
import '../../data/repositories/category/category_repository.dart';
import '../../exports.dart';

class HomeController extends GetxController {
  RxList<String> bannerList = <String>[
    AppAssets.banner01,
    AppAssets.banner02,
    AppAssets.banner03,
    AppAssets.banner04,
    AppAssets.banner05,
  ].obs;

  RxList<CategoryModel> brandList = <CategoryModel>[].obs;

  RxBool bannerLoader = true.obs;
  RxBool categoryLoader = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// GET CATEGORIES API
    CategoryRepository.getCategoriesAPI(isLoader: categoryLoader);
  }
}
