import 'package:get/get.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/handler/app_environment.dart';
import '../exports.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
  }
}

class BaseController extends GetxController {
  /// DUPLICATE ROUTE CONTROLLER ISSUE RESOLVER
  RxList<String> globalProductIds = <String>[].obs;
  RxList<String> globalSizeId = <String>[].obs;
  RxList<String> globalMetalId = <String>[].obs;
  RxList<String> globalDiamondClarity = <String>[].obs;

  String get lastProductId =>
      globalProductIds.isNotEmpty ? globalProductIds.last : "";
  String get lastSizeId => globalSizeId.isNotEmpty ? globalSizeId.last : "";
  String get lastMetalId => globalMetalId.isNotEmpty ? globalMetalId.last : "";
  String get lastDiamondClarity =>
      globalDiamondClarity.isNotEmpty ? globalDiamondClarity.last : "";

  ///
  late PackageInfo packageInfo;

  @override
  void onInit() {
    super.onInit();
    deleteCacheDir();
    UiUtils.keyboardStatusListen();
  }

  @override
  void onReady() async {
    super.onReady();

    await getPackageInfo().then((returnPkgInfo) {
      packageInfo = returnPkgInfo;
      AppStrings.appName.value = returnPkgInfo.appName;
    });

    /// No Screenshot
    /// TODO
    if (AppEnvironment.environmentType == EnvironmentType.production) {
      await NoScreenshot.instance.screenshotOff();
    }
  }
}
