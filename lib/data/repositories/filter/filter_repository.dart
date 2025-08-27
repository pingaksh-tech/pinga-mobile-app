import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/products/widgets/filter/filter_controller.dart';
import '../../model/cart/retailer_model.dart';
import '../../model/filter/stock_available_model.dart';

class FilterRepository {
  static Map<String, dynamic> availableList = {
    "success": true,
    "message": "Stock fetched successfully",
    "data": {
      "products": [
        {"title": "In Stock Available Only", "isChecked": false},
      ],
    }
  };

  /// ***********************************************************************************
  ///                                     GET PRODUCT LIST
  /// ***********************************************************************************
  static Future<void> stockAvailableList() async {
    final FilterController filterCon = Get.find<FilterController>();
    GetStockAvailableModel model = GetStockAvailableModel.fromJson(availableList /*response*/);
    filterCon.availableList.value = model.data?.products ?? [];
  }

  static Future<dynamic> getRetailerApi({
    bool isInitial = true,
    RxBool? loader,
  }) async {
    ///
    if (await getConnectivityResult()) {
      final FilterController con = Get.find<FilterController>();

      try {
        loader?.value = true;
        // if (isInitial) {
        //   con.retailerList.clear();
        //   con.page.value = 1;
        //   con.nextPageAvailable.value = true;
        // }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getRetailerApi,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetRetailerModel model = GetRetailerModel.fromJson(response);

              if (model.data != null) {
                if (isInitial) {
                  con.retailerList.assignAll(model.data?.retailers ?? []);
                } else {
                  con.retailerList.addAll(model.data?.retailers ?? []);
                }

                loader?.value = false;

                printYellow("=====  Filter ====== ${con.retailerList.length}");
                // con.retailerList.addAll(model.data?.retailers ?? []);
                // int currentPage = (model.data!.page ?? 1);
                // con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                // con.page.value += currentPage;
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
        printErrors(type: "getRetailerList Filter", errText: e);
      }
    }
  }
}
