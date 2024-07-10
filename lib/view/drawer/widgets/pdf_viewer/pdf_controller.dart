import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/home/catalogue_repository.dart';
import '../../../../exports.dart';

class PdfController extends GetxController {
  RxString pdfTitle = ''.obs;
  File pdfFile = File("");
  RxString catalogueId = ''.obs;
  Uint8List? temp;

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
    }
  }

  @override
  void onReady() async {
    super.onReady();

    await CatalogueRepository.downloadCatalogueAPI(catalogueId: catalogueId.value, catalogueType: CatalogueType.grid);
  }
}
