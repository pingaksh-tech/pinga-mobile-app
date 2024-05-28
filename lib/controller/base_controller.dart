import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../exports.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
  }
}

class BaseController extends GetxController {
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
  }
}
