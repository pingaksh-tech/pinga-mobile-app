import 'package:get/get.dart';

import '../../data/model/banner/banner_model.dart';
import '../../data/model/category/category_model.dart';
import '../../data/repositories/banner/banner_repository.dart';
import '../../data/repositories/category/category_repository.dart';

class HomeController extends GetxController {
  RxBool bannerLoader = true.obs;
  RxList<BannerModel> bannersList = <BannerModel>[].obs;

  RxBool categoryLoader = true.obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  @override
  void onReady() {
    super.onReady();

    /// GET BANNERS API
    BannerRepository.getBannersAPI(isLoader: bannerLoader);

    /// GET CATEGORIES API
    CategoryRepository.getCategoriesAPI(isLoader: categoryLoader);
  }
}
