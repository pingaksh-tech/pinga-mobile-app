import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../exports.dart';
import '../../../view/drawer/widgets/catalog/catalogue_controller.dart';
import '../../../view/drawer/widgets/pdf_viewer/pdf_controller.dart';
import '../../model/home/catalogue_model.dart';

class CatalogueRepository {
  /// ***********************************************************************************
  ///                                     GET PRODUCTS LIST
  /// ***********************************************************************************

  static Future<void> createCatalogueAPI({
    required CatalogueType catalogueType,
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
            "view_type": catalogueType.name,
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

  /// ***********************************************************************************
  ///                                     DELETE CATALOGUE API
  /// ***********************************************************************************

  static Future<void> deleteCatalogueAPI({
    required String catalogueId,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.deleteApiCall(
          apiUrl: ApiUrls.deleteAndRenameCatalogue(catalogueId: catalogueId),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              if (response['data'] != null && response['data']['status'] == true) {
                if (isRegistered<CatalogueController>()) {
                  final CatalogueController con = Get.find<CatalogueController>();

                  int index = con.catalogueList.indexWhere((element) => element.id == catalogueId);
                  if (index != -1) {
                    con.catalogueList.removeAt(index);
                  }
                }
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
        printErrors(type: "deleteCatalogueAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     RENAME CATALOGUE API
  /// ***********************************************************************************

  static Future<void> renameCatalogueAPI({
    required String catalogueId,
    required String catalogueName,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.putApiCall(
          apiUrl: ApiUrls.deleteAndRenameCatalogue(catalogueId: catalogueId),
          body: {
            "catalogue_name": catalogueName,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              if (response['data'] != null && response['data']['status'] == true) {
                if (isRegistered<CatalogueController>()) {
                  final CatalogueController con = Get.find<CatalogueController>();

                  int index = con.catalogueList.indexWhere((element) => element.id == catalogueId);
                  if (index != -1) {
                    con.catalogueList[index].name?.value = catalogueName;
                  }
                }
                Get.back();
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
        printErrors(type: "renameCatalogueAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     DOWNLOAD CATALOGUE API
  /// ***********************************************************************************

  static Future<void> downloadCatalogueAPI({
    required String catalogueId,
    required CatalogueType catalogueType,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;
        printYellow(catalogueId);

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.downloadCatalogueGET(catalogueId: catalogueId, catalogueType: catalogueType.name),
          options: Options(headers: {
            "Content-Type": "application/pdf",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          }),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              // Get the app's document directory
              Directory appDocDir = await getApplicationDocumentsDirectory();

              String appDocPath = appDocDir.path;

              Directory catalogueDir = Directory("$appDocPath/catalogue");

              if (!await catalogueDir.exists()) {
                catalogueDir.create();
              }

              // Create a file path
              String filePath = '${catalogueDir.path}/fd.pdf';

              // Write the response data to a file
              File file = File(filePath);
              await file.writeAsString(response);

              printOkStatus('File saved at $filePath');
              if (isRegistered<PdfController>()) {
                final PdfController con = Get.find<PdfController>();
                con.pdfFile = file;
                printYellow(con.pdfFile);
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
        printErrors(type: "downloadCatalogueAPI", errText: e);
      }
    } else {}
  }

  static String getRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(length, (_) => characters.codeUnitAt(Random().nextInt(characters.length))));
  }

  static Future<File> urlFileSaver({required String url, String? fileName}) async {
    printData(key: "URL", value: url);
    try {
      const extension = "pdf";

      // Create a Dio instance
      final dio = Dio();

      // Download image
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          },
        ),
      );

      printOkStatus(response.statusCode);
      // printOkStatus(Uint8List.fromList(response.data));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      fileName ??= getRandomString(10);
      // Create an image name
      var filename = '${dir.path}/$fileName.$extension';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.data);

      printWhite(file.path);

      return file;
    } catch (e) {
      rethrow;
    }
  }
}
