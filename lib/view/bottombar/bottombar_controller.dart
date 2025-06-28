import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/model/bottombar/bottombar_model.dart';
import '../../exports.dart';
import '../cart/cart_screen.dart';
import '../collections/watch_list/watch_list_screen.dart';
import '../home/home_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';

class BottomBarController extends GetxController {
  RxInt currentBottomIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingLatLng = false.obs;

  RxList<BottomBarModel> bottomBarDataList = <BottomBarModel>[
    BottomBarModel(
      screenName: "Home",
      bottomItem: BottomItem(
        selectedImage: AppAssets.homeOutlinedSVG,
      ),
      screenWidget: HomeScreen(),
    ),
    BottomBarModel(
      screenName: "Watchlist",
      bottomItem: BottomItem(
        selectedImage: AppAssets.watchlistFilled,
      ),
      screenWidget: WatchListScreen(),
    ),
    BottomBarModel(
      screenName: "Cart",
      bottomItem: BottomItem(
        selectedImage: AppAssets.cart,
      ),
      screenWidget: CartScreen(),
    ),
    BottomBarModel(
      screenName: "Orders",
      bottomItem: BottomItem(
        selectedImage: AppAssets.orders,
      ),
      screenWidget: OrdersScreen(),
    ),
    BottomBarModel(
      screenName: "Profile",
      bottomItem: BottomItem(
        selectedImage: AppAssets.profile,
      ),
      screenWidget: ProfileScreen(),
    ),
  ].obs;

  SharedAxisTransitionType? transitionType = SharedAxisTransitionType.horizontal;
  RxBool isLoggedIn = true.obs;

  void onBottomBarTap(int i, {bool? hapticFeedback = false}) async {
    if (currentBottomIndex.value != i) {
      currentBottomIndex.value = i;
      currentBottomIndex.value > 0 ? (currentBottomIndex.value < 0 ? isLoggedIn.value = false : (currentBottomIndex.value != bottomBarDataList.length - 1 ? isLoggedIn.value = true : isLoggedIn.value = false)) : isLoggedIn.value = false;
      if (hapticFeedback == true) {
        HapticFeedback.mediumImpact();
      }

      if (i == 1) {}

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
