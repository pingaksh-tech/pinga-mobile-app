import 'package:get/get.dart';

import '../../../exports.dart';

class GlobalRateRepositories {
  /// ***********************************************************************************
  ///                                 UPDATE USER API
  /// ***********************************************************************************
  static Future<dynamic> updateRateApi({
    RxBool? isLoader,
    String? userRate,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.putApiCall(
          apiUrl: ApiUrls.setGlobalRatePOST,
          body: {
            "price_change_percentage": userRate,
          },
        ).then(
          (response) async {
            if (response != null) {
              isLoader?.value = false;
            }
            isLoader?.value = false;
            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "updateUser", errText: e);
      }
    }
  }
}
