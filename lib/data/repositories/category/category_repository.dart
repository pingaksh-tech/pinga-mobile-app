import 'package:get/get.dart';
import '../../../exports.dart';

import '../../../view/home/home_controller.dart';
import '../../model/category/category_model.dart';

class CategoryRepository {
  /// ***********************************************************************************
  ///                                 GET CATEGORIES API
  /// ***********************************************************************************

  static Future<dynamic> getCategoriesAPI({bool isInitial = true, bool isPullToRefresh = false, RxBool? loader}) async {
    ///
    if (await getConnectivityResult() && isRegistered<HomeController>()) {
      final HomeController con = Get.find<HomeController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.categoriesList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllCategoriesGET,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetCategoryModel model = GetCategoryModel.fromJson(response);

              if (isPullToRefresh) {
                con.categoriesList.value = model.data?.categories ?? [];
              } else {
                con.categoriesList.addAll(model.data?.categories ?? []);
              }
              con.nextPageAvailable.value = con.page.value < (model.data!.totalPages ?? 0);
              con.page.value++;
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getCategoriesAPI", errText: e);
      }
    } else {}
  }
}
