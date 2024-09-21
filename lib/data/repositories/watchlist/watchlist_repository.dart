import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../exports.dart';
import '../../../view/collections/watch_list/components/watch_pdf_viewer/watch_pdf_controller.dart';
import '../../../view/collections/watch_list/watch_list_controller.dart';
import '../../../view/drawer/widgets/wishlist/wishlist_controller.dart';
import '../../model/watchlist/single_watchlist_model.dart';
import '../../model/watchlist/watchlist_model.dart';

class WatchListRepository {
  /// ***********************************************************************************
  ///                                     CREATE WATCHLIST API
  /// ***********************************************************************************

  static Future<void> createWatchlistAPI({
    required ProductsListType productListType,
    required String inventoryId,
    required String watchlistName,
    required int quantity,
    required String metalId,
    required String sizeId,
    required String diamondClarity,
    String? remark,
    List<Map<String, dynamic>>? diamonds,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createAndGetWatchlistAPI,
          body: {
            "name": watchlistName,
            "inventory_id": inventoryId,
            "quantity": quantity,
            "metal_id": metalId,
            if (!isValEmpty(sizeId)) "size_id": sizeId,
            if (!isValEmpty(diamondClarity)) "diamond_clarity": diamondClarity,
            if (!isValEmpty(diamonds)) "diamonds": diamonds,
            if (!isValEmpty(remark)) "remark": remark,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              /// Get watchList api
              await getWatchListAPI();

              if (response['data'] != null) {
                if (productListType == ProductsListType.wishlist) {
                  if (isRegistered<WishlistController>()) {
                    final WishlistController wishlistCon =
                        Get.find<WishlistController>();

                    int index = wishlistCon.productsList.indexWhere(
                        (element) => element.inventoryId == inventoryId);
                    if (index != -1) {
                      wishlistCon.productsList.removeAt(index);
                    }
                  }
                }
              }
              UiUtils.toast("Product add in watchlist Successfully");
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     GET WATCHLIST API
  /// ***********************************************************************************

  static Future<void> getWatchListAPI({
    String? searchText,
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    final WatchListController con = Get.find<WatchListController>();

    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.watchList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createAndGetWatchlistAPI,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
            "search": searchText,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetWatchListModel model = GetWatchListModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.watchList.value = model.data?.watchLists ?? [];
                } else {
                  con.watchList.addAll(model.data?.watchLists ?? []);
                }

                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailable.value =
                    currentPage < (model.data!.totalPages ?? 0);
                con.page.value += currentPage;
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     DELETE WATCHLIST API
  /// ***********************************************************************************

  static Future<void> deleteWatchlistAPI({
    required String watchlistId,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.deleteApiCall(
          apiUrl:
              ApiUrls.getAndDeleteSingleWatchListAPI(watchlistId: watchlistId),
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSingleWatchlistModel model =
                  GetSingleWatchlistModel.fromJson(response);

              if (model.data != null) {
                if (isRegistered<WatchListController>()) {
                  final WatchListController con =
                      Get.find<WatchListController>();

                  int index = con.watchList.indexWhere(
                      (element) => element.id?.value == watchlistId);
                  if (index != -1) {
                    con.watchList.removeAt(index);
                  }
                }
                Get.back();
                UiUtils.toast("Watchlist deleted successfully");
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "deleteWatchlistAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                ADD CART TO WATCHLIST API
  /// ***********************************************************************************
  static Future<dynamic> addCartToWatchlistAPI({
    RxBool? isLoader,
    required String watchlistName,
    required List<String> cartIds,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.postApiCall(
          apiUrl: ApiUrls.cartToWatchlistPOST,
          body: {
            "name": watchlistName,
            "cartIds": cartIds,
          },
        ).then(
          (response) async {
            if (response != null) {
              /// Get WatchList api
              await getWatchListAPI();
            }
            isLoader?.value = false;
            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "addCartToWatchlistAPI", errText: e);
      }
    }
  }

  static CancelToken cancelToken = CancelToken();
  // Method to cancel the request
  static void cancelDownloadRequest() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
    // Create a new CancelToken for future requests
    cancelToken = CancelToken();
  }

  // Method to reset the request
  static void resetDownloadRequest() {
    cancelToken = CancelToken();
  }

  static Future<void> downloadWatchAPI({
    required String title,
    required String watchId,
    RxBool? loader,
  }) async {
    cancelToken = CancelToken();
    if (await getConnectivityResult()) {
      // Create a cancel token
      loader?.value = true;
      try {
        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.downloadWatchCatalogueGET(watchId: watchId),
          options: Options(
            headers: {
              "Content-Type": "application/pdf",
              "Authorization": "Bearer ${LocalStorage.accessToken}",
            },
            responseType: ResponseType.bytes, // Set the response type to bytes
          ),
          cancelToken: cancelToken,
          loader: loader,
        ).then(
          (response) async {
            // If the request was cancelled, skip processing the response.
            if (cancelToken.isCancelled) {
              loader?.value = false; // Stop loader
              return; // Skip further execution
            }
            if (response != null) {
              // Get the app's document directory
              Directory appDocDir = await getTemporaryDirectory();
              String appDocPath = appDocDir.path;
              Directory catalogueDir = Directory("$appDocPath/catalogue");

              if (!await catalogueDir.exists()) {
                await catalogueDir.create();
              }

              // Create a file path
              String filePath = '${catalogueDir.path}/$title.pdf';

              // Write the response data to a file
              File file = File(filePath);
              await file.writeAsBytes(
                  response); // Directly use response as it is Uint8List

              printOkStatus('File saved at $filePath');

              if (Get.currentRoute == AppRoutes.watchpdfViewerScreen) {
                Get.back();
              }

              /// Open the PDF if the request was not canceled
              await OpenFile.open(file.path).whenComplete(() {
                // Get.back();
              });

              if (isRegistered<WatchPdfController>()) {
                final WatchPdfController con = Get.find<WatchPdfController>();
                con.pdfFile = file;
                con.isDownloading.value = false;
                printYellow(con.pdfFile);
                printYellow(await con.pdfFile.exists());
              }

              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          printYellow('Request cancelled');
        } else {
          // Handle other errors
          if (e.response != null) {
            if (e.response!.statusCode == 502) {
              printYellow('Received a 502 Bad Gateway error');
            } else {
              printYellow(
                  'DioException response: ${e.response!.statusCode} - ${e.response!.statusMessage}');
            }
          } else {
            printYellow('DioException error: ${e.message}');
          }
        }

        loader?.value = false; // Ensure loader stops on error
      } finally {
        // Ensure loader stops on completion or error
        loader?.value = false;
        // Reset cancelToken
      }
    } else {}
  }
}
