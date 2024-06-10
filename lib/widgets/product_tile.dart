import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/model/cart/cart_model.dart';
import '../data/model/predefined_model/predefined_model.dart';
import '../exports.dart';
import '../res/app_dialog.dart';
import '../res/app_network_image.dart';
import '../res/pop_up_menu_button.dart';
import '../view/cart/cart_controller.dart';
import 'custom_check_box_tile.dart';
import 'plus_minus_title/plus_minus_tile.dart';
import 'size_selector/size_selector_botton.dart';

class ProductTile extends StatefulWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String productName;
  final String? categorySlug;
  final String productPrice;
  final bool isSizeAvailable;
  final RxInt? productQuantity;
  final String? brandName;
  final RxBool? isLike;
  final ProductTileType productTileType;
  final Function(bool)? likeOnChanged;
  final VoidCallback? deleteOnTap;
  final VoidCallback? cartDetailOnTap;
  final RxBool? isCartSelected;
  final void Function(bool?)? onChanged;
  final CartItemModel? item;

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
    this.brandName,
    this.deleteOnTap,
    this.cartDetailOnTap,
    this.categorySlug,
    this.isCartSelected,
    this.onChanged,
    this.isSizeAvailable = true,
    this.item,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  SizeModel sizeModel = SizeModel();
  SizeModel colorModel = SizeModel();
  SizeModel diamondModel = SizeModel();
  RxString selectedRemark = "".obs;
  RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: switch (widget.productTileType) {
        ProductTileType.grid => productGridTile(),
        ProductTileType.list => productListTile(),
        ProductTileType.variant => variantView(),
        ProductTileType.cartTile => productCartTile(),
      },
    );
  }

  /// GRID TILE
  Widget productGridTile() {
    return Obx(() {
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
                      switch (value) {
                        case "variants":
                          Get.toNamed(AppRoutes.variantsScreen, arguments: {
                            'isSize': widget.isSizeAvailable,
                            'category': widget.categorySlug,
                          });
                          break;
                        case "add to watchlist":
                          Get.toNamed(AppRoutes.addWatchListScreen);
                          break;
                      }
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
                  if (widget.isSizeAvailable) sizeSelector(categorySlug: widget.categorySlug ?? ''),
                  (defaultPadding / 4).horizontalSpace,

                  /// Diamond
                  diamondSelector(categorySlug: widget.categorySlug ?? ''),
                ],
              ),
            ),
            (defaultPadding / 4).verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
              child: Row(
                children: [
                  /// Color
                  colorSelector(categorySlug: widget.categorySlug ?? ''),
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
    });
  }

  /// LIST TILE
  Widget productListTile() {
    return Obx(() {
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
                            AppIconButton(
                              onPressed: () {
                                if (widget.isLike != null) {
                                  widget.isLike?.value = !widget.isLike!.value;

                                  if (widget.likeOnChanged != null) {
                                    widget.likeOnChanged!(widget.isLike!.value);
                                  }
                                }
                              },
                              icon: SvgPicture.asset(
                                widget.isLike?.value ?? false ? AppAssets.likeFill : AppAssets.like,
                                height: 19.sp,
                                width: 19.sp,
                                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
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
                    if (widget.isSizeAvailable) sizeSelector(direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
                    6.horizontalSpace,

                    /// Color Selector
                    colorSelector(direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
                    6.horizontalSpace,

                    /// Diamond Selector
                    diamondSelector(direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
                    6.horizontalSpace,

                    /// Remark Selector
                    remarkSelector(direction: Axis.vertical),
                    6.horizontalSpace,

                    /// Plus minus tile
                    incrementDecrementTile(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// VARIANT TILE
  Widget variantView() {
    return Obx(() {
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
                    8.verticalSpace,
                    Row(
                      children: [
                        /// Size Selector
                        if (widget.isSizeAvailable) sizeSelector(isFlexible: true, direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
                        6.horizontalSpace,

                        /// Color Selector
                        colorSelector(isFlexible: true, direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
                        6.horizontalSpace,

                        /// Diamond Selector
                        diamondSelector(isFlexible: true, direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
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
    });
  }

  Widget sizeSelector({bool isFlexible = false, Axis direction = Axis.horizontal, required String categorySlug}) {
    return horizontalSelectorButton(
      context,
      categorySlug: categorySlug,
      isFlexible: isFlexible,
      selectedSize: RxString(sizeModel.value ?? ""),
      sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
      selectableItemType: SelectableItemType.size,
      axisDirection: direction,
      sizeOnChanged: (value) async {
        /// Return Selected Size
        if ((value.runtimeType == SizeModel)) {
          sizeModel = value;

          printYellow(sizeModel);
        }
      },
    );
  }

  Widget colorSelector({bool isFlexible = false, Axis direction = Axis.horizontal, required String categorySlug}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        categorySlug: categorySlug,
        selectedColor: RxString(colorModel.value ?? ""),
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.color,
        axisDirection: direction,
        colorOnChanged: (value) {
          /// Return Selected Color
          if ((value.runtimeType == SizeModel)) {
            colorModel = value;

            printYellow(colorModel);
          }
        },
      );

  Widget diamondSelector({bool isFlexible = false, Axis direction = Axis.horizontal, required String categorySlug}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        categorySlug: categorySlug,
        selectedDiamond: RxString(diamondModel.value ?? ''),
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.diamond,
        axisDirection: direction,
        rubyOnChanged: (value) {
          /// Return Selected Diamond
          if ((value.runtimeType == SizeModel)) {
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

  Widget stockSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        selectableItemType: SelectableItemType.stock,
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        axisDirection: direction,
        productName: widget.productName.obs,
      );

  Widget productCartTile() {
    return Obx(
      () {
        final CartController cartCon = Get.find<CartController>();
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultPadding),
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.2, vertical: defaultPadding / 1.2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(defaultRadius),
              boxShadow: defaultShadowAllSide,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        widget.imageUrl.isNotEmpty
                            ? AppNetworkImage(
                                height: Get.width * 0.2,
                                width: Get.width * 0.2,
                                fit: BoxFit.cover,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(defaultRadius),
                                imageUrl: widget.imageUrl,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0.5,
                                    color: AppColors.lightGrey.withOpacity(0.5),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: Get.width * 0.25,
                                height: Get.width * 0.25,
                              ),
                        if (widget.isCartSelected != null)
                          Positioned(
                            top: -12.w,
                            left: -12.w,
                            child: CustomCheckboxTile(
                              isSelected: widget.isCartSelected!,
                              onChanged: widget.onChanged,
                            ),
                          ),
                      ],
                    ),
                    (defaultPadding / 2).horizontalSpace,
                    Expanded(
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.productName,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp),
                                        ),
                                        Text(
                                          "Brand: ${widget.brandName}",
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: defaultPadding, top: defaultPadding / 5),
                                          child: Text(
                                            UiUtils.amountFormat(widget.productPrice),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          AppIconButton(
                                            onPressed: () {
                                              AppDialogs.cartProductDetailDialog(context, productName: widget.productName);
                                            },
                                            size: 30.sp,
                                            icon: SvgPicture.asset(
                                              AppAssets.boxIcon,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).primaryColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                          (defaultPadding / 3).horizontalSpace,
                                          AppIconButton(
                                            onPressed: () {
                                              AppDialogs.cartDialog(
                                                context,
                                                onPressed: widget.deleteOnTap,
                                                buttonTitle: "NO",
                                                contentText: "Are you sure\nYou want to remove this item from the cart?",
                                              );
                                            },
                                            size: 30.sp,
                                            icon: SvgPicture.asset(
                                              AppAssets.deleteIcon,
                                              height: 17.h,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).primaryColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      (defaultPadding / 6).verticalSpace,
                                      plusMinusTile(
                                        context,
                                        item: widget.item,
                                        textValue: widget.productQuantity ?? RxInt(0),
                                        onIncrement: (value) {
                                          cartCon.incrementQuantity(widget.item ?? CartItemModel());
                                        },
                                        onDecrement: (value) {
                                          cartCon.decrementQuantity(widget.item ?? CartItemModel());
                                          widget.productQuantity?.value == 0
                                              ? AppDialogs.cartDialog(
                                                  context,
                                                  buttonTitle: "NO",
                                                  onPressed: widget.deleteOnTap,
                                                  contentText: "Are you sure\nYou want to remove this item from the cart?",
                                                )
                                              : null;
                                        },
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                (defaultPadding / 2).verticalSpace,
                Row(
                  children: [
                    if (widget.isSizeAvailable) sizeSelector(direction: Axis.vertical, isFlexible: true, categorySlug: widget.categorySlug ?? ''),
                    (defaultPadding / 4).horizontalSpace,
                    colorSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                      categorySlug: widget.categorySlug ?? '',
                    ),
                    (defaultPadding / 4).horizontalSpace,
                    diamondSelector(direction: Axis.vertical, isFlexible: true, categorySlug: widget.categorySlug ?? ''),
                    (defaultPadding / 4).horizontalSpace,
                    remarkSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                    ),
                    (defaultPadding / 4).horizontalSpace,
                    stockSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
