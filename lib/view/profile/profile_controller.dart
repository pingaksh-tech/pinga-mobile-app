import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  dynamic userDetails;
  // Rx<UserProfileModel> userDetails = UserProfileModel().obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   ProfileRepository().profileApi();
  // }
}
