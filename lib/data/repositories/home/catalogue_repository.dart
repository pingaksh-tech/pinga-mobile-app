import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../exports.dart';
import '../../../view/drawer/widgets/catalog/catalogue_controller.dart';
import '../../../view/drawer/widgets/pdf_preview/pdf_preview_controller.dart';
import '../../../view/drawer/widgets/pdf_viewer/pdf_controller.dart';
import '../../model/catalog/get_catalog_pdf_model.dart';
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
            printData(key: "response", value: response);
            if (response != null) {
              UiUtils.toast("Catalogue Created Successfully");
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
                con.page.value = currentPage + 1;
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
              UiUtils.toast("Pdf deleted successfully");
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
                UiUtils.toast("Catalogue name change successfully");
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

  static var demoPdfCode = '''%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>
endobj
4 0 obj
<< /Length 44 >>
stream
BT /F1 24 Tf 100 700 Td (Hello, PDF World!) Tj ET
endstream
endobj
5 0 obj
<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>
endobj
xref
0 6
0000000000 65535 f
0000000010 00000 n
0000000053 00000 n
0000000102 00000 n
0000000196 00000 n
0000000281 00000 n
trailer
<< /Root 1 0 R /Size 6 >>
startxref
333
%%EOF
''';

  static CancelToken cancelToken = CancelToken();
  // Method to cancel the request
  static void cancelDownloadRequest() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
    // Create a new CancelToken for future requests
    cancelToken = CancelToken();
  }

  // Method to reset the request
  static void resetDownloadRequest() {
    cancelToken = CancelToken();
  }

  static Future<void> downloadCatalogueAPI({
    required String title,
    required String catalogueId,
    required CatalogueType catalogueType,
    RxBool? loader,
    Function()? onSuccess,
  }) async {
    cancelToken = CancelToken();
    if (await getConnectivityResult()) {
      // Create a cancel token
      loader?.value = true;
      try {
        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.downloadCatalogueGET(catalogueId: catalogueId, catalogueType: catalogueType.name),
          options: Options(
            headers: {
              "Content-Type": "application/pdf",
              "Authorization": "Bearer ${LocalStorage.accessToken}",
            },
            // responseType: ResponseType.bytes, // Set the response type to bytes
          ),
          cancelToken: cancelToken,
          loader: loader,
        ).then(
          (response) async {
            // If the request was cancelled, skip processing the response.
            if (cancelToken.isCancelled) {
              loader?.value = false; // Stop loader
              return; // Skip further execution
            }
            if (response != null) {
              GetCatalogPdfModel model = GetCatalogPdfModel.fromJson(response);
              if (isRegistered<PdfPreviewController>()) {
                PdfPreviewController pdfViewCon = Get.find<PdfPreviewController>();
                pdfViewCon.productList.assignAll(model.data ?? []);

                pdfViewCon.productList.refresh();
              }

              onSuccess?.call();
              /*  // Get the app's document directory
              Directory appDocDir = await getTemporaryDirectory();
              String appDocPath = appDocDir.path;
              Directory catalogueDir = Directory("$appDocPath/catalogue");

              if (!await catalogueDir.exists()) {
                await catalogueDir.create();
              }

              // Create a file path
              String filePath = '${catalogueDir.path}/$title.pdf';

              // Write the response data to a file
              File file = File(filePath);
              await file.writeAsBytes(response); // Directly use response as it is Uint8List

              printOkStatus('File saved at $filePath');

              if (Get.currentRoute == AppRoutes.pdfViewerScreen) {
                Get.back();
              }

              /// Open the PDF if the request was not canceled
              await OpenFile.open(file.path).whenComplete(() {
                // Get.back();
              });
 */
              if (isRegistered<PdfController>()) {
                final PdfController con = Get.find<PdfController>();
                // con.pdfFile = file;
                con.isDownloading.value = false;
                printYellow(con.pdfFile);
                printYellow(await con.pdfFile.exists());
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          printYellow('Request cancelled');
        } else {
          // Handle other errors
          if (e.response != null) {
            if (e.response!.statusCode == 502) {
              printYellow('Received a 502 Bad Gateway error');
            } else {
              printYellow('DioException response: ${e.response!.statusCode} - ${e.response!.statusMessage}');
            }
          } else {
            printYellow('DioException error: ${e.message}');
          }
        }

        loader?.value = false; // Ensure loader stops on error
      } finally {
        // Ensure loader stops on completion or error
        loader?.value = false;
        // Reset cancelToken
      }
    } else {}
  }

/*  // static var demoPdfCode = '''''';
  static var demoPdfCode = '''%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>
endobj
4 0 obj
<< /Length 44 >>
stream
BT /F1 24 Tf 100 700 Td (Hello, PDF World!) Tj ET
endstream
endobj
5 0 obj
<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>
endobj
xref
0 6
0000000000 65535 f
0000000010 00000 n
0000000053 00000 n
0000000102 00000 n
0000000196 00000 n
0000000281 00000 n
trailer
<< /Root 1 0 R /Size 6 >>
startxref
333
%%EOF
''';

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
              Directory appDocDir = await getTemporaryDirectory();

              String appDocPath = appDocDir.path;

              Directory catalogueDir = Directory("$appDocPath/catalogue");

              if (!await catalogueDir.exists()) {
                catalogueDir.create();
              }

              // Create a file path
              String filePath = '${catalogueDir.path}/fds.pdf';

              // Write the response data to a file
              File file = File(filePath);
              await file.writeAsString(response);
              // await file.writeAsString(demoPdfCode);

              printOkStatus('File saved at $filePath');

              /// Open the PDF
              // await OpenFile.open(file.path);

              if (isRegistered<PdfController>()) {
                final PdfController con = Get.find<PdfController>();
                con.pdfFile = file;
                printYellow(con.pdfFile);
                printYellow(await con.pdfFile.exists());
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
  }*/

  /*Future<void> _downloadAndOpenPDF() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetching the PDF from the API
      final response = await Dio().get(
        'https://example.com/api/your-pdf-endpoint',
        options: Options(responseType: ResponseType.bytes),
      );

      // Saving the PDF locally
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/example.pdf');
      await file.writeAsBytes(response.data);

      // Open the PDF
      await OpenFile.open(file.path);

      setState(() {
        _filePath = file.path;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }*/

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
