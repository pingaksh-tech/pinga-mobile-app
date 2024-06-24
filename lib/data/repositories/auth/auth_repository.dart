import 'dart:convert';

import 'package:get/get.dart';
import '../../../exports.dart';

import '../../api/api_utils.dart';
import '../../model/user/user_model.dart';

class AuthRepository {
  /// ***********************************************************************************
  ///                               SEND OTP TO PHONE NUMBER API
  /// ***********************************************************************************

  static Future<dynamic> sendOtpToPhoneNumberAPI({
    required String mobileNumber,
    RxBool? loader,
    required Function() onSuccess,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        await APIFunction.postApiCall(
          apiUrl: ApiUrls.sendMobileOtpPOST,
          loader: loader,
          body: {
            "phone": mobileNumber,
          },
        ).then(
          (response) async {
            if (!isValEmpty(response) /*&& response["success"] == true*/) {
              loader?.value = false;
              UiUtils.toast(AppStrings.otpSendSuccessfully);
              onSuccess();
            } else {
              loader?.value = false;
            }
            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "sendOtpToPhoneNumberAPI", errText: "$e");
      }
    }
  }

  /// ***********************************************************************************
  ///                                   RESEND OTP API
  /// ***********************************************************************************

  static Future<dynamic> resendOtpToMobileNumAPI({
    required String mobileNumber,
    RxBool? loader,
    required Function() onSuccess,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.resendMobileOtpPOST,
          loader: loader,
          body: {
            "phone": mobileNumber,
          },
        ).then(
          (response) async {
            loader?.value = false;
            if (!isValEmpty(response['message'])) UiUtils.toast(response['message']);
            if (!isValEmpty(response) /*&& response["success"] == true*/) {
              onSuccess();
            }
            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "resendOtpToMobileNumAPI", errText: "$e");
      }
    }
  }

  /// ***********************************************************************************
  ///                                   VERIFY OTP API
  /// ***********************************************************************************

  static Future<dynamic> verifyMobileOtpAPI({required String mobileNumber, required String otp, RxBool? loader}) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;
        await ApiUtils.devicesInfo();
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.verifyMobileOtpPOST,
          loader: loader,
          body: {
            "phone": mobileNumber,
            "otp": otp,
            "device_info": await ApiUtils.devicesInfo(),
          },
        ).then(
          (response) async {
            if (!isValEmpty(response) /*&& response["success"] == true*/) {
              UserDataModel userDataModel = userDataModelFromJson(jsonEncode(response));

              /// STORE USER DETAILS IN LOCAL STORAGE
              LocalStorage.userModel = userDataModel.data?.user;

              /// STORE ACCESS AND REFRESH TOKENS
              LocalStorage.accessToken = userDataModel.data?.tokens?.accessToken;
              LocalStorage.refreshToken = userDataModel.data?.tokens?.refreshToken;

              UiUtils.toast(AppStrings.loginSuccessfully);

              /// NAVIGATE TO BOTTOM-BAR SCREEN
              Get.offAllNamed(AppRoutes.bottomBarScreen);
              loader?.value = false;
            } else {
              if (!isValEmpty(response['message'])) UiUtils.toast(response['message']);
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "verifyMobileOtpAPI", errText: "$e");
      }
    }
  }

  /// ***********************************************************************************
  ///                                   LOG-OUT API
  /// ***********************************************************************************

  static Future<bool> logOutAPI({
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        return await APIFunction.postApiCall(
          apiUrl: ApiUrls.logOutPOST,
          loader: loader,
        ).then(
          (response) async {
            if (response != null /*&& response['success'] == true*/) {
              loader?.value = false;
              return true;
            }
            return false;
          },
        );
      } catch (e) {
        printErrors(type: "logOutAPI", errText: "$e");
        loader?.value = false;
        return false;
      } finally {}
    } else {
      return false;
    }
  }

  /// ***********************************************************************************
  ///                                 DELETE ACCOUNT API
  /// ***********************************************************************************

  static Future<bool> deleteAccountAPI({
    RxBool? loader,
    Function()? onSuccess,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        return await APIFunction.deleteApiCall(
          apiUrl: ApiUrls.deleteAccountDELETE,
          loader: loader,
        ).then(
          (response) async {
            if (response != null /*&& response['success'] == true*/) {
              loader?.value = false;

              /// onSuccess
              if (onSuccess != null) onSuccess();
              return true;
            }
            loader?.value = false;
            return false;
          },
        );
      } catch (e) {
        printErrors(type: "deleteAccountAPI", errText: "$e");
        loader?.value = false;
        return false;
      } finally {}
    } else {
      return false;
    }
  }
}
