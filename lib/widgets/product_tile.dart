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
import '../data/repositories/cart/cart_repository.dart';
import '../data/repositories/product/product_repository.dart';
import '../data/repositories/wishlist/wishlist_repository.dart';
import '../exports.dart';
import '../res/app_dialog.dart';
import '../res/app_network_image.dart';
import '../res/pop_up_menu_button.dart';
import '../utils/device_utils.dart';
import '../view/cart/cart_controller.dart';
import '../view/products/widgets/filter/filter_controller.dart';
import 'custom_check_box_tile.dart';
import 'plus_minus_title/plus_minus_tile.dart';
import 'size_selector/size_selector_botton.dart';

class ProductTile extends StatefulWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String productName;
  final RxString? category;
  final String? inventoryId;
  final bool isFancy;
  final RxList<DiamondListModel>? diamondList;
  final String productPrice;
  final bool isSizeAvailable;
  final RxInt? productQuantity;
  final String? brandName;
  final RxBool? isLike;
  final ProductTileType productTileType;
  final ProductsListType productsListTypeType;
  final Function(bool)? likeOnChanged;
  final VoidCallback? deleteOnTap;
  final Function(String?)? diamondOnChanged;
  final Function(List<DiamondListModel>?)? multiDiamondOnChanged;
  final Function(String)? sizeOnChanged;
  final Function(String)? metalOnChanged;
  final Function(String)? remarkOnChanged;
  final VoidCallback? cartDetailOnTap;
  final RxBool? isCartSelected;
  final void Function(bool?)? onChanged;
  final CartModel? item;
  final List<DiamondListModel>? diamonds;
  RxString? selectSize;
  RxString? selectSizeCart;
  RxString? selectMetalCart;
  RxString? selectDiamondCart;
  String? cartId;
  RxString? remark;
  String screenType;

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
    this.isCartSelected,
    this.onChanged,
    this.isSizeAvailable = true,
    this.item,
    this.category,
    this.selectSize,
    this.inventoryId,
    this.diamondList,
    this.diamonds,
    required this.screenType,
    this.productsListTypeType = ProductsListType.normal,
    this.selectSizeCart,
    this.selectMetalCart,
    this.selectDiamondCart,
    this.cartId,
    this.remark,
    this.diamondOnChanged,
    this.multiDiamondOnChanged,
    this.sizeOnChanged,
    this.remarkOnChanged,
    this.metalOnChanged,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Timer? cartDebounce;

  Rx<DiamondModel> sizeModel = DiamondModel().obs;
  MetalModel metalModel = MetalModel();
  DiamondModel diamondModel = DiamondModel();
  RxString selectedRemark = "".obs;
  RxBool isSelected = false.obs;
  RxList<CartModel> cartList = <CartModel>[].obs;
  CartModel cart = CartModel();
  List<String> menuList = [/*AppStrings.variants,*/ AppStrings.addToWatchlist];

  late RxInt productQuantity;

  /// Set Default Select Value Of Product
  Future<void> predefinedValue() async {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      RxList<MetalModel> metalList = preValueCon.metalsList;
      List<CategoryWiseSize> allSizeList = preValueCon.categoryWiseSizesList;
      RxList<DiamondModel> diamondList = preValueCon.diamondsList;
      //? Metal Value Select in default
      if (metalList.isNotEmpty) {
        int index = metalList.indexWhere((element) => element.id == widget.selectMetalCart);
        if (index != -1) {
          metalModel = metalList[index];
        } else {
          metalModel = metalList[0];
        }
      }
      //? Size Value Select in default
      if (allSizeList.isNotEmpty) {
        RxList<DiamondModel> sizeList = <DiamondModel>[].obs;
        for (var element in allSizeList) {
          if (element.id?.value == widget.category?.value && element.data != null) {
            sizeList = element.data!.obs;

            int index = sizeList.indexWhere((element) => element.id == widget.selectSize);
            if (index != -1) {
              sizeModel.value = sizeList[index];
            } else {
              // sizeModel.value = sizeList[0];
            }
          }
        }
      }
      //? Diamond value selection
      if (diamondList.isNotEmpty) {
        // printYellow("Diamond List: ${diamondList.toJson()}");

        int diamondIndex = diamondList.indexWhere((element) {
          // printYellow("Diamond selectDiamondCart  ${element.id}: ${element.shortName}");

          return element.shortName == widget.selectDiamondCart?.value;
        });

        // printYellow("Diamond selectDiamondCart: ${widget.selectDiamondCart?.value}");

        if (diamondIndex != -1) {
          diamondModel = diamondList[diamondIndex];
        } else {
          diamondModel = diamondList[0];
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    productQuantity = widget.productQuantity ?? RxInt(0);
    predefinedValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // compareCart();
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
        width: DeviceUtil.isTablet(Get.context!) ? (Get.width / 4 - (defaultPadding * 1.3)) : Get.width / 2 - defaultPadding * 1.5,
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
                  height: DeviceUtil.isTablet(Get.context!) ? (Get.width / 3 - defaultPadding * 2.5) : Get.width / 2 - defaultPadding * 2.5,
                  child: isValEmpty(widget.imageUrl)
                      ? productPlaceHolderImage()
                      : AppNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
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
                            // 'category': widget.subCategoryId,
                          });
                          break;
                        case AppStrings.addToWatchlist:
                          Get.toNamed(
                            AppRoutes.addWatchListScreen,
                            arguments: {
                              'inventoryId': widget.inventoryId,
                              'quantity': widget.productQuantity?.value ?? 0,
                              'sizeId': sizeModel.value.id?.value ?? "",
                              'metalId': metalModel.id?.value ?? "",
                              'diamondClarity': (widget.diamondList != null && widget.diamondList!.isNotEmpty) ? widget.diamondList?.first.diamondClarity?.value : "",
                              "diamond": widget.diamonds,
                              "isMultiDiamond": widget.isFancy,
                            },
                          );
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
                      maxLines: 1,
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
                  if (widget.isSizeAvailable) sizeSelector(category: widget.category?.value),
                  (defaultPadding / 4).horizontalSpace,

                  /// Diamond
                  diamondSelector(),
                ],
              ),
            ),
            (defaultPadding / 4).verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 6),
              child: Row(
                children: [
                  /// Color
                  metalSelector(),
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
                    child: isValEmpty(widget.imageUrl)
                        ? SizedBox(
                            height: 44.h,
                            width: 44.h,
                            child: productPlaceHolderImage(),
                          )
                        : AppNetworkImage(
                            imageUrl: widget.imageUrl,
                            height: 44.h,
                            width: 44.h,
                            fit: BoxFit.contain,
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
                    if (widget.isSizeAvailable) sizeSelector(direction: Axis.vertical, category: widget.category?.value),
                    6.horizontalSpace,

                    /// Color Selector
                    metalSelector(direction: Axis.vertical),
                    6.horizontalSpace,

                    /// Diamond Selector
                    diamondSelector(direction: Axis.vertical),
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
                child: isValEmpty(widget.imageUrl)
                    ? SizedBox(
                        height: 44.h,
                        width: 44.h,
                        child: productPlaceHolderImage(),
                      )
                    : AppNetworkImage(
                        imageUrl: widget.imageUrl,
                        height: 44.h,
                        width: 44.h,
                        fit: BoxFit.contain,
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
                        if (widget.isSizeAvailable) sizeSelector(isFlexible: true, direction: Axis.vertical, category: widget.category?.value),
                        6.horizontalSpace,

                        /// Color Selector
                        metalSelector(isFlexible: true, direction: Axis.vertical),
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
    });
  }

  /// Add or Update Cart api

  Future<void> addOrUpdateCart({
    String? metalId,
    String? sizeId,
    String? diamondClarity,
    int? quantity,
    String? inventoryId,
    String? cartId,
    List<Map<String, dynamic>>? diamonds,
  }) async {
    if (cartDebounce?.isActive ?? false) cartDebounce?.cancel();
    cartDebounce = Timer(
      defaultSearchDebounceDuration,
      () async {
        /// Add to cart api
        await CartRepository.addOrUpdateCartApi(
          cartId: widget.cartId,
          retailerModel: Get.find<FilterController>().selectedRetailer?.value,
          inventoryId: inventoryId ?? widget.inventoryId ?? "",
          quantity: quantity ?? widget.productQuantity?.value ?? 0,
          metalId: metalId ?? metalModel.id?.value ?? "",
          sizeId: sizeId ?? sizeModel.value.id?.value ?? "",
          remark: selectedRemark.value.isNotEmpty ? selectedRemark.value : widget.remark?.value ?? "",
          diamondClarity: widget.isFancy == false ? diamondClarity ?? diamondClarity ?? (diamondModel.name ?? "") : "",
          diamonds: widget.isFancy == true
              ? diamonds ??
                  List.generate(
                    widget.diamonds!.length,
                    (index) => {
                      "diamond_clarity": widget.diamonds?[index].diamondClarity?.value ?? "",
                      "diamond_shape": widget.diamonds?[index].diamondShape ?? "",
                      "diamond_size": widget.diamonds?[index].diamondSize ?? "",
                      "diamond_count": widget.diamonds?[index].diamondCount ?? 0,
                      "_id": widget.diamonds?[index].id ?? "",
                    },
                  )
              : null,
        );
      },
    );
  }

  Future<void> getProductPriceAPI({
    String? metalId,
    String? sizeId,
    String? diamondClarity,
    String? inventoryId,
    List<Map<String, dynamic>>? diamonds,
  }) async {
    commonDebounce(
        duration: defaultSearchDebounceDuration,
        callback: () async {
          await ProductRepository.getProductPriceAPI(
              productListType: widget.productsListTypeType,
              inventoryId: inventoryId ?? widget.inventoryId ?? "",
              metalId: metalId ?? metalModel.id?.value ?? "",
              sizeId: sizeId ?? sizeModel.value.id?.value ?? "",
              diamondClarity: widget.isFancy == false ? diamondClarity ?? diamondClarity ?? (diamondModel.name ?? "") : "",
              diamonds: widget.isFancy == true
                  ? diamonds ??
                      List.generate(
                        widget.diamonds!.length,
                        (index) => {
                          "diamond_clarity": widget.diamonds?[index].diamondClarity?.value ?? "",
                          "diamond_shape": widget.diamonds?[index].diamondShape ?? "",
                          "diamond_size": widget.diamonds?[index].diamondSize ?? "",
                          "diamond_count": widget.diamonds?[index].diamondCount ?? 0,
                          "_id": widget.diamonds?[index].id ?? "",
                        },
                      )
                  : null,
              screenType: widget.screenType);
        });
  }

  Widget sizeSelector({
    bool isFlexible = false,
    Axis direction = Axis.horizontal,
    String? category,
    RxString? selectedSizeCart,
  }) {
    return horizontalSelectorButton(
      context,
      categoryId: category ?? "",
      isFlexible: isFlexible,
      selectedSize: sizeModel,
      selectedSizeCart: selectedSizeCart,
      sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
      selectableItemType: SelectableItemType.size,
      axisDirection: direction,
      sizeOnChanged: (value) async {
        /// Return Selected Size
        if ((value.runtimeType == DiamondModel)) {
          widget.selectSize = value.id;
          sizeModel.value = value;
          widget.sizeOnChanged!(value.id?.value ?? "");
          if (!isValEmpty(widget.cartId)) {
            addOrUpdateCart(sizeId: value.id?.value ?? "");
          }

          /// GET NEW PRODUCT PRICE
          await getProductPriceAPI(sizeId: sizeModel.value.id?.value ?? "");
        }
      },
    );
  }

  /// Common Metal Selector
  Widget metalSelector({
    bool isFlexible = false,
    Axis direction = Axis.horizontal,
    RxString? selectMetalCart,
  }) {
    return horizontalSelectorButton(
      context,
      isFlexible: isFlexible,
      selectMetalCart: selectMetalCart,
      categoryId: metalModel.id?.value ?? "",
      selectedMetal: metalModel.obs,
      sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
      selectableItemType: SelectableItemType.metal,
      axisDirection: direction,
      metalOnChanged: (value) async {
        /// Return Selected Metal
        if ((value.runtimeType == MetalModel)) {
          widget.selectMetalCart = value.id;
          metalModel = value;
          widget.metalOnChanged!(value.id!.value);
          if (!isValEmpty(widget.cartId)) {
            await addOrUpdateCart(metalId: value.id?.value ?? "");
          }

          /// GET NEW PRODUCT PRICE
          await getProductPriceAPI(metalId: metalModel.id?.value ?? "");
        }
      },
    );
  }

  Widget diamondSelector({
    bool isFlexible = false,
    Axis direction = Axis.horizontal,
    RxString? selectDiamondCart,
    double? width,
  }) =>
      horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        verticalAxisWidth: width,
        categoryId: diamondModel.id?.value ?? "",
        selectedDiamond: diamondModel.obs,
        diamondsList: RxList(widget.diamonds ?? []),
        selectDiamondCart: selectDiamondCart,
        isFancy: widget.isFancy,
        sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
        selectableItemType: SelectableItemType.diamond,
        axisDirection: direction,
        multiRubyOnChanged: (diamondList) async {
          /// Return List of Selected Diamond
          // widget.multiDiamondOnChanged!(widget.diamonds);
          // if (diamondList.isNotEmpty) {
          //   widget.multiDiamondOnChanged!(widget.diamonds);
          // }
          if ((diamondList.runtimeType == RxList<DiamondListModel>)) {
            diamondList = diamondList;
            if (!isValEmpty(widget.cartId)) {
              addOrUpdateCart(
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
                    : null,
              );
            }

            /// GET NEW PRODUCT PRICE
            await getProductPriceAPI(
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
                  : null,
            );
          }
        },
        rubyOnChanged: (value) async {
          /// Return Single Selected Diamond
          if ((value.runtimeType == DiamondModel)) {
            diamondModel = value;
            widget.selectDiamondCart?.value = value.shortName ?? "";
            // if (value.shortName!.isNotEmpty) {
            widget.diamondOnChanged!(value.shortName ?? '');
            // }

            /// GET NEW PRODUCT PRICE
            await getProductPriceAPI(diamondClarity: diamondModel.shortName ?? "");

            if (!isValEmpty(widget.cartId)) {
              addOrUpdateCart(diamondClarity: value.shortName);
            }
          }
        },
      );

  ///

  // Future<void> compareCart() async {
  //   // widget.inventoryId;
  //   // diamondModel.name;
  //   // metalModel.id?.value;
  //   // sizeModel.value.id;
  //
  //   if (isRegistered<CartController>()) {
  //     final CartController cartCon = Get.find<CartController>();
  //
  //     for (int i = 0; i < cartCon.cartList.length; i++) {
  //       // cartList[i].inventoryId;
  //       // cartList[i].diamondClarity;
  //       // cartList[i].metalId;
  //       // cartList[i].sizeId;
  //
  //       if (widget.inventoryId == cartCon.cartList[i].inventoryId && diamondModel.name == cartCon.cartList[i].diamondClarity && metalModel.id?.value == cartCon.cartList[i].metalId && sizeModel.value.id?.value == cartCon.cartList[i].sizeId) {
  //         widget.productQuantity?.value = cartCon.cartList[i].quantity ?? 0;
  //         break;
  //       } else {
  //         widget.productQuantity?.value = 0;
  //         break;
  //       }
  //     }
  //   }
  // }

  Widget incrementDecrementTile({double? height}) => plusMinusTile(
        context,
        size: height,
        textValue: widget.productQuantity ?? RxInt(0),
        onDecrement: (value) {
          widget.productQuantity?.value = value;
          addOrUpdateCart(quantity: value);
        },
        onIncrement: (value) {
          widget.productQuantity?.value = value;
          addOrUpdateCart(quantity: value);
        },
        onTap: (value) {
          widget.productQuantity?.value = value;
          addOrUpdateCart(quantity: value);
        },
      );

  Widget remarkSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        remarkSelected: widget.remark ?? selectedRemark,
        selectableItemType: SelectableItemType.remarks,
        sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
        axisDirection: direction,
        remarkOnChanged: (value) async {
          selectedRemark.value = value;
          widget.remarkOnChanged!(value);
          if (!isValEmpty(widget.cartId)) {
            addOrUpdateCart();
          }
        },
      );

  Widget stockSelector({bool isFlexible = false, Axis direction = Axis.horizontal}) => horizontalSelectorButton(
        context,
        isFlexible: isFlexible,
        selectableItemType: SelectableItemType.stock,
        sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
        axisDirection: direction,
        productName: widget.productName.obs,
      );

  assignValue() {
    if (isRegistered<PreDefinedValueController>()) {
      final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();
      RxList<CategoryWiseSize> allSizeList = preValueCon.categoryWiseSizesList;
      RxList<DiamondModel> sizeList = <DiamondModel>[].obs;
      RxList<MetalModel> metalList = preValueCon.metalsList;

      for (var element in allSizeList) {
        if (element.id?.value == widget.category?.value && element.data != null) {
          sizeList = element.data!.obs;
          int index = sizeList.indexWhere((element) => element.id?.value == widget.selectSizeCart?.value);
          if (index != -1) {
            widget.selectSizeCart?.value = sizeList[index].shortName ?? "";
            sizeModel.value = sizeList[index];
          }
        }
      }

      if (metalList.isNotEmpty) {
        int index = metalList.indexWhere((element) => element.id?.value == widget.selectMetalCart?.value);
        if (index != -1) {
          widget.selectMetalCart?.value = metalList[index].shortName ?? "";
          metalModel = metalList[index];
        }
      }
    }
  }

  Widget productCartTile() {
    return Obx(
      () {
        final CartController cartCon = Get.find<CartController>();
        assignValue();
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
                                fit: BoxFit.contain,
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
                            : Container(
                                width: Get.width * 0.2,
                                height: Get.width * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                  color: AppColors.primary.withOpacity(0.1),
                                ),
                                child: productPlaceHolderImage(showShadow: false),
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
                                    onTap: (value) {
                                      addOrUpdateCart(quantity: value);
                                      if (widget.productQuantity?.value == 0) {
                                        widget.deleteOnTap;
                                      }
                                      cartCon.incrementQuantity(widget.item ?? CartModel());
                                      cartCon.decrementQuantity(widget.item ?? CartModel());
                                    },
                                    onIncrement: (value) {
                                      cartCon.incrementQuantity(widget.item ?? CartModel());
                                      addOrUpdateCart(quantity: value);
                                    },
                                    onDecrement: (value) {
                                      cartCon.decrementQuantity(widget.item ?? CartModel());
                                      widget.productQuantity?.value != 0 ? addOrUpdateCart(quantity: value) : null;

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
                        selectedSizeCart: RxString(widget.selectSizeCart?.value ?? ""),
                        category: widget.category?.value,
                      ),
                    (defaultPadding / 4).horizontalSpace,
                    metalSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                      selectMetalCart: RxString(widget.selectMetalCart?.value ?? ""),
                    ),
                    (defaultPadding / 4).horizontalSpace,
                    diamondSelector(
                      direction: Axis.vertical,
                      isFlexible: true,
                      width: widget.isFancy ? 30.w : null,
                      selectDiamondCart: RxString(widget.selectDiamondCart?.value ?? ""),
                    ),
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
