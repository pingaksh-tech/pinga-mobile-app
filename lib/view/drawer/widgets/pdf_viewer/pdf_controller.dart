import 'package:get/get.dart';

class PdfController extends GetxController {
  RxString pdfTitle = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments["title"].runtimeType == String) {
        pdfTitle.value = Get.arguments["title"];
      }
    }
  }
}
