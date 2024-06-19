import 'package:dio/dio.dart';
import '../../exports.dart';
import 'api_class.dart';

class APIFunction {

  /// ***********************************************************************************
  ///                                    OPTIONS & HEADER
  /// ***********************************************************************************

  static getOptionsAndHeader({Duration? receiveTimeout}){
    return Options(
      receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${LocalStorage.accessToken}",
      },
    );
  }


  /// ***********************************************************************************
  ///                                         GET
  /// ***********************************************************************************

  static Future<dynamic> getApiCall({
    required String apiUrl,
    dynamic body,
    bool? isDecode,
    dynamic params,
    Duration? receiveTimeout, // `null` or `Duration.zero` means no timeout limit.
    bool withBaseUrl = false,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).get(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        queryParameters: params,
        isDecode: isDecode ?? false,
        options: getOptionsAndHeader(receiveTimeout:receiveTimeout),
      );
      return response;
    }
  }

  /// ***********************************************************************************
  ///                                         POST
  /// ***********************************************************************************

  static Future<dynamic> postApiCall({
    required String apiUrl,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout, // `null` or `Duration.zero` means no timeout limit.// `null` or `Duration.zero` means no timeout limit.
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).post(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout:receiveTimeout),
      );
      return response;
    }
  }

  /// ***********************************************************************************
  ///                                         PUT
  /// ***********************************************************************************

  static Future<dynamic> putApiCall({
    required String apiUrl,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout, // `null` or `Duration.zero` means no timeout limit.
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {

      dynamic response = await HttpUtil(errorToast: showErrorToast).put(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout:receiveTimeout),
      );
      return response;
    }
  }


  /// ***********************************************************************************
  ///                                         DELETE
  /// ***********************************************************************************

  static Future<dynamic> deleteApiCall({
    required String apiUrl,
    dynamic body,
    dynamic prams,
    bool? isDecode,
    Duration? receiveTimeout, // `null` or `Duration.zero` means no timeout limit.
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).delete(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        isDecode: isDecode ?? false,
        queryParameters: prams,
        options: getOptionsAndHeader(receiveTimeout:receiveTimeout),
      );
      return response;
    }
  }
}
