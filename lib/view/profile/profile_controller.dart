import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString selectUserProfile = "".obs;
  RxBool isLoading = false.obs;
  dynamic userDetails;
  // Rx<UserProfileModel> userDetails = UserProfileModel().obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   ProfileRepository().profileApi();
  // }
}
