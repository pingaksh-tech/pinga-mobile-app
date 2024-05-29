import 'package:get/get.dart';

import '../../exports.dart';
import '../../widgets/webview.dart';

class ApiUtils {
  static String defaultTitle = "Default Title";

  static Future<dynamic>? privacyPolicyNav() {
    return Get.to(
      () => const MyWebView(title: "Privacy Policy", webURL: "https://www.google.com/"),
    );
  }

  static Future<dynamic>? termsAndConditionsNav() {
    return Get.to(
      () => const MyWebView(title: "Terms and Conditions", webURL: "https://www.google.com/"),
    );
  }

  static void splashNavigation() async {
    await Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        if (LocalStorage.accessToken.isNotEmpty) {
          Get.offAllNamed(AppRoutes.bottomBarScreen);
        } else {
          Get.offAllNamed(AppRoutes.authScreen);
        }
      },
    );
  }

  //* =-=-=-=-=-=-> Local and Logout API <-=-=-=-=-=-=- *//
  static Future<void> logoutAndCleanAllUserData({RxBool? loader}) async {
    //   await AuthRepository.logOutAPI(loader: loader).then(
    //     (value) async {
    //       if (value) {
    if (Get.currentRoute != AppRoutes.authScreen) {
      Get.offAllNamed(AppRoutes.authScreen);
    }
    UiUtils.toast("Log Out Successfully");
    deleteCacheDir();
    await LocalStorage.clearLocalStorage();
    //       } else {
    //         UiUtils.toast("Please try again!");
    //       }
    //     },
    //   );
  }
}
