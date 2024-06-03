import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../exports.dart';

class ProductDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  RxInt currentPage = 0.obs;
  Rx<PageController> imagesPageController = PageController().obs;
  RxList<String> productImages = [
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-wm_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-4_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-2_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-Y-3_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-R-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133-W-1_1800x1800.jpg?v=1715687553",
    "https://kisna.com/cdn/shop/files/KFLR11133_1800x1800.jpg?v=1715687513",
    "https://kisna.com/cdn/shop/files/our-promise-7-Days_adf02756-37a0-41e4-bc54-0a7ca584cfe2_1800x1800.webp?v=1715687519",
  ].obs;

  RxBool isLike = false.obs;

  RxList<Map<String, String>> productDetails = [
    {"Metal": "Gold"},
    {"Karatage": "18KT"},
    {"Metal Wt": "6.4"},
    {"Brand": "KISNA FG"},
    {"Category": "RINGS"},
    {"Collection": "Flora"},
    {"Default color": "Yellow"},
    {"Stone": "Diamond"},
    {"Stone quality": "VVS-FG"},
    {"Stone shape": "ROUND"},
    {"Stone Wt": "0.66"},
    {"Diamond quantity": "19"},
    {"Gross Wt": "6,53"},
    {"Approx delivery": "15 Days"}
  ].obs;

  Rx<Color>? selectedColor = Colors.yellow.obs;

  final List<Color> colors = [
    Colors.yellow, // Gold
    Colors.orange, // Silver
  ];

  /// ***********************************************************************************
  ///                                  TAB BAR CONTROLLER
  /// ***********************************************************************************

  late TabController tabController;

  /// TabBar Tab Listener
  void tabListerFunction() {
    tabController.addListener(
      () {
        if (tabController.indexIsChanging) {
          // printOkStatus("tab is animating. from active (getting the index) to inactive(getting the index) ");
        } else {
          printOkStatus("===>${tabController.index}");

          /// TAB CHANGE
          switch (tabController.index) {
            case 0:
            case 1:
            case 2:
          }
        }
      },
    );
  }

  /// ***********************************************************************************
  ///                                       onInit
  /// ***********************************************************************************

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  /// ***********************************************************************************
  ///                                       onReady
  /// ***********************************************************************************

  @override
  void onReady() {
    tabListerFunction();
    super.onReady();
  }

  /// ***********************************************************************************
  ///                                       onClose
  /// ***********************************************************************************

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
