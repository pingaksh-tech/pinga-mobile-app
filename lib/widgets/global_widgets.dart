import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

Widget productPlaceHolderImage({bool showShadow = true, double? borderRadius}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius??defaultRadius / 1.5),
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      boxShadow: showShadow
          ? [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ]
          : [],
    ),
    child: SvgPicture.asset(
      AppAssets.productPlaceholderSVG,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      colorFilter: AppColors.iconColorFilter(opacity: 0.6),
    ),
  );
}
