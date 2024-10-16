import 'package:get/get.dart';

import '../../data/model/user/user_model.dart';
import '../../data/repositories/user/user_repository.dart';
import '../../exports.dart';

class ProfileController extends GetxController {
  RxString selectUserProfile = "".obs;
  RxBool isLoading = false.obs;

  Rx<UserModel> userDetail = UserModel().obs;
  RxBool isLoader = false.obs;
  @override
  void onReady() {
    super.onReady();
    ProfileRepository.getUserDetailAPI(
        userId: LocalStorage.userModel.id ?? "", isLoader: isLoading);
  }
}
