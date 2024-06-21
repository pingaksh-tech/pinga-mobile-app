import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../exports.dart';
import 'api_class.dart';

class APIFunction {
  /// ***********************************************************************************
  ///                                    OPTIONS & HEADER
  /// ***********************************************************************************

  static getOptionsAndHeader({Duration? receiveTimeout, bool useRefreshToken = false}) {
    return Options(
      receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${useRefreshToken ? LocalStorage.refreshToken : LocalStorage.accessToken}",
      },
    );
  }

  static Future<dynamic> getApiCall({
    required String apiUrl,
    dynamic body,
    bool? isDecode,
    dynamic params,
    Duration? receiveTimeout,
    bool withBaseUrl = false,
    bool showErrorToast = true,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).get(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        queryParameters: params,
        isDecode: isDecode ?? false,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout),
        loader: loader,
      );
      return response;
    }
  }

  static Future<dynamic> postApiCall({
    required String apiUrl,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    bool useRefreshToken = false,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).post(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout,useRefreshToken: useRefreshToken),
        loader: loader,
      );
      return response;
    }
  }

  static Future<dynamic> putApiCall({
    required String apiUrl,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).put(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout),
        loader: loader,
      );
      return response;
    }
  }

  static Future<dynamic> deleteApiCall({
    required String apiUrl,
    dynamic body,
    dynamic prams,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).delete(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        queryParameters: prams,
        isDecode: isDecode ?? false,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout),
        loader: loader,
      );
      return response;
    }
  }

  static Future<dynamic> patchApiCall({
    required String apiUrl,
    dio.FormData? data,
    dynamic params,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).patch(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        data: data,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout),
        loader: loader,
      );
      return response;
    }
  }

  static Future<dynamic> postStreamApiCall({
    required String apiUrl,
    dynamic params,
    dynamic data,
    int dataLength = 0,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).postStream(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        data: data,
        dataLength: dataLength,
        queryParameters: params,
        options: getOptionsAndHeader(receiveTimeout: receiveTimeout),
        loader: loader,
      );
      return response;
    }
  }
}
