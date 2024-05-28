import 'package:flutter/foundation.dart';

import '../../exports.dart';

class AppEnvironment {
  static EnvironmentType environmentType = EnvironmentType.staging;

  static String getApiURL() {
    printData(key: "API environment", value: environmentType.name);

    switch (environmentType) {
      case EnvironmentType.production:
        if (kDebugMode) {
          return "";
        } else {
          return "";
        }

      case EnvironmentType.staging:
        if (kDebugMode) {
          return "";
        } else {
          return "";
        }

      case EnvironmentType.development:
        if (kDebugMode) {
          return "";
        } else {
          return "";
        }

      case EnvironmentType.local:
        if (kDebugMode) {
          return "";
        } else {
          return "";
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
