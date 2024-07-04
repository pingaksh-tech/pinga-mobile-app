import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/sub_category/sub_category_controller.dart';
import '../../model/sub_category/sub_category_model.dart';

class SubCategoryRepository {
  /// ***********************************************************************************
  ///                                 GET SUB-CATEGORIES API
  /// ***********************************************************************************

  static Future<dynamic> getSubCategoriesAPI({bool isInitial = true, bool isPullToRefresh = false, RxBool? loader, required String searchText}) async {
    ///
    if (await getConnectivityResult() && isRegistered<SubCategoryController>()) {
      final SubCategoryController con = Get.find<SubCategoryController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.subCategoriesList.clear();
          }
          con.pageNumberSubCategory.value = 1;
          con.nextPageAvailableSubCategory.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllSubCategoriesGET,
          params: {
            "page": con.pageNumberSubCategory.value,
            "limit": con.pageLimitSubCategory.value,
            "categoryId": con.categoryId.value,
            "search": con.getSearchText,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSubCategoryModel model = GetSubCategoryModel.fromJson(response);
              if (model.data != null) {
                if (isPullToRefresh) {
                  con.subCategoriesList.value = model.data?.subCategories ?? [];
                } else {
                  con.subCategoriesList.addAll(model.data?.subCategories ?? []);
                }
                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailableSubCategory.value = currentPage < (model.data!.totalPages ?? 0);
                con.pageNumberSubCategory.value += currentPage;
              }
              loader?.value = false;
            } else {
              loader?.value = false;
            }
            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getSubCategoriesAPI", errText: e);
      }
    } else {}
  }
}
