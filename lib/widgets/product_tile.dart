// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/predefine_value_controller.dart';
import '../data/model/cart/cart_model.dart';
import '../data/model/common/splash_model.dart';
import '../data/model/product/products_model.dart';
import '../data/model/sub_category/sub_category_model.dart';
import '../data/repositories/product/product_repository.dart';
import '../data/repositories/wishlist/wishlist_repository.dart';
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
  final Rx<SubCategoryModel>? category;
  RxString? selectSize;
  final String? inventoryId;
  final bool isFancy;
  final RxList<DiamondListModel>? diamondList;
  final String? categorySlug;
  final String productPrice;
  final bool isSizeAvailable;
  final RxInt? productQuantity;
  final String? brandName;
  final RxBool? isLike;
  final ProductTileType productTileType;
  final ProductsListType productsListTypeType;
  final Function(bool)? likeOnChanged;
  final VoidCallback? deleteOnTap;
  final VoidCallback? cartDetailOnTap;
  final RxBool? isCartSelected;
  final void Function(bool?)? onChanged;
  final CartModel? item;
  final void Function(int value)? incrementOnTap;
  final void Function(String value)? sizeId;
  final bool? isCart;
  final List<DiamondListModel>? diamonds;

  ProductTile({
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
    this.isFancy = false,
    this.cartDetailOnTap,
    this.categorySlug,
    this.isCartSelected,
    this.onChanged,
    this.isSizeAvailable = true,
    this.item,
    this.category,
    this.selectSize,
    this.incrementOnTap,
    this.sizeId,
    this.isCart = false,
    this.inventoryId,
    this.diamondList,
    this.diamonds,
    this.productsListTypeType = ProductsListType.normal,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Rx<DiamondModel> sizeModel = DiamondModel().obs;
  MetalModel metalModel = MetalModel();
  DiamondModel diamondModel = DiamondModel();
  RxString selectedRemark = "".obs;
  RxBool isSelected = false.obs;
  RxList<CartModel> cartList = <CartModel>[].obs;

  List<String> menuList = [/*AppStrings.variants,*/ AppStrings.addToWatchlist];

  /// Set Default Select Value Of Product
  Future<void> predefinedValue() async {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      List<MetalModel> metalList = preValueCon.metalsList;
      List<CategoryWiseSize> allSizeList = preValueCon.categoryWiseSizesList;
      RxList<DiamondModel> diamondList = preValueCon.diamondsList;

      metalModel = metalList[0];
      if (allSizeList.isNotEmpty) {
        RxList<DiamondModel> sizeList = <DiamondModel>[].obs;

        for (var element in allSizeList) {
          if (element.name?.toLowerCase() == widget.categorySlug?.toLowerCase() && element.data != null) {
            sizeList = element.data!.obs;
            sizeModel.value = sizeList[0];
          }
        }
      }
      diamondModel = diamondList[0];
    }
  }

  @override
  void initState() {
    super.initState();
    predefinedValue();
  }

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
                /*Container(
                  margin: EdgeInsets.all(defaultPadding / 2),
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Flora",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),*/
                Positioned(
                  top: defaultPadding / 2,
                  right: defaultPadding / 2.4,
                  child: AppPopUpMenuButton(
                    menuList: menuList,
                    onSelect: (value) {
                      switch (value) {
                        case AppStrings.variants:
                          Get.toNamed(AppRoutes.variantsScreen, arguments: {
                            'isSize': widget.isSizeAvailable,
                            'category': widget.categorySlug,
                          });
                          break;
                        case AppStrings.addToWatchlist:
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
                  if (widget.isSizeAvailable) sizeSelector(categorySlug: widget.categorySlug ?? '', category: widget.category?.value),
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
                  metalSelector(categorySlug: widget.categorySlug ?? ''),
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
                      onPressed: () async {
                        if (widget.isLike != null) {
                          widget.isLike?.value = !widget.isLike!.value;

                          if (widget.likeOnChanged != null) {
                            widget.likeOnChanged!(widget.isLike!.value);
                          }
                        }

                        /// CREATE WISHLIST API
                        if (widget.isLike != null) {
                          await WishlistRepository.createWishlistAPI(
                            inventoryId: widget.inventoryId ?? '',
                            isWishlist: widget.isLike!.value,
                            productListType: widget.productsListTypeType,
                          );
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
                              onPressed: () async {
                                if (widget.isLike != null) {
                                  widget.isLike?.value = !widget.isLike!.value;

                                  if (widget.likeOnChanged != null) {
                                    widget.likeOnChanged!(widget.isLike!.value);
                                  }
                                }

                                /// CREATE WISHLIST API
                                if (widget.isLike != null) {
                                  await WishlistRepository.createWishlistAPI(
                                    inventoryId: widget.inventoryId ?? '',
                                    isWishlist: widget.isLike!.value,
                                    productListType: widget.productsListTypeType,
                                  );
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
                    metalSelector(direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
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
                        metalSelector(isFlexible: true, direction: Axis.vertical, categorySlug: widget.categorySlug ?? ''),
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

  Widget sizeSelector({
    bool isFlexible = false,
    Axis direction = Axis.horizontal,
    required String categorySlug,
    SubCategoryModel? category,
    RxString? selectedSizeCart,
  }) {
    return horizontalSelectorButton(
      context,
      categorySlug: categorySlug,
      isFlexible: isFlexible,
      selectedSize: sizeModel,
      selectedSizeCart: selectedSizeCart,
      sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
      selectableItemType: SelectableItemType.size,
      axisDirection: direction,
      sizeOnChanged: (value) async {
        /// Return Selected Size
        if ((value.runtimeType == DiamondModel)) {
          widget.selectSize = value.id;
          sizeModel.value = value;
        }
        if (widget.sizeId != null) {
          widget.sizeId!(value.id?.value ?? "");
        }
      },
    );
  }

  Widget metalSelector({bool isFlexible = false, Axis direction = Axis.horizontal, required String categorySlug}) {
    return horizontalSelectorButton(
      context,
      isFlexible: isFlexible,
      categorySlug: categorySlug,
      selectedMetal: metalModel.obs,
      sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
      selectableItemType: SelectableItemType.color,
      axisDirection: direction,
      metalOnChanged: (value) async {
        /// Return Selected Metal
        if ((value.runtimeType == MetalModel)) {
          metalModel = value;

          /// GET NEW PRODUCT PRICE
          await ProductRepository.getProductPriceAPI(
            productListType: widget.productsListTypeType,
            inventoryId: widget.inventoryId ?? '',
            metalId: metalModel.id?.value ?? "",
            diamondClarity: diamondModel.name ?? "",
          );
        }
      },
    );
  }

  Widget diamondSelector({bool isFlexible = false, Axis direction = Axis.horizontal, required String categorySlug}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        categorySlug: categorySlug,
        selectedDiamond: diamondModel.obs,
        diamondsList: widget.diamondList,
        isFancy: widget.isFancy,
        sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
        selectableItemType: SelectableItemType.diamond,
        axisDirection: direction,
        multiRubyOnChanged: (diamondList) async {
          /// Return List of Selected Diamond
          if ((diamondList.runtimeType == RxList<DiamondListModel>)) {
            diamondList = diamondList;

            /// GET NEW PRODUCT PRICE
            await ProductRepository.getProductPriceAPI(
              productListType: widget.productsListTypeType,
              inventoryId: widget.inventoryId ?? '',
              metalId: metalModel.id?.value ?? "",
              diamonds: widget.diamonds != null
                  ? List.generate(
                      widget.diamonds!.length,
                      (index) => {
                        "diamond_clarity": widget.diamonds?[index].diamondClarity?.value ?? "",
                        "diamond_shape": widget.diamonds?[index].diamondShape ?? "",
                        "diamond_size": widget.diamonds?[index].diamondSize ?? "",
                        "diamond_count": widget.diamonds?[index].diamondCount ?? 0,
                        "_id": widget.diamonds?[index].id ?? "",
                      },
                    )
                  : [],
            );
          }
        },
        rubyOnChanged: (value) async {
          /// Return Single Selected Diamond
          if ((value.runtimeType == DiamondModel)) {
            diamondModel = value;
            printYellow(diamondModel.id);

            /// GET NEW PRODUCT PRICE
            await ProductRepository.getProductPriceAPI(
              productListType: widget.productsListTypeType,
              inventoryId: widget.inventoryId ?? '',
              metalId: metalModel.id?.value ?? "",
              diamondClarity: diamondModel.name ?? "",
            );
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
                      child: Column(
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
                                      //? Item Summary Icon
                                      /* AppIconButton(
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
                                      (defaultPadding / 3).horizontalSpace, */
                                      //? Delete Icon
                                      AppIconButton(
                                        onPressed: () {
                                          AppDialogs.cartDialog(
                                            context,
                                            onPressed: widget.deleteOnTap,
                                            buttonTitle: "NO",
                                            contentText: "Are you sure?\nYou want to remove this item from the cart?",
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
                                    isCart: true,
                                    textValue: widget.productQuantity ?? RxInt(0),
                                    onTap: () {
                                      if (widget.productQuantity?.value == 0) {
                                        widget.deleteOnTap;
                                      }
                                      cartCon.incrementQuantity(widget.item ?? CartModel());
                                      cartCon.decrementQuantity(widget.item ?? CartModel());
                                    },
                                    onIncrement: (value) {
                                      cartCon.incrementQuantity(widget.item ?? CartModel());
                                      widget.incrementOnTap!(value);
                                    },
                                    onDecrement: (value) {
                                      cartCon.decrementQuantity(widget.item ?? CartModel());
                                      widget.productQuantity?.value == 0
                                          ? AppDialogs.cartDialog(
                                              context,
                                              buttonTitle: "NO",
                                              onPressed: widget.deleteOnTap,
                                              contentText: "Are you sure?\nYou want to remove this item from the cart?",
                                            ).then(
                                              (value) {
                                                if (value != null) {
                                                  if (value == false) {
                                                    widget.productQuantity?.value = 1;
                                                    cartCon.incrementQuantity(widget.item ?? CartModel());
                                                    cartCon.decrementQuantity(widget.item ?? CartModel());
                                                  }
                                                }
                                              },
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
                      ),
                    ),
                  ],
                ),
                (defaultPadding / 2).verticalSpace,
                Row(
                  children: [
                    if (widget.isSizeAvailable)
                      sizeSelector(
                        direction: Axis.vertical,
                        isFlexible: true,
                        selectedSizeCart: widget.selectSize,
                        categorySlug: widget.categorySlug ?? '',
                      ),
                    (defaultPadding / 4).horizontalSpace,
                    metalSelector(
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
                    //? Stock Selector button Temporary not show
                    /*  (defaultPadding / 4).horizontalSpace,
                    stockSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                    ) */
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
