import 'dart:io';

import 'app_environment.dart';

class ApiUrls {
  static String baseUrl = AppEnvironment.getApiURL();

  /// Splash
  static String splashGET({required String versionCode}) => "version/${Platform.isAndroid ? 'android' : 'iOS'}/$versionCode";

  /// Auth
  static const String getPredefineData = "predefine/get";
}
