import 'package:get/get.dart';

import '../../../../data/model/home/catalogue_model.dart';
import '../../../../data/repositories/home/catalogue_repository.dart';

class CatalogueController extends GetxController {
  RxList<CatalogueModel> catalogueList = <CatalogueModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    CatalogueRepository.getCatalogueAPI();
  }
}
