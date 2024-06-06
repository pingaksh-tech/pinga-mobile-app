import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/model/product/product_colors_model.dart';
import '../data/model/product/product_diamond_model.dart';
import '../data/model/product/product_size_model.dart';
import '../exports.dart';
import '../res/app_network_image.dart';
import '../res/pop_up_menu_button.dart';
import 'plus_minus_title/plus_minus_tile.dart';
import 'size_selector/size_selector_botton.dart';

class ProductTile extends StatefulWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String productName;
  final String productPrice;
  final RxInt? productQuantity;
  final RxBool? isLike;
  final ProductTileType productTileType;
  final Function(bool)? likeOnChanged;

  const ProductTile({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    this.isLike,
    this.likeOnChanged,
    this.productQuantity,
    this.productTileType = ProductTileType.grid,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  SizeModel sizeModel = SizeModel();
  ColorModel colorModel = ColorModel();
  Diamond diamondModel = Diamond();
  RxString selectedRemark = "".obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: widget.onTap,
        child: switch (widget.productTileType) {
          ProductTileType.grid => productGridTile(),
          ProductTileType.list => productListTile(),
          ProductTileType.variant => variantView(),
        },
      );
    });
  }

  /// GRID TILE
  Widget productGridTile() {
    return Container(
      width: Get.width / 2 - defaultPadding * 1.5,
      margin: EdgeInsets.all(defaultPadding / 2),
      padding: EdgeInsets.all(defaultPadding / 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultRadius),
        boxShadow: defaultShadowAllSide,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: Get.width / 2 - defaultPadding * 2.5,
                child: AppNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(defaultRadius / 1.5),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  imageUrl: widget.imageUrl,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightGrey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(defaultPadding / 2),
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: defaultPadding / 2),
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Flora",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Positioned(
                top: defaultPadding / 2,
                right: defaultPadding / 2.4,
                child: AppPopUpMenuButton(
                  menuList: const ["Variants", "Add to Watchlist"],
                  onSelect: (value) {
                    printOkStatus(value);
                  },
                  child: Icon(
                    shadows: const [Shadow(color: AppColors.background, blurRadius: 4)],
                    Icons.more_vert_rounded,
                    size: 18.sp,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding / 4).copyWith(top: defaultPadding / 2, bottom: defaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Text(
                    widget.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  UiUtils.amountFormat(widget.productPrice),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
            child: Row(
              children: [
                /// Size
                sizeSelector(),
                (defaultPadding / 4).horizontalSpace,

                /// Color
                colorSelector(),
              ],
            ),
          ),
          (defaultPadding / 4).verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
            child: Row(
              children: [
                /// Diamond
                diamondSelector(),
                (defaultPadding / 4).horizontalSpace,

                /// Remark
                remarkSelector(),
              ],
            ),
          ),
          (defaultPadding / 4).verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6, vertical: defaultPadding / 6).copyWith(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AppButton(
                    flexibleWidth: true,
                    flexibleHeight: true,
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.06),
                    child: SvgPicture.asset(
                      widget.isLike?.value ?? false ? AppAssets.likeFill : AppAssets.like,
                      height: 19.sp,
                      width: 19.sp,
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      if (widget.isLike != null) {
                        widget.isLike?.value = !widget.isLike!.value;

                        if (widget.likeOnChanged != null) {
                          widget.likeOnChanged!(widget.isLike!.value);
                        }
                      }
                    },
                  ),
                ),
                (defaultPadding / 4).horizontalSpace,

                /// Increment / Decrement Tile
                incrementDecrementTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// LIST TILE
  Widget productListTile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2).copyWith(top: defaultPadding / 1.2),
      child: Container(
        padding: EdgeInsets.all(defaultPadding / 1.5).copyWith(top: 0, right: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
          boxShadow: defaultShadowAllSide,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AppNetworkImage(
                    imageUrl: widget.imageUrl,
                    height: 44.h,
                    width: 44.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                    padding: EdgeInsets.only(top: defaultPadding / 1.5),
                  ),
                ),
                6.horizontalSpace,
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: defaultPadding / 1.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE
                                  Text(
                                    widget.productName,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp, color: AppColors.font.withOpacity(.6)),
                                  ),

                                  /// PRICE
                                  Text(
                                    UiUtils.amountFormat(widget.productPrice, decimalDigits: 0),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// Plus minus tile
                          // incrementDecrementTile(height: 20.h),
                          Padding(
                            padding: EdgeInsets.only(right: defaultPadding / 2),
                            child: AppPopUpMenuButton(
                              menuList: const ["Variants", "Add to Watchlist"],
                              onSelect: (value) {
                                printOkStatus(value);
                              },
                              child: Icon(
                                shadows: const [Shadow(color: AppColors.background, blurRadius: 4)],
                                Icons.more_vert_rounded,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // 4.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
            (defaultPadding / 2).verticalSpace,

            ///
            Padding(
              padding: EdgeInsets.only(right: defaultPadding / 1.5),
              child: Row(
                children: [
                  /// Size Selector
                  sizeSelector(direction: Axis.vertical),
                  6.horizontalSpace,

                  /// Color Selector
                  colorSelector(direction: Axis.vertical),
                  6.horizontalSpace,

                  /// Diamond Selector
                  diamondSelector(direction: Axis.vertical),
                  6.horizontalSpace,

                  /// Remark Selector
                  remarkSelector(direction: Axis.vertical),
                  6.horizontalSpace,

                  incrementDecrementTile(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// VARIANT TILE
  Widget variantView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2).copyWith(top: defaultPadding / 1.2),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
          boxShadow: defaultShadowAllSide,
        ),
        // decoration: BoxDecoration(
        //   color: AppColors.background,
        //   border: Border.all(
        //     color: Theme.of(context).dividerColor.withOpacity(.15),
        //   ),
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(4.r),
        //   ),
        // ),
        padding: EdgeInsets.all(defaultPadding / 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: AppNetworkImage(
                imageUrl: widget.imageUrl,
                height: 44.h,
                width: 44.h,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(defaultRadius / 2),
              ),
            ),
            6.horizontalSpace,
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE
                            Text(
                              widget.productName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp, color: AppColors.font.withOpacity(.6)),
                            ),

                            /// PRICE
                            Text(
                              UiUtils.amountFormat(widget.productPrice, decimalDigits: 0),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      /// Plus minus tile
                      incrementDecrementTile(height: 20.h),
                    ],
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      /// Size Selector
                      sizeSelector(isFlexible: true, direction: Axis.vertical),
                      6.horizontalSpace,

                      /// Color Selector
                      colorSelector(isFlexible: true, direction: Axis.vertical),
                      6.horizontalSpace,

                      /// Diamond Selector
                      diamondSelector(isFlexible: true, direction: Axis.vertical),
                      6.horizontalSpace,

                      /// Remark Selector
                      remarkSelector(isFlexible: true, direction: Axis.vertical),
                    ],
                  ),
                  // 4.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sizeSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        selectedSize: RxString(sizeModel.size ?? ""),
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.size,
        axisDirection: direction,
        sizeOnChanged: (value) {
          /// Return Selected Size
          if ((value.runtimeType == SizeModel)) {
            sizeModel = value;

            printYellow(sizeModel);
          }
        },
      );

  Widget colorSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        selectedColor: RxString(colorModel.color ?? ""),
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.color,
        axisDirection: direction,
        colorOnChanged: (value) {
          /// Return Selected Color
          if ((value.runtimeType == ColorModel)) {
            colorModel = value;

            printYellow(colorModel);
          }
        },
      );

  Widget diamondSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        selectedDiamond: RxString(diamondModel.diamond ?? ''),
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.diamond,
        axisDirection: direction,
        rubyOnChanged: (value) {
          /// Return Selected Diamond
          if ((value.runtimeType == Diamond)) {
            diamondModel = value;

            printYellow(diamondModel);
          }
        },
      );

  Widget incrementDecrementTile({double? height}) => plusMinusTile(
        context,
        size: height,
        textValue: widget.productQuantity ?? RxInt(0),
        onDecrement: (value) {
          widget.productQuantity?.value = value;

          printOkStatus(widget.productQuantity);
        },
        onIncrement: (value) {
          widget.productQuantity?.value = value;

          printOkStatus(widget.productQuantity);
        },
      );

  Widget remarkSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        remarkSelected: selectedRemark,
        selectableItemType: SelectableItemType.remarks,
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        axisDirection: direction,
        remarkOnChanged: (value) {
          selectedRemark.value = value;
          printOkStatus(selectedRemark);
        },
      );
}
