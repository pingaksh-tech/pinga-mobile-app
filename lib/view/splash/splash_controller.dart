import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../data/api/api_utils.dart';
import '../../data/model/common/splash_model.dart';
import '../../data/repositories/splash/splash_repository.dart';
import '../../data/services/in_app_update/in_app_update_of_android.dart';
import '../../exports.dart';
import '../../res/app_dialog.dart';

class SplashController extends GetxController {
  RxBool isUpdating = false.obs;

  @override
  void onReady() {
    super.onReady();
    SplashRepository.getSplashDataAPI(navigation: ApiUtils.splashNavigation);
  }

  /// ***********************************************************************************
  ///                             IN-APP UPDATE CHECKER
  /// ***********************************************************************************

  Future<void> inAppUpdateChecker({AppMaintenanceModel? appMaintenanceModel, required List<VersionModel> versions, required String currentVersion}) async {
    if (versions.isNotEmpty) {
      /// Maintenance Module
      if (
          // Is App Not Under Maintenance
          !(appMaintenanceModel?.underMaintenance ?? false) &&
              // Are Versions Not Under Maintenance
              !(versions.firstWhereOrNull((element) => element.version == currentVersion)?.maintenance ?? false)) {
        ///
        /// App Update Module
        List<Map<String, Object>>? versionList = versions
            .map(
              (e) => {
                "versionComparison": currentVersion.compareTo(e.version ?? ""),
                "versionCode": e.version ?? "",
                "isForceUpdate": e.forceUpdate ?? false,
                "isSoftUpdate": e.softUpdate ?? false,
              },
            )
            .toList()
            .where((element) => element['versionComparison'] == -1)
            .toList();

        if (versionList.isNotEmpty) {
          /// Force Update
          bool isForceUpdate = versionList.where((element) => element["isForceUpdate"] == true).toList().isNotEmpty;
          printData(key: "Force Update length", value: versionList.where((element) => element["isForceUpdate"] == true).toList().length);

          /// Soft Update
          bool isSoftUpdate = versionList.where((element) => element["isSoftUpdate"] == true).toList().isNotEmpty;
          printData(key: "Soft Update length", value: versionList.where((element) => element["isSoftUpdate"] == true).toList().length);

          if (isForceUpdate) {
            /// Force Update

            printYellow("Force Update Available");

            if (Platform.isIOS) {
              AppDialogs.cupertinoAppUpdateDialog(
                Get.context!,
                isLoader: isUpdating,
                isForceUpdate: true,
                onUpdate: () async {
                  launchUrlFunction(Uri.parse(AppStrings.appStoreURL));
                },
              );
            } else if (Platform.isAndroid) {
              await checkAndroidAppUpdate(forceUpdate: true, softUpdate: false);
            } else {
              throw platformUnsupportedError;
            }
          } else if (isSoftUpdate) {
            /// Soft Update

            printYellow("Soft Update Available");

            if (Platform.isIOS) {
              AppDialogs.cupertinoAppUpdateDialog(
                Get.context!,
                isLoader: isUpdating,
                isForceUpdate: false,
                onLater: () => ApiUtils.splashNavigation(),
                onUpdate: () async {
                  launchUrlFunction(Uri.parse(AppStrings.appStoreURL));
                },
              );
            } else if (Platform.isAndroid) {
              await checkAndroidAppUpdate(forceUpdate: false, softUpdate: true);
            } else {
              throw platformUnsupportedError;
            }
          } else {
            printYellow("Custom Force Or Soft Update Variable Both Are false.");
            ApiUtils.splashNavigation();
          }
        } else {
          ApiUtils.splashNavigation();
        }
      } else {
        // Under Maintenance.
        printWarning("App is under Maintenance");
        String? currentVersionMaintenanceMsg = (versions.firstWhereOrNull((element) => element.version == currentVersion)?.maintenanceMessage);

        Get.offAllNamed(AppRoutes.underMaintenanceScreen, arguments: {
          "appMaintenanceModel": (appMaintenanceModel?.underMaintenance ?? false) ? appMaintenanceModel : AppMaintenanceModel(message: currentVersionMaintenanceMsg),
        });
      }
    } else {
      ApiUtils.splashNavigation();
    }
  }

  /// ***********************************************************************************
  ///                             ANDROID APP UPDATE CHECKER (NATIVE SHEETS)
  /// ***********************************************************************************

  Future<void> checkAndroidAppUpdate({bool forceUpdate = false, bool softUpdate = false}) async {
    await InAppUpdate.checkForUpdate().then((info) async {
      printData(key: "UpdateAvailability", value: info.updateAvailability);

      switch (info.updateAvailability) {
        /// Developer Triggered Update In Progress.
        case UpdateAvailability.developerTriggeredUpdateInProgress:
          await UiUtils.toast("Restart your app.");
          break;

        /// Update Availability Unknown.
        case UpdateAvailability.unknown:
          ApiUtils.splashNavigation();
          break;

        /// Update Available.
        case UpdateAvailability.updateAvailable:
          await AndroidInAppUpdate.showUpdateBottomSheet(forceUpdate: forceUpdate).then(
            (appUpdateResult) async {
              printWhite("appUpdateResult $appUpdateResult");
              switch (appUpdateResult) {
                case AppUpdateResult.success:
                  printOkStatus("...Success...");

                  break;

                case AppUpdateResult.userDeniedUpdate:
                  printTitle("User Denied Update");

                  if (forceUpdate == true) {
                    AppDialogs.materialAppUpdateDialog(
                      Get.context!,
                      isLoader: isUpdating,
                      isForceUpdate: true,
                      onLater: () => ApiUtils.splashNavigation(),
                      onUpdate: () async {
                        Get.back();
                        await checkAndroidAppUpdate(forceUpdate: forceUpdate, softUpdate: softUpdate);
                      },
                    );
                  } else {
                    ApiUtils.splashNavigation();
                  }

                  break;

                case AppUpdateResult.inAppUpdateFailed:
                  printTitle("In App Update Failed");

                  break;
              }
            },
          );
          break;

        /// Update Not Available.
        case UpdateAvailability.updateNotAvailable:
          ApiUtils.splashNavigation();
          break;
      }
    }).catchError((e) {
      printErrors(type: "checkForUpdate Function", errText: e);
    });
  }
}
