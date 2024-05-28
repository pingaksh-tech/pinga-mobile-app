import 'package:get/get.dart';

import '../../data/api/api_utils.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    ApiUtils.splashNavigation();
  }
}
