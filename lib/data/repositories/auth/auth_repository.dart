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
  }) async {
    try {
      loader?.value = true;

      await APIFunction.postApiCall(
        apiUrl: ApiUrls.sendMobileOtpPOST,
        body: {
          "phone": mobileNumber,
        },
      ).then(
        (response) async {
          if (!isValEmpty(response) && response["success"] == true) {
            UserDataModel userDataModel=userDataModelFromJson(jsonEncode(response));
            loader?.value = false;
            UiUtils.toast(AppStrings.otpSendSuccessfully);


          }else{
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



  /// ***********************************************************************************
  ///                                   RESEND OTP API
  /// ***********************************************************************************

  static Future<dynamic> resendOtpToMobileNumAPI({required String userMobileNumber, RxBool? isLoader}) async {
    try {
      isLoader?.value = true;
      await APIFunction.postApiCall(
        apiUrl: ApiUrls.resendMobileOtpPOST,
        body: {
          "mobile": userMobileNumber,
        },
      ).then(
        (response) async {
          if (!isValEmpty(response['message'])) UiUtils.toast(response['message']);
          if (response != null && response['success'] == true) {}
          isLoader?.value = false;
          return response;
        },
      );
    } catch (e) {
      printErrors(type: "resendOtpToMobileNumAPI", errText: "$e");
    } finally {
      isLoader?.value = false;
    }
  }

  /// ***********************************************************************************
  ///                                   VERIFY OTP API
  /// ***********************************************************************************

  static Future<dynamic> verifyMobileOtpAPI({required String userMobileNumber, required String otp, RxBool? isLoader}) async {
    try {
      isLoader?.value = true;
      await ApiUtils.devicesInfo();
      await APIFunction.postApiCall(
        apiUrl: ApiUrls.verifyMobileOtpPOST,
        body: {
          "mobile": userMobileNumber,
          "otp": otp,
          "device_info": await ApiUtils.devicesInfo(),
        },
      ).then(
        (response) async {
          if (response != null && response['success'] == true) {
            UiUtils.toast(AppStrings.otpVerificationSuccessfully);

            /* if (response['data'] != null && response['data']['data'] != null) {
              Map userData = response['data']['data'];

              bool isAlreadyExists = (userData['is_username'] ?? false);
              if (isAlreadyExists) {
                /// LOGIN ACTIVITY
                LocalStorage.storeUserDetails(
                  userID: userData['_id'] ?? "",
                  mobile: userData['mobile'] ?? "",
                  userNAME: userData['user_name'] ?? "",
                  referralCODE: userData['referral_code'] ?? "",
                  userIMAGE: userData['image'] ?? "",
                  accessTOKEN: response['data']['token'] ?? "",
                  myBALANCE: userData['my_balance'] ?? "",
                );

                Get.offAllNamed(AppRoutes.bottomNavBarScreen);
              } else {
                /// REGISTER REQUIRED

                /// Navigate to add user_name and referral code screen
                Get.toNamed(AppRoutes.addUserNameScreen, arguments: {
                  "mobileNumber": userMobileNumber,
                  "accessToken": response['data']['token'] ?? "",
                });
              }
            }*/
          } else {
            if (!isValEmpty(response['message'])) UiUtils.toast(response['message']);
          }

          isLoader?.value = false;
          return response;
        },
      );
    } catch (e) {
      printErrors(type: "verifyMobileOtpAPI", errText: "$e");
    } finally {
      isLoader?.value = false;
    }
  }

  /// ***********************************************************************************
  ///                                   LOG-OUT API
  /// ***********************************************************************************

  static Future<bool> logOutAPI({
    RxBool? loader,
  }) async {
    try {
      loader?.value = true;

      return await APIFunction.postApiCall(
        apiUrl: ApiUrls.logOutPOST,
      ).then(
        (response) async {
          if (response != null && response['success'] == true) {
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
  }

  /// ***********************************************************************************
  ///                                 DELETE ACCOUNT API
  /// ***********************************************************************************

  static Future<bool> deleteAccountAPI({
    RxBool? loader,
    Function()? onSuccess,
  }) async {
    try {
      loader?.value = true;

      return await APIFunction.deleteApiCall(
        apiUrl: ApiUrls.deleteAccountDELETE,
      ).then(
        (response) async {
          if (response != null && response['success'] == true) {
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
  }
}
