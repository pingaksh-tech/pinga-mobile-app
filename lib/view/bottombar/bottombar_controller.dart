import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/model/bottombar/bottombar_model.dart';
import '../../exports.dart';

class BottomBarController extends GetxController {
  RxInt currentBottomIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingLatLng = false.obs;

  List<BottomBarModel> bottomBarDataList = <BottomBarModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    bottomBarDataList.clear();
    bottomBarDataList.insert(
      0,
      BottomBarModel(
        screenName: "Home",
        bottomItem: BottomItem(
          selectedImage: AppAssets.home,
        ),
        screenWidget: Container(),
      ),
    );
    bottomBarDataList.insert(
      1,
      BottomBarModel(
        screenName: "Cart",
        bottomItem: BottomItem(
          selectedImage: AppAssets.cart,
        ),
        screenWidget: Container(),
      ),
    );
    bottomBarDataList.insert(
      2,
      BottomBarModel(
        screenName: "Orders",
        bottomItem: BottomItem(
          selectedImage: AppAssets.orders,
        ),
        screenWidget: Container(),
      ),
    );

    bottomBarDataList.insert(
      3,
      BottomBarModel(
        screenName: "Profile",
        bottomItem: BottomItem(
          selectedImage: AppAssets.profile,
        ),
        screenWidget: Container(),
      ),
    );
  }

  SharedAxisTransitionType? transitionType = SharedAxisTransitionType.horizontal;
  RxBool isLoggedIn = true.obs;

  void onBottomBarTap(int i, {bool? hapticFeedback = false}) async {
    if (currentBottomIndex.value != i) {
      currentBottomIndex.value = i;
      currentBottomIndex.value > 0 ? (currentBottomIndex.value < 0 ? isLoggedIn.value = false : (currentBottomIndex.value != bottomBarDataList.length - 1 ? isLoggedIn.value = true : isLoggedIn.value = false)) : isLoggedIn.value = false;
      if (hapticFeedback == true) {
        HapticFeedback.mediumImpact();
      }

      if (i == 1) {
        // await CartRepository.cartListApi();
      }

      if (i == 2) {
        // await OrderRepository.orderProductApi(isInitial: true);
      }
      if (i == 4) {
        // await ProfileRepository().profileApi();
      }
    }
  }

  Positioned? position;

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
