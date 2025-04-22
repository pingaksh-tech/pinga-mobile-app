import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../data/model/catalog/get_catalog_pdf_model.dart';
import '../../../../data/repositories/home/catalogue_repository.dart';
import '../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../exports.dart';

class PdfPreviewController extends GetxController {
  RxBool isListView = false.obs;
  RxBool isLoader = false.obs;

  Rx<Uint8List>? docPdf = Uint8List(0).obs;

  RxList<CatalogPdfModel> productList = <CatalogPdfModel>[].obs;

  RxString catalogueId = ''.obs;
  RxString pdfTitle = ''.obs;

  RxBool isFromCatalog = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["title"].runtimeType == String) {
        pdfTitle.value = Get.arguments["title"];
      }
      if (Get.arguments["catalogueId"].runtimeType == String) {
        catalogueId.value = Get.arguments["catalogueId"];
      }
      if (Get.arguments["isFromCatalog"].runtimeType == bool) {
        isFromCatalog.value = Get.arguments["isFromCatalog"];
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();

    if (isFromCatalog.isTrue) {
      await CatalogueRepository.downloadCatalogueAPI(
        loader: isLoader,
        catalogueId: catalogueId.value,
        title: pdfTitle.value,
        catalogueType: CatalogueType.grid,
        onSuccess: () {
          downloadPDF();
        },
      );
    } else {
      await WatchListRepository.downloadWatchAPI(
        loader: isLoader,
        watchId: catalogueId.value,
        title: pdfTitle.value,
        onSuccess: () {
          Future.delayed(const Duration(seconds: 6), () {
            downloadPDF(isDownload: true);
          });
        },
      );
    }
  }

  Future<Uint8List?> loadImageFromUrl(String imageUrl) async {
    if (isValEmpty(imageUrl)) return null;

    try {
      final dio = Dio();
      final response = await dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      return Uint8List.fromList(response.data ?? []);
    } catch (e) {
      printErrors(
        type: "loadImageFromUrl",
        errText: 'Failed to load image from $imageUrl. Error: $e',
      );
      return null;
    }
  }

  Future<void> downloadPDF({bool isDownload = false}) async {
    // Get the app's document directory

    Directory appDocDir = Directory("");
    if (isDownload) {
      if (Platform.isAndroid) {
        appDocDir = Directory("/storage/emulated/0/Download");
      } else {
        appDocDir = await getApplicationDocumentsDirectory();
      }
    } else {
      appDocDir = await getTemporaryDirectory();
    }

    String appDocPath = appDocDir.path;
    Directory catalogueDir = Directory("$appDocPath/pingaksh");

    if (!await catalogueDir.exists()) {
      await catalogueDir.create();
    }

    // Create a file path
    String filePath = '${catalogueDir.path}/${pdfTitle.value}.pdf';

    // Write the response data to a file
    File file = File(filePath);
    if (docPdf != null) await file.writeAsBytes(docPdf!.value); // Directly use response as it is Uint8List

    printOkStatus('File saved at $filePath');
    if (isDownload) UiUtils.toast("PDF downloaded successfully");
  }
}
