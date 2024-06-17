import 'dart:io';

import 'app_environment.dart';

class ApiUrls {
  static String baseUrl = AppEnvironment.getApiURL();

  /// SPLASH
  static String splashGET({required String versionCode}) => "version/${Platform.isAndroid ? 'android' : 'iOS'}/$versionCode";

  /// AUTH
  static const String sendMobileOtpPOST = "mobile/auth/login";
  static const String resendMobileOtpPOST = "mobile/auth/resend-otp";
  static const String verifyMobileOtpPOST = "mobile/auth/verify-otp";
  static const String logOutPOST = "user/auth/logout";


  /// USER
  static const String deleteAccountDELETE = "";

  /// CART
  static String cartListGET = "cart/get";
  static String cartUpdatePUT = "cart/update/";
  static String addOrRemoveCart = "cart/add-remove/";
  static String placeOrderPOST = "order/create";

  /// ORDERS
  static String orderProductUrl = "order/list";

  /// WISHLIST
  static String watchlistGet = "wishlist/get";
}
