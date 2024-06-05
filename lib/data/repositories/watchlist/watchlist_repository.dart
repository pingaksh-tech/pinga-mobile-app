import 'package:get/get.dart';
import '../../model/watchlist/watchlist_model.dart';
import '../../../exports.dart';
import '../../../view/collections/watch_list/watch_list_controller.dart';
import '../../../view/collections/widgets/add_watchlist/add_watchlist_controller.dart';

class WatchlistRepository {
  /// ***********************************************************************************
  ///                                       WATCH LIST
  /// ***********************************************************************************
  static Map<String, dynamic> demoData = {
    "success": true,
    "message": "Watchlist fetched",
    "data": [
      {"id": "watch1", "name": "Numun", "no_of_item": 33, "created_by": "Personal", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
      {"id": "watch2", "name": "Binks", "no_of_item": 42, "created_by": "Guest login", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
      {"id": "watch3", "name": "Joker", "no_of_item": 21, "created_by": "Guest login", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
      {"id": "watch4", "name": "Milli", "no_of_item": 33, "created_by": "Personal", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
      {"id": "watch5", "name": "Pinkness", "no_of_item": 42, "created_by": "Guest login", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
      {"id": "watch6", "name": "Enlighted", "no_of_item": 21, "created_by": "Guest login", "createdAt": "2023-01-01T12:00:00Z", "updatedAt": "2023-01-05T12:00:00Z"},
    ],
  };

  static Future<void> watchlistAPI({RxBool? isLoader}) async {
    if (isRegistered<AddWatchlistController>()) {
      final AddWatchlistController addWatchlistCon = Get.find<AddWatchlistController>();
      GetWatchlistModel model = GetWatchlistModel.fromJson(demoData /*response*/);
      addWatchlistCon.watchList.value = model.data ?? [];
    }

    if (isRegistered<WatchListController>()) {
      final WatchListController watchlistCon = Get.find<WatchListController>();
      GetWatchlistModel model = GetWatchlistModel.fromJson(demoData /*response*/);
      watchlistCon.watchList.value = model.data ?? [];
    }

    // try {
    //   isLoader?.value = true;
    //   await APIFunction.getApiCall(apiUrl: ApiUrls.wishlistGet).then(
    //     (response) async {
    //       GetWatchlistModel model = GetWatchlistModel.fromJson(response);
    //       addWatchlistCon.watchList.value = model.data ?? [];
    //     },
    //   );
    // } catch (e) {
    //   printErrors(type: "Error", errText: "$e");
    // } finally {
    //   isLoader?.value = false;
    // }
  }
}
