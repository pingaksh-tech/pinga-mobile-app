import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import 'api_class.dart';

class APIFunction {
  /// ------ To Call Post API -------------------->>>
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
      if (kDebugMode) {
        if (!isValEmpty(params)) {
          printTitle("Post API params (Start)");
          log("$apiUrl - With params $params");
          printTitle("Post API params (End)");
        }

        if (!isValEmpty(body)) {
          printTitle("Post API Body (Start)");
          log("$apiUrl - With Body $body");
          printTitle("Post API Body (End)");
        }
      }

      dynamic response = await HttpUtil(errorToast: showErrorToast).post(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: Options(
          receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          },
        ),
      );
      return response;
    }
  }

  /// ------ To Call Put API -------------------->>>
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
      if (kDebugMode) {
        if (!isValEmpty(params)) {
          printTitle("Put API params (Start)");
          log("$apiUrl - With params $params");
          printTitle("Put API params (End)");
        }

        if (!isValEmpty(body)) {
          printTitle("Put API Body (Start)");
          log("$apiUrl - With Body $body");
          printTitle("Put API Body (End)");
        }
      }

      dynamic response = await HttpUtil(errorToast: showErrorToast).put(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: Options(
          receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          },
        ),
      );
      return response;
    }
  }

  /// ------ To Call Get API -------------------->>>
  static Future<dynamic> getApiCall({
    required String apiUrl,
    dynamic body,
    bool? isDecode,
    dynamic params,
    RxBool? isLoading,
    Duration? receiveTimeout, // `null` or `Duration.zero` means no timeout limit.
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      isLoading?.value = true;

      if (kDebugMode) {
        if (!isValEmpty(body)) {
          printTitle("Get API Body (Start)");
          log("$apiUrl - With Body $body");
          printTitle("Get API Body (End)");
        }

        if (!isValEmpty(params)) {
          printTitle("Get API Query Parameters (Start)");
          log("$apiUrl - Query Parameters $params");
          printTitle("Get API Query Parameters (End)");
        }
      }

      dynamic response = await HttpUtil(errorToast: showErrorToast).get(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        queryParameters: params,
        isDecode: isDecode ?? false,
        options: Options(
          receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          },
        ),
      );
      return response;
    }
  }

  /// ------ To Call Post API -------------------->>>
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
      if (kDebugMode) {
        if (!isValEmpty(body)) {
          printTitle("Delete API Body (Start)");
          log("$apiUrl - With Body $body");
          printTitle("Delete API Body (End)");
        }
      }
      dynamic response = await HttpUtil(errorToast: showErrorToast).delete(
        withBaseUrl == true ? (ApiUrls.baseUrl + apiUrl) : apiUrl,
        body: body,
        isDecode: isDecode ?? false,
        queryParameters: prams,
        options: Options(
          receiveTimeout: receiveTimeout ?? HttpUtil.defaultTimeoutDuration,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.accessToken}",
          },
        ),
      );
      return response;
    }
  }
}
