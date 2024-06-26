import 'package:get/get.dart';
import '../../../exports.dart';
import '../../../view/sub_category/sub_category_controller.dart';

import '../../model/latest_products/latest_products_model.dart';

class LatestProductsRepository {
  /// ***********************************************************************************
  ///                                 GET LATEST PRODUCTS API
  /// ***********************************************************************************

  static Future<dynamic> getLatestProductsAPI({bool isInitial = true, bool isPullToRefresh = false, RxBool? loader}) async {
    ///
    if (await getConnectivityResult() && isRegistered<SubCategoryController>()) {
      final SubCategoryController con = Get.find<SubCategoryController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.latestProductList.clear();
          }
          con.pageNumberLatestProd.value = 1;
          con.nextPageAvailableLatestProd.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllLatestProductsGET,
          params: {
            "page": con.pageNumberLatestProd.value,
            "limit": con.pageLimitLatestProd.value,
            "categoryId": con.categoryId.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetLatestProductsModel model = GetLatestProductsModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.latestProductList.value = model.data?.latestProducts ?? [];
                } else {
                  con.latestProductList.addAll(model.data?.latestProducts ?? []);
                }
                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailableLatestProd.value = currentPage < (model.data!.totalPages ?? 0);
                con.pageNumberLatestProd.value += currentPage;
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
        printErrors(type: "getLatestProductsAPI", errText: e);
      }
    } else {}
  }
}
