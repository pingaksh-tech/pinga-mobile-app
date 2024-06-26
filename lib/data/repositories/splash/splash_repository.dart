import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../controller/predefine_value_controller.dart';
import '../../../exports.dart';
import '../../../view/splash/splash_controller.dart';
import '../../model/common/splash_model.dart';

class SplashRepository {
  SplashRepository._();

  /// ***********************************************************************************
  ///                             GET SPLASH DATA API
  /// ***********************************************************************************

  static Future<dynamic> getSplashDataAPI({RxBool? isLoader, required void Function() navigation}) async {
    ///
    if (await getConnectivityResult()) {
      if (isRegistered<SplashController>()) {
        final SplashController splashCon = Get.find<SplashController>();

        try {
          isLoader?.value = true;
          PackageInfo packageInfo = await getPackageInfo();
          await APIFunction.getApiCall(
            apiUrl: ApiUrls.splashGET(versionCode: packageInfo.version),
          ).then(
            (response) async {
              if (response != null) {
                isLoader?.value = false;

                final GetSplashModel model = GetSplashModel.fromJson(response);

                if (!isValEmpty(model.data)) {
                  // ***********************************************************************************
                  //                                    COMMON DETAILS
                  // ***********************************************************************************

                  if (isRegistered<PreDefinedValueController>()) {
                    final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
                    preValueCon.categoryWiseSizesList.value = model.data!.categoryWiseSizes ?? [];
                    preValueCon.metalsList.value = model.data!.metals ?? [];
                    preValueCon.diamondsList.value = model.data!.diamonds ?? [];
                  }

                  // ***********************************************************************************
                  //                                    APP CONFIG DETAILS
                  // ***********************************************************************************
                  if (!isValEmpty(model.data!.appConfigData) && (model.data!.appConfigData!.appConfigs ?? []).isNotEmpty && !isValEmpty(model.data!.appConfigData!.appConfigs![0].appConfigDetails)) {
                    /// App Configurations
                    AppConfigDetails appConfig = model.data!.appConfigData!.appConfigs![0].appConfigDetails!;

                    /// Store App Configs to Local Storage
                    LocalStorage.privacyURL = appConfig.privacy;
                    LocalStorage.termsURL = appConfig.terms;
                    LocalStorage.aboutUsURL = appConfig.aboutUs;
                    LocalStorage.contactUsURL = appConfig.contactUs;
                    LocalStorage.contactMobileNumber = appConfig.contactMobileNumber;
                    LocalStorage.contactEmailID = appConfig.contactEmailId;
                  }

                  if (!isValEmpty(model.data!.appConfigData!.versions)) {
                    /// Versions

                    /// CHECKING UPDATE
                    splashCon.inAppUpdateChecker(appMaintenanceModel: model.data?.appConfigData!.appMaintenance, currentVersion: packageInfo.version, versions: model.data!.appConfigData!.versions!);
                  } else {
                    navigation();
                  }
                }
              }
              isLoader?.value = false;

              return response;
            },
          );
        } catch (e) {
          navigation();
          isLoader?.value = false;
          printErrors(type: "getSplashDataAPI", errText: e);
        }
      } else {
        navigation();
      }
    } else {
      navigation();
    }
  }

  static Map<String, dynamic> dummyJson = {
    "success": true,
    "message": "Data retrieved successfully",
    "data": {
      "app-maintenance": {
        "under_maintenance": false,
        "title": "WHOLE APP UNDER MAINTENANCE",
        "message": "UNDER MAINTENANCE",
      },
      "app_config": [
        {
          "_id": "1",
          "default_config": true,
          "app_config": {
            "primary": "#FFFFFF",
            "theme_mode": "light",
            "privacy": "https://example.com/privacy",
            "terms": "https://example.com/terms",
            "about_us": "https://example.com/about",
            "play_store_link": "https://play.google.com/store/apps/details?id=com.example",
            "app_store_link": "https://apps.apple.com/app/id123456789",
            "contact_us": "https://example.com/contact",
            "contact_mobile_number": "+91234567890",
            "contact_email_id": "support@example.com",
          },
          "type": "general",
          "createdAt": "2023-01-01T00:00:00Z",
          "updatedAt": "2023-01-02T00:00:00Z"
        }
      ],
      "android": [
        {"_id": "v1", "version": "1.0.0", "force_update": false, "soft_update": true, "maintenance": false, "maintenance_msg": "", "type": "stable", "createdAt": "2023-01-01T00:00:00Z", "updatedAt": "2023-01-02T00:00:00Z"},
        {"_id": "v2", "version": "1.1.5", "force_update": false, "soft_update": true, "maintenance": false, "maintenance_msg": "Maintenance ongoing", "type": "beta", "createdAt": "2023-02-01T00:00:00Z", "updatedAt": "2023-02-02T00:00:00Z"}
      ],
      "ios": [
        {"_id": "v1", "version": "1.0.0", "force_update": false, "soft_update": false, "maintenance": false, "maintenance_msg": "Maintenance ongoing", "type": "stable", "createdAt": "2023-01-01T00:00:00Z", "updatedAt": "2023-01-02T00:00:00Z"},
        {"_id": "v2", "version": "1.1.0", "force_update": false, "soft_update": false, "maintenance": false, "maintenance_msg": "Maintenance ongoing", "type": "beta", "createdAt": "2023-02-01T00:00:00Z", "updatedAt": "2023-02-02T00:00:00Z"}
      ]
    }
  };
}
