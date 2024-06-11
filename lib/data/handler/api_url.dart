import 'dart:io';

import 'app_environment.dart';

class ApiUrls {
  static String baseUrl = AppEnvironment.getApiURL();

  /// Splash
  static String splashGET({required String versionCode}) => "version/${Platform.isAndroid ? 'android' : 'iOS'}/$versionCode";

  /// Auth
  static const String getPredefineData = "predefine/get";

  /// CART
  static String cartListGET = "cart/get";
  static String cartUpdatePUT = "cart/update/";
  static String addOrRemoveCart = "cart/add-remove/";
  static String placeOrderPOST = "order/create";

  /// ORDERS
  static String orderProductUrl = "order/list";

// static String homeProductUrl = "product/list";
// static String addLocationUrl = "user/lat-long";
// static String profileUrl = "user/profile";
// static String placeOrderUrl = "order/create";
// static String singleProduct = "product/get/";
// static String latLng = "user/update-lat-long";

  /// WISHLIST
  static String watchlistGet = "wishlist/get";
}
