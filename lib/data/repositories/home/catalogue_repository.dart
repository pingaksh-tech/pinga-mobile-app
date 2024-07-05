import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/drawer/widgets/catalog/catalogue_controller.dart';
import '../../model/home/catalogue_model.dart';

class CatalogueRepository {
  /// ***********************************************************************************
  ///                                     GET PRODUCTS LIST
  /// ***********************************************************************************

  static Future<void> createCatalogueAPI({
    String? catalogueName,
    required String categoryId,
    required String subCategoryId,
    List<String>? sortBy,
    double? minMetal,
    double? maxMetal,
    double? minDiamond,
    double? maxDiamond,
    bool? inStock,
    int? minMrp,
    int? maxMrp,
    List<dynamic>? genderList,
    List<dynamic>? diamondList,
    List<dynamic>? ktList,
    List<dynamic>? deliveryList,
    List<dynamic>? productionNameList,
    List<dynamic>? collectionList,
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createAndGetCatalogueAPI,
          body: {
            "view_type": "grid",
            "catalogue_name": catalogueName,
            if (!isValEmpty(categoryId)) "category_id": categoryId,
            if (!isValEmpty(subCategoryId)) "sub_category_id": subCategoryId,
            if (!isValEmpty(sortBy)) "sortBy": sortBy,
            if ((!isValEmpty(minMetal) && !isValEmpty(maxMetal)))
              "range": {
                if ((!isValEmpty(minMetal) && !isValEmpty(maxMetal))) "metal_wt": {"min": minMetal, "max": maxMetal},
                if ((!isValEmpty(minDiamond) && !isValEmpty(maxDiamond))) "diamond_wt": {"min": minDiamond, "max": maxDiamond}
              },
            if ((!isValEmpty(minMrp) && !isValEmpty(maxMrp))) "mrp": {"min": minMrp, "max": maxMrp},
            if (inStock != null)
              "available": {
                "in_stock": inStock,
              },
            if (genderList != null && genderList.isNotEmpty) "gender": genderList,
            if (diamondList != null && diamondList.isNotEmpty) "diamond": diamondList,
            if (ktList != null && ktList.isNotEmpty) "metal_ids": ktList,
            if (deliveryList != null && deliveryList.isNotEmpty) "delivery": deliveryList,
            if (productionNameList != null && productionNameList.isNotEmpty) "production_name": productionNameList,
            if (collectionList != null && collectionList.isNotEmpty) "collection": collectionList,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              // GetProductsModel model = GetProductsModel.fromJson(response);
              //
              // if (model.data != null) {
              //   if (isPullToRefresh) {
              //     con.inventoryProductList.value = model.data?.inventories ?? [];
              //     con.totalCount.value = model.data?.totalCount ?? 0;
              //   } else {
              //     con.inventoryProductList.addAll(model.data?.inventories ?? []);
              //     con.totalCount.value = model.data?.totalCount ?? 0;
              //   }
              //
              //   int currentPage = (model.data!.page ?? 1);
              //   con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
              //   con.page.value += currentPage;
              // }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createCatalogueAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                   GET CATALOGUE
  /// ***********************************************************************************

  static Future<void> getCatalogue({
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    final CatalogueController con = Get.find<CatalogueController>();

    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.catalogueList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createAndGetCatalogueAPI,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetCatalogueModel model = GetCatalogueModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.catalogueList.value = model.data?.catalogues ?? [];
                } else {
                  con.catalogueList.addAll(model.data?.catalogues ?? []);
                }

                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                con.page.value += currentPage;
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
        printErrors(type: "getWatchlistAPI", errText: e);
      }
    } else {}
  }
}
