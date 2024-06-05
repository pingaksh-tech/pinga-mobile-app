import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/model/product/product_colors_model.dart';
import '../data/model/product/product_diamond_model.dart';
import '../data/model/product/product_size_model.dart';
import '../exports.dart';
import '../res/app_network_image.dart';
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
  String selectedRemark = "";

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
              Align(
                alignment: Alignment.topRight,
                child: AppIconButton(
                  onPressed: () {},
                  size: 25.h,
                  icon: Icon(
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
                horizontalSelectorButton(
                  context,
                  selectedSize: RxString(sizeModel.size ?? ""),
                  selectableItemType: SelectableItemType.size,
                  sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                  sizeOnChanged: (value) {
                    /// Return Selected Size
                    if (value != null && (value.runtimeType == SizeModel)) {
                      sizeModel = (value as SizeModel);

                      printYellow(sizeModel);
                    }
                  },
                ),
                (defaultPadding / 4).horizontalSpace,
                horizontalSelectorButton(
                  context,
                  selectedColor: RxString(colorModel.color ?? ""),
                  selectableItemType: SelectableItemType.color,
                  sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                  colorOnChanged: (value) {
                    /// Return Selected Color
                    if (value != null && (value.runtimeType == ColorModel)) {
                      colorModel = (value as ColorModel);

                      printYellow(colorModel);
                    }
                  },
                ),
              ],
            ),
          ),
          (defaultPadding / 4).verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
            child: Row(
              children: [
                /// Diamond
                horizontalSelectorButton(
                  context,
                  selectedDiamond: "SOL".obs,
                  selectableItemType: SelectableItemType.diamond,
                  sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                  rubyOnChanged: (value) {
                    /// Return Selected Diamond
                    if (value != null && (value.runtimeType == Diamond)) {
                      diamondModel = (value as Diamond);

                      printYellow(diamondModel);
                    }
                  },
                ),
                (defaultPadding / 4).horizontalSpace,

                /// Remark
                horizontalSelectorButton(
                  context,
                  remarkSelected: selectedRemark.isNotEmpty.obs,
                  selectableItemType: SelectableItemType.remarks,
                  sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                  remarkOnChanged: (value) {
                    selectedRemark = value;
                    printOkStatus(selectedRemark);
                  },
                ),
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
                plusMinusTile(
                  context,
                  textValue: widget.productQuantity ?? RxInt(0),
                  onDecrement: (value) {
                    printYellow(value);
                    widget.productQuantity?.value = value;

                    printOkStatus(widget.productQuantity);
                  },
                  onIncrement: (value) {
                    printYellow(value);
                    widget.productQuantity?.value = value;

                    printOkStatus(widget.productQuantity);
                  },
                ),
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
        padding: EdgeInsets.all(defaultPadding / 1.5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
          boxShadow: defaultShadowAllSide,
        ),
        child: Row(
          children: [
            AppNetworkImage(
              height: Get.width * 0.18,
              width: Get.width * 0.18,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(defaultRadius),
              imageUrl: widget.imageUrl,
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: AppTextStyle.titleStyle(context).copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    UiUtils.amountFormat(widget.productPrice, decimalDigits: 0),
                    style: AppTextStyle.subtitleStyle(context),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  /// VARIANT TILE
  Widget variantView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(.15),
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(4.r),
        ),
      ),
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
                4.verticalSpace,

                Row(
                  children: [
                    /// Size Selector
                    horizontalSelectorButton(
                      context,
                      isFlexible: true,
                      selectedSize: RxString(sizeModel.size ?? ""),
                      sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                      selectableItemType: SelectableItemType.size,
                      axisDirection: Axis.vertical,
                      sizeOnChanged: (value) {
                        /// Return Selected Size
                        if (value != null && (value.runtimeType == SizeModel)) {
                          sizeModel = (value as SizeModel);

                          printYellow(sizeModel);
                        }
                      },
                    ),
                    8.horizontalSpace,

                    /// Color Selector
                    horizontalSelectorButton(
                      context,
                      isFlexible: true,
                      selectedColor: RxString(colorModel.color ?? ""),
                      sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                      selectableItemType: SelectableItemType.color,
                      axisDirection: Axis.vertical,
                      colorOnChanged: (value) {
                        /// Return Selected Color
                        if (value != null && (value.runtimeType == ColorModel)) {
                          colorModel = (value as ColorModel);

                          printYellow(colorModel);
                        }
                      },
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
                      rubyOnChanged: (value) {
                        /// Return Selected Diamond
                        if (value != null && (value.runtimeType == Diamond)) {
                          diamondModel = (value as Diamond);

                          printYellow(diamondModel);
                        }
                      },
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
              textValue: widget.productQuantity ?? RxInt(0),
              onDecrement: (value) {
                printYellow(value);
                widget.productQuantity?.value = value;

                printOkStatus(widget.productQuantity);
              },
              onIncrement: (value) {
                printYellow(value);
                widget.productQuantity?.value = value;

                printOkStatus(widget.productQuantity);
              },
            ),
          )
        ],
      ),
    );
  }
}
