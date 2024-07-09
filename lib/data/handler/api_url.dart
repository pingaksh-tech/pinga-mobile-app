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
  static const String logOutPOST = "auth/logout";
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
  static const String getProductPricePOST = "inventory/changing-price";
  static String getSingleProductDetailGET({required String inventoryId}) => "inventory/$inventoryId";

  /// WISHLIST
  static const String createAndGetWishlistAPI = "mobile/wishlist";

  /// WATCHLIST
  static const String createAndGetWatchlistAPI = "mobile/watchlist";
  static const String cartToWatchlistPOST = "mobile/watchlist/cart-to-watchlist";

  static String getAndDeleteSingleWatchListAPI({required String watchlistId}) => "mobile/watchlist/$watchlistId";
  static String getSingleWatchListAPI({required String watchListId}) => "mobile/watchlist/find-inventories/$watchListId";

  /// USER
  static const String deleteAccountDELETE = "";
  static String getUserAPI({required String userId}) => "mobile/profile/$userId";
  static String updateUserAPI = "mobile/profile";

  /// CART
  static String getAllCartGET = "mobile/cart/";

  static String deleteCartApi({String? cartId}) => "mobile/cart/$cartId";
  static String multiPleDelete = "mobile/cart/multi/items";
  static String cartUpdatePUT = "/mobile/cart/";
  static String addOrRemoveCart = "cart/add-remove/";
  static String placeOrderPOST = "order/create";
  static String getRetailerApi = "retailer/";
  static String getCartSummary = "/mobile/cart/summary";
  static String getSingleCartDetailGET({required String cartId}) => "/mobile/cart/item/$cartId";

  static String addWatchlistToCart({required String watchlistId}) => "mobile/watchlist/cart/$watchlistId";

  /// ORDERS
  static String orderProductUrl = "order/list";
  static String createOrGetOrder = "/mobile/order/";
  static String getSingleOrderDetailGET({required String orderId}) => "/mobile/order/$orderId";

  /// WISHLIST
  static String watchlistGet = "wishlist/get";

  /// CATALOGUE
  static String createAndGetCatalogueAPI = "mobile/catalogue";

  static String deleteAndRenameCatalogue({required String catalogueId}) => "mobile/catalogue/$catalogueId";

  static String downloadCatalogueGET({required String catalogueId, required String catalogueType}) => "mobile/catalogue/$catalogueType/$catalogueId";
}
