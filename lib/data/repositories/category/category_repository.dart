import 'package:get/get.dart';
import '../../../exports.dart';

import '../../../view/home/home_controller.dart';
import '../../model/category/category_model.dart';

class CategoryRepository {
  /// ***********************************************************************************
  ///                                 GET CATEGORIES API
  /// ***********************************************************************************

  static Future<dynamic> getCategoriesAPI({RxBool? isLoader}) async {
    ///
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllCategoriesGET,
          loader: isLoader,
        ).then(
          (response) async {
            if (response != null) {
              if (isRegistered<HomeController>()) {
                final HomeController homeCon = Get.find<HomeController>();

                GetCategoryModel model = GetCategoryModel.fromJson(response);
                homeCon.categoriesList.value = model.data?.categories ?? [];
              }
              isLoader?.value = false;
            } else {
              isLoader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "getCategoriesAPI", errText: e);
      }
    } else {}
  }
}
