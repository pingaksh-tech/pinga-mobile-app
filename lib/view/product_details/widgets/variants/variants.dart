import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_network_image.dart';
import '../../../../widgets/plus_minus_title/plus_minus_tile.dart';
import '../../../../widgets/product_tile.dart';
import '../../../../widgets/size_selector/size_selector_botton.dart';
import 'variants_controller.dart';

class VariantsTab extends StatelessWidget {
  VariantsTab({super.key});

  final VariantsController con = Get.put(VariantsController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding).copyWith(top: 48),
      itemCount: con.variantList.length,
      itemBuilder: (context, index) => ProductTile(
        onTap: () {},
        productTileType: ProductTileType.variant,
        imageUrl: "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
        productName: con.variantList[index].name ?? "",
        productPrice: con.variantList[index].price.toString(),
        productQuantity: con.variantList[index].quantity,
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
            Expanded(
              flex: 2,
              child: AppNetworkImage(
                imageUrl: image ?? "",
                height: 44.h,
                width: 44.h,
                borderRadius: BorderRadius.circular(defaultRadius / 2),
              ),
            ),
            6.horizontalSpace,
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    title ?? "",
                    overflow: TextOverflow.ellipsis,
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
                  4.verticalSpace,

                  Row(
                    children: [
                      /// Size Selector
                      horizontalSelectorButton(
                        context,
                        isFlexible: true,
                        selectedSize: productSize,
                        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                        selectableItemType: SelectableItemType.size,
                        axisDirection: Axis.vertical,
                      ),
                      8.horizontalSpace,

                      /// Color Selector
                      horizontalSelectorButton(
                        context,
                        isFlexible: true,
                        selectedColor: productColor,
                        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                        selectableItemType: SelectableItemType.color,
                        axisDirection: Axis.vertical,
                      ),
                      8.horizontalSpace,

                      /// Diamond Selector
                      horizontalSelectorButton(
                        context,
                        isFlexible: true,
                        selectedDiamond: ''.obs,
                        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                        selectableItemType: SelectableItemType.diamond,
                        axisDirection: Axis.vertical,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Plus minus tile
            Expanded(
              flex: 4,
              child: plusMinusTile(
                context,
                size: 20.h,
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
            )
          ],
        ),
      );
    });
  }
}
