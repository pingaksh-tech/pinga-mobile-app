import 'package:get/get.dart';

import '../../../../exports.dart';

class SettingsController extends GetxController {
  RxBool isOn = false.obs;

  RxList<Map> settingMenu = [
    {
      "title": "Light Mode",
      "icon": AppAssets.lightModeSVG,
      "icon_height": 23.0,
      "subtitle": "",
      "isTrue": false.obs,
    },
    {
      "title": "Product Detail",
      "icon": AppAssets.productDetailSVG,
      "icon_height": 21.0,
      "subtitle": "",
      "isTrue": false.obs,
    },
    {
      "title": "Price Breakup",
      "icon": AppAssets.priceBreakupSVG,
      "icon_height": 21.0,
      "subtitle": "",
      "isTrue": false.obs,
    },
    {
      "title": "Live Gold Price",
      "icon": AppAssets.goldPriceSVG,
      "icon_height": 23.0,
      "subtitle": "(Applicable for only Oro Kraft Product)",
      "isTrue": false.obs,
    },
    {
      "title": "MRP Bifurcation",
      "icon": AppAssets.mrpBifurcationSVG,
      "icon_height": 23.0,
      "subtitle": "(Applicable for only Oro Kraft Product)",
      "isTrue": false.obs,
    },
    {
      "title": "Distributor Price",
      "icon": AppAssets.distributorPriceSVG,
      "icon_height": 23.0,
      "subtitle": "(Applicable for only Oro Kraft Product)",
      "isTrue": false.obs,
    },
  ].obs;
}
