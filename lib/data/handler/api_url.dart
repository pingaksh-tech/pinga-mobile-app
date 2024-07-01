import 'dart:io';

import 'app_environment.dart';

class ApiUrls {
  static String baseUrl = AppEnvironment.getApiURL();

  /// SPLASH
  static String splashGET({required String versionCode}) => "mobile/setting/splash-screen/${Platform.isAndroid ? 'android' : 'iOS'}/$versionCode";

  /// AUTH
  static const String sendMobileOtpPOST = "mobile/auth/login";
  static const String resendMobileOtpPOST = "mobile/auth/resend-otp";
  static const String verifyMobileOtpPOST = "mobile/auth/verify-otp";
  static const String logOutPOST = "user/auth/logout";
  static const String refreshTokenUrl = "auth/refresh-token";

  /// BANNER
  static const String getAllBannersGET = "banner";

  /// CATEGORY
  static const String getAllCategoriesGET = "category";

  /// SUB-CATEGORY
  static const String getAllSubCategoriesGET = "sub-category";

  /// LATEST PRODUCTS
  static const String getAllLatestProductsGET = "latest-product";

  /// PRODUCTS
  static const String getAllProductsPOST = "inventory/filter";

  /// USER
  static const String deleteAccountDELETE = "";

  /// CART
  static String getCartList = "mobile/cart/";
  static String deleteCartApi({String? cartId}) => "mobile/cart/";
  static String cartUpdatePUT = "cart/update/";
  static String addOrRemoveCart = "cart/add-remove/";
  static String placeOrderPOST = "order/create";
  static String getRetailerApi = "retailer/";

  /// ORDERS
  static String orderProductUrl = "order/list";

  /// WISHLIST
  static String watchlistGet = "wishlist/get";
}
