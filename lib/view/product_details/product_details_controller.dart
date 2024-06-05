import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/product/product_colors_model.dart';
import '../../data/model/product/product_diamond_model.dart';
import '../../data/model/product/product_size_model.dart';

class ProductDetailsController extends GetxController {
  Rx<ScrollController> scrollController = ScrollController().obs;

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

  Rx<SizeModel> selectedSize = SizeModel().obs;
  Rx<ColorModel> selectedColor = ColorModel().obs;
  Rx<Diamond> selectedDiamond = Diamond().obs;
  RxString selectedRemark = "".obs;

  final List<Color> colors = [
    Colors.yellow, // Gold
    Colors.orange, // Silver
  ];
}
