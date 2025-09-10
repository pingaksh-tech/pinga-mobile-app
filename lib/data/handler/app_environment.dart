import 'package:flutter/foundation.dart';

import '../../exports.dart';

class AppEnvironment {
  static EnvironmentType environmentType = EnvironmentType.production;

  static String getApiURL() {
    printData(key: "API environment", value: environmentType.name);

    switch (environmentType) {
      case EnvironmentType.production:
        if (kDebugMode) {
          return "https://api.pingaksh.co/api/";
        } else {
          return "https://api.pingaksh.co/api/";
        }

      case EnvironmentType.staging:
        if (kDebugMode) {
          return "";
        } else {
          return "";
        }

      case EnvironmentType.development:
        if (kDebugMode) {
          return "https://apidev.pingaksh.co/api/";
        } else {
          return "https://apidev.pingaksh.co/api/";
        }

      case EnvironmentType.local:
        if (kDebugMode) {
          return "http://192.168.1.47:3000/api/";
        } else {
          return "http://192.168.1.12:3000/api/";
        }

      case EnvironmentType.custom:
        if (kDebugMode) {
          return LocalStorage.baseUrl;
        } else {
          return LocalStorage.baseUrl;
        }
    }
  }
}
