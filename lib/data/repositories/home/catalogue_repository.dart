import 'package:get/get.dart';

import '../../../view/drawer/widgets/catalog/catalogue_controller.dart';
import '../../model/home/catalogue_model.dart';

class CatalogueRepository {
  static Map<String, dynamic> catalogueList = {
    "success": true,
    "message": "Watchlist fetched",
    "data": [
      {"id": "1", "title": "Gleam Solitair -COLLECTION-20", "subtitle": "Gleam Solitair -COLLECTION-20", "created_at": "2024-06-11 12:00:00.974368", "pdf": ""},
      {"id": "2", "title": "Gleam Platinum -COLLECTION-50", "subtitle": "Gleam Solitair -COLLECTION-50", "created_at": "2024-04-21 12:00:00.974368", "pdf": ""},
      {"id": "3", "title": "Gleam Rangtrang -COLLECTION-32", "subtitle": "Gleam Solitair -COLLECTION-32", "created_at": "2024-02-14 12:00:00.974368", "pdf": ""},
      {"id": "4", "title": "Gleam Pingaksh -COLLECTION-14", "subtitle": "Gleam Solitair -COLLECTION-14", "created_at": "2024-06-02 12:00:00.974368", "pdf": ""},
      {"id": "5", "title": "Gleam Fancy Diamond -COLLECTION-53", "subtitle": "Gleam Solitair -COLLECTION-53", "created_at": "2024-05-26 12:00:00.974368", "pdf": ""},
      {"id": "6", "title": "Gleam Solitair -COLLECTION-34", "subtitle": "Gleam Solitair -COLLECTION-34", "created_at": "2024-05-12 12:00:00.974368", "pdf": ""},
    ]
  };

  /// ***********************************************************************************
  ///                                   GET CATALOGUE
  /// ***********************************************************************************

  static Future<dynamic> getCatalogueAPI({RxBool? isLoading}) async {
    final CatalogueController catalogueCon = Get.find<CatalogueController>();
    GetCatalogueModel model = GetCatalogueModel.fromJson(catalogueList /*response*/);
    catalogueCon.catalogueList.value = model.data ?? [];
    // try {
    //   isLoading?.value = true;
    //
    //   await APIFunction.getApiCall(apiUrl: 'getCatalogue' /* API URl*/).then(
    //     (response) async {
    //      final CatalogueController catalogueCon = Get.find<CatalogueController>();
    //      GetCatalogueModel model = GetCatalogueModel.fromJson(/*response*/);
    //      catalogueCon.catalogueList.value = model.data ?? [];
    //       isLoading?.value = false;
    //     },
    //   );
    // } catch (e) {
    //   printErrors(type: "Error", errText: "$e");
    //   isLoading?.value = false;
    // } finally {}
  }
}
