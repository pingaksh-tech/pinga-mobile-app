import 'package:firebase_messaging/firebase_messaging.dart';
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
      const Duration(seconds: 2),
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

  static Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.requestPermission().then(
          (_) {
        try {
          return FirebaseMessaging.instance.getToken().then(
                (token) {
              storeDeviceInformation(token);
              return token;
            },
          );
        } catch (e) {
          return null;
        }
      },
    );
  }

  static Future<Map<String, dynamic>> devicesInfo() async {
    if (LocalStorage.deviceId.isEmpty || LocalStorage.deviceType.isEmpty) {
      if (LocalStorage.deviceToken.isEmpty) {
        await getFCMToken();
      } else {
        await storeDeviceInformation(LocalStorage.deviceToken);
      }
    }

    return {
      "device_name": LocalStorage.deviceName,
      "device_id": LocalStorage.deviceId,
      "device_type": LocalStorage.deviceType,
      "device_token": LocalStorage.deviceToken,
    };
  }
}
