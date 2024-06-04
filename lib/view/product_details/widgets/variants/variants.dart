import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/variants/variants_controller.dart';

import '../../../../widgets/color_selector/color_selector_button.dart';
import '../../../../widgets/plus_minus_title/plus_minus_tile.dart';
import '../../../../widgets/size_selector/size_selector_botton.dart';

class VariantsTab extends StatelessWidget {
  VariantsTab({super.key});

  final VariantsController con = Get.put(VariantsController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding).copyWith(top: 48),
      itemCount: con.variantList.length,
      itemBuilder: (context, index) => variantDetailTile(
        context,
        image: "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
        title: con.variantList[index].name,
        price: con.variantList[index].price,
        quantity: con.variantList[index].quantity,
        productSize: con.variantList[index].sizeId,
        productColor: con.variantList[index].colorId,
      ),
    );
  }

  /// VARIANT DETAIL TILE
  Widget variantDetailTile(
    BuildContext context, {
    String? image,
    String? title,
    RxString? productSize,
    RxString? productColor,
    num? price,
    RxInt? quantity,
  }) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(.15),
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.r))),
        padding: EdgeInsets.all(defaultPadding / 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              imageUrl: image ?? "",
              height: 44.h,
              width: 44.h,
              borderRadius: BorderRadius.circular(defaultRadius / 2),
            ),
            6.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp, color: AppColors.font.withOpacity(.6)),
                ),

                /// PRICE
                Text(
                  UiUtils.amountFormat(price, decimalDigits: 0),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Row(
                    children: [
                      /// Size Selector
                      sizeSelectorButton(context, selectedSize: productSize ?? RxString("")),
                      6.horizontalSpace,

                      /// Color Selector
                      colorSelectorButton(context, selectedColor: productColor ?? RxString("")),
                      (defaultPadding / 2).horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.remarkScreen);
                        },
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding / 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius), color: Theme.of(context).scaffoldBackgroundColor),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                AppAssets.remarkOutlineIcon,
                                height: 14.h,
                                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                              ),
                              Text(
                                "RMK",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp, color: AppColors.primary),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),

            /// Plus minus tile
            plusMinusTile(
              context,
              textValue: quantity ?? RxInt(0),
              onDecrement: (value) {
                printYellow(value);
                quantity?.value = value;

                printOkStatus(quantity);
              },
              onIncrement: (value) {
                printYellow(value);
                quantity?.value = value;

                printOkStatus(quantity);
              },
            ),
          ],
        ),
      );
    });
  }
}
