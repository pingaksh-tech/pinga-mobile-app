import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../exports.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static Future<void> getFCMToken() async {
    await FirebaseMessaging.instance.requestPermission().then(
      (_) async {
        if (kDebugMode && Platform.isIOS) {
          final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
          final IosDeviceInfo iosDeviceInfo = (await deviceInfoPlugin.iosInfo);

          /// Check if the device is a physical device
          if (iosDeviceInfo.isPhysicalDevice) {
            return await _fetchRealDeviceToken();
          } else {
            /// TODO: Debug token for iOS simulator (issue: simulator not fetching token)
            //! Note: This is a temporary solution, and any type-off Notification not working with this solution.
            await storeDeviceInformation("debug token");
          }
        } else {
          return await _fetchRealDeviceToken();
        }
      },
    );
  }

  static Future<String?> getAPNsToken() async => await FirebaseMessaging.instance.requestPermission().then(
        (_) async {
          await FirebaseMessaging.instance.deleteToken();
          printWarning("<-=-=-=-=-=-= DELETE APN TOKEN =-=-=-=-=-=-=->");

          printYellow("<-=-=-=-=-=-= FETCHING APN TCM TOKEN =-=-=-=-=-=-=->");
          return await FirebaseMessaging.instance.getAPNSToken().then(
            (token) async {
              printOkStatus("<-=-=-=-=-=-= FETCH NEW APN TOKEN =-=-=-=-=-=-=->");
              await storeDeviceInformation(token);

              printOkStatus("Device APN Token : $token");
              return token;
            },
          );
        },
      );

  static Future<String?> _fetchRealDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
    printWarning("<-=-=-=-=-=-= DELETE TCM TOKEN =-=-=-=-=-=-=->");

    printYellow("<-=-=-=-=-=-= FETCHING NEW TCM TOKEN =-=-=-=-=-=-=->");

    return await FirebaseMessaging.instance.getToken().then(
      (token) async {
        printOkStatus("<-=-=-=-=-=-= FETCH NEW TCM TOKEN =-=-=-=-=-=-=->");
        await storeDeviceInformation(token);
        return token;
      },
    );
  }

  static Future<void> storeDeviceInformation(fcmToken) async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = (await deviceInfoPlugin.androidInfo);

        String deviceId = androidDeviceInfo.isPhysicalDevice ? androidDeviceInfo.id : UiUtils.getRandomString(20);

        await LocalStorage.storeDeviceInfo(
          deviceID: deviceId,
          deviceTOKEN: fcmToken,
          deviceTYPE: "Android",
          deviceNAME: androidDeviceInfo.model,
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = (await deviceInfoPlugin.iosInfo);

        String deviceId = iosDeviceInfo.isPhysicalDevice ? (iosDeviceInfo.identifierForVendor ?? "") : UiUtils.getRandomString(20);

        await LocalStorage.storeDeviceInfo(
          deviceID: deviceId,
          deviceTOKEN: fcmToken,
          deviceTYPE: "iOS",
          deviceNAME: iosDeviceInfo.utsname.machine,
        );
      } else {
        throw platformUnsupportedError;
      }
    } catch (k) {
      printErrors(type: "storeDeviceInformation Function", errText: k);
    }
  }

  static Future<Map<String, dynamic>> devicesInfo({bool isInitial = false}) async {
    /// Login or Register to fetch new TCM token
    if (isInitial) {
      await getFCMToken();
    }

    /// Check if device ID and device type are stored in local storage
    else {
      if (LocalStorage.deviceId.isEmpty || LocalStorage.deviceType.isEmpty) {
        if (LocalStorage.deviceToken.isEmpty) {
          await getFCMToken();
        } else {
          await storeDeviceInformation(LocalStorage.deviceToken);
        }
      }
    }

    return {
      "platform": AppStrings.appSlug,
      "device_id": LocalStorage.deviceId,
      "device_type": LocalStorage.deviceType,
      "device_token": LocalStorage.deviceToken,
    };
  }

  static Future<String> devicesId({bool isInitial = false}) async {
    /// Login or Register to fetch new TCM token
    if (isInitial) {
      await getFCMToken();
    }

    /// Check if device ID and device type are stored in local storage
    else {
      if (LocalStorage.deviceId.isEmpty || LocalStorage.deviceType.isEmpty) {
        if (LocalStorage.deviceToken.isEmpty) {
          await getFCMToken();
        } else {
          await storeDeviceInformation(LocalStorage.deviceToken);
        }
      }
    }

    return LocalStorage.deviceId;
  }
}
