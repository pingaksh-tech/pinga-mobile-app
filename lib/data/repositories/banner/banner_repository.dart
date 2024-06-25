import 'package:get/get.dart';
import '../../../exports.dart';

import '../../../view/home/home_controller.dart';
import '../../model/banner/banner_model.dart';

class BannerRepository {
  /// ***********************************************************************************
  ///                                 GET BANNERS API
  /// ***********************************************************************************

  static Future<dynamic> getBannersAPI({RxBool? isLoader}) async {
    ///
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getAllBannersGET,
          loader: isLoader,
        ).then(
          (response) async {
            if (response != null) {
              if (isRegistered<HomeController>()) {
                final HomeController homeCon = Get.find<HomeController>();

                GetBannersModel model = GetBannersModel.fromJson(response);
                homeCon.bannersList.value = model.banners ?? [];
              }
              isLoader?.value = false;
            } else {
              isLoader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "getCategoriesAPI", errText: e);
      }
    } else {}
  }
}
