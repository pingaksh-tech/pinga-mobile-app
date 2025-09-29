import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../exports.dart';
import 'api_utils.dart';

class HttpUtil {
  static const Duration defaultTimeoutDuration = Duration(seconds: 15);
  static const Duration orderCreateAPITimeOut = Duration(seconds: 30);
  static bool showErrorToast = true;

  // Method to refresh tokens
  Future<void> _refreshTokens() async {
    try {
      await APIFunction.postApiCall(
        apiUrl: ApiUrls.refreshTokenUrl,
        useRefreshToken: true,
      ).then(
        (response) async {
          if (response != null && response['data'] != null) {
            LocalStorage.accessToken = response['data']['access_token'] ?? "";
            LocalStorage.refreshToken = response['data']['refresh_token'] ?? "";
          }
        },
      );
    } catch (e) {
      await ApiUtils.logoutAndCleanAllUserData();
      printErrors(type: "_refreshTokens", errText: "$e");
    } finally {}
  }

  factory HttpUtil({bool errorToast = true}) {
    showErrorToast = errorToast;
    return _instance();
  }

  static HttpUtil _instance() => HttpUtil._internal();

  late Dio dio;
  CancelToken cancelToken = CancelToken();
  String apiUrl = ApiUrls.baseUrl;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    /// SHOW API LOGS
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          try {
            if (!isValEmpty(e.response)) {
              /*if (e.response?.statusCode == 426) {
                showErrorToast = false;

                // Refresh tokens
                await _refreshTokens();

                // await Future.delayed(const Duration(seconds: 10));

                // Retry the original request with new access token
                final options = e.requestOptions;
                options.headers['Authorization'] =
                    'Bearer ${LocalStorage.accessToken}';

                final response = await dio.request(
                  options.path,
                  options: Options(
                    method: options.method,
                    headers: options.headers,
                  ),
                  data: options.data,
                  queryParameters: options.queryParameters,
                );

                return handler.resolve(response);
              }*/

              if (showErrorToast == true) {
                UiUtils.toast(e.response?.data['message'].toString());
              }
            }

            apiErrorHandler(e.response != null ? e.response!.statusCode! : 00);

            onError(createErrorEntity(e));
          } catch (err) {
            printErrors(type: "CreateErrorEntity function", errText: "$e");
          }
          return handler.next(e); //continue
        },
      ),
    );
  }

  Future apiErrorHandler(int statusCode, {bool isLogin = false}) async {
    try {
      if (statusCode == 400) {
      } else if (statusCode == 401) {
        await ApiUtils.logoutAndCleanAllUserData();
      } else if (statusCode == 403) {}
    } catch (e, stackTrace) {
      printWarning(stackTrace.toString());
    }
  }

  // On Error....
  void onError(ErrorEntity eInfo) {
    printWarning("error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
    if (eInfo.message.isNotEmpty) {
      if (showErrorToast == true) {
        // toast(eInfo.message);
      }
    }
  }

  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request to server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -3, message: "Send timeout in connection with server");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -4, message: "Receive timeout in connection with server");
      case DioExceptionType.badResponse:
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : 00;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "Request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "Permission denied");
              case 403:
                return ErrorEntity(code: errCode, message: "Server refuses to execute");
              case 404:
                return ErrorEntity(code: errCode, message: "Can not reach server");
              case 405:
                return ErrorEntity(code: errCode, message: "Request method is forbidden");
              case 500:
                return ErrorEntity(code: errCode, message: "Internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server hangs");
              case 505:
                return ErrorEntity(code: errCode, message: "HTTP protocol requests are not supported");
              default:
                return ErrorEntity(code: errCode, message: error.response != null ? error.response!.data! : "");
            }
          } on Exception catch (_) {
            return ErrorEntity(code: 00, message: "Unknown mistake");
          }
        }
      case DioExceptionType.unknown:
        if (error.message != null) {
          if (error.message!.contains("SocketException")) {
            return ErrorEntity(code: -5, message: "Your internet is not available, please try again later");
          } else {
            if (error.message!.contains("Software caused connection abort")) {
              return ErrorEntity(code: -6, message: "Your internet is not available, please try again later");
            }
          }
        }
        return ErrorEntity(code: -7, message: "Oops something went wrong");
      default:
        return ErrorEntity(code: -8, message: "Oops something went wrong");
    }
  }

  void cancelRequests() {
    cancelToken.cancel("cancelled");
  }

  Future get(String path, {dynamic body, bool? isDecode = false, Map<String, dynamic>? queryParameters, Options? options, bool refresh = false, bool noCache = true, bool list = false, String cacheKey = '', bool cacheDisk = false, RxBool? loader, CancelToken? cancelTokens}) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();
      requestOptions.extra ??= {};
      requestOptions.extra!.addAll({
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      });

      var response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        data: isDecode == false ? body : d.FormData.fromMap(body),
        cancelToken: cancelTokens ?? cancelToken,
      );
      return response.data;
    } finally {
      loader?.value = false;
    }
  }

  Future post(
    String path, {
    dynamic body,
    bool? isDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    RxBool? loader,
  }) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();

      var response = await dio.post(
        path,
        data: isDecode == false ? body : d.FormData.fromMap(body),
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );

      return response.data;
    } finally {
      loader?.value = false;
    }
  }

  Future put(
    String path, {
    dynamic body,
    bool? isDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    RxBool? loader,
  }) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();
      var response = await dio.put(
        path,
        data: isDecode == false ? body : d.FormData.fromMap(body),
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return response.data;
    } finally {
      loader?.value = false;
    }
  }

  Future delete(
    String path, {
    dynamic body,
    bool? isDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    RxBool? loader,
  }) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();

      var response = await dio.delete(
        path,
        data: isDecode == false ? body : d.FormData.fromMap(body),
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return response.data;
    } finally {
      loader?.value = false;
    }
  }

  Future patch(
    String path, {
    d.FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    RxBool? loader,
  }) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();

      var response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return response.data;
    } finally {
      loader?.value = false;
    }
  }

  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
    RxBool? loader,
  }) async {
    loader?.value = true;
    try {
      Options requestOptions = options ?? Options();

      requestOptions.headers!.addAll({
        Headers.contentLengthHeader: dataLength.toString(),
      });
      var response = await dio.post(
        path,
        data: Stream.fromIterable(data.map((e) => [e])),
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return response.data;
    } finally {
      loader?.value = false;
    }
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  VoidCallback? callBack;

  ErrorEntity({
    required this.code,
    required this.message,
    this.callBack,
  });

  @override
  String toString() {
    callBack != null ? callBack!() : null;
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
