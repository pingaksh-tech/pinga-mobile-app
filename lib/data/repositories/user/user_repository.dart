import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/profile/profile_controller.dart';
import '../../model/user/profile_model.dart';
import '../../model/user/user_model.dart';

class ProfileRepository {
  /// ***********************************************************************************
  ///                                 GET USER API
  /// ***********************************************************************************

  static Future<dynamic> getUserDetailAPI({RxBool? isLoader, required String userId}) async {
    ///
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.getUserAPI(userId: userId),
          loader: isLoader,
        ).then(
          (response) async {
            if (response != null) {
              GetUserModel model = GetUserModel.fromJson(response);
              if (isRegistered<ProfileController>()) {
                final ProfileController con = Get.find<ProfileController>();
                con.userDetail.value = model.data ?? UserModel();
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
        printErrors(type: "getUserAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                 UPDATE USER API
  /// ***********************************************************************************
  static Future<dynamic> updateProfileApi({
    RxBool? isLoader,
    String? userImagePath,
  }) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        return await APIFunction.putApiCall(
          apiUrl: ApiUrls.updateUserAPI,
          body: dio.FormData.fromMap(
            {
              "user_image": await dio.MultipartFile.fromFile(
                userImagePath ?? "",
                filename: userImagePath?.split("/").last,
              )
            },
          ),
        ).then(
          (response) async {
            if (response != null) {
              GetUserModel model = GetUserModel.fromJson(response);
              if (isRegistered<ProfileController>()) {
                final ProfileController con = Get.find<ProfileController>();
                con.userDetail.value = model.data ?? UserModel();
              }
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
/*  !isValEmpty(userImagePath)
                ? {
                    "user_image": await dio.MultipartFile.fromFile(
                      userImagePath ?? "",
                      filename: userImagePath?.split("/").last,
                    )
                  }
                : null, */