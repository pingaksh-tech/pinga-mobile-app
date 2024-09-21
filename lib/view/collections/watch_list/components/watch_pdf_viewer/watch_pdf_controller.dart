import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/watchlist/watchlist_repository.dart';

class WatchPdfController extends GetxController {
  RxString pdfTitle = ''.obs;
  File pdfFile = File("");
  RxString watchId = ''.obs;
  Uint8List? temp;
  RxBool isDownloading = true.obs;

  @override
  void onInit() {
    super.onInit();
    WatchListRepository.resetDownloadRequest();
    if (Get.arguments != null) {
      if (Get.arguments["title"].runtimeType == String) {
        pdfTitle.value = Get.arguments["title"];
      }
      if (Get.arguments["watchId"].runtimeType == String) {
        watchId.value = Get.arguments["watchId"];
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();

    await WatchListRepository.downloadWatchAPI(
      watchId: watchId.value,
      title: pdfTitle.value,
    );
  }
}
