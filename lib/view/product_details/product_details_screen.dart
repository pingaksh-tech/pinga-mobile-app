import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/model/common/splash_model.dart';
import '../../data/model/product/products_model.dart';
import '../../data/model/product/single_product_model.dart';
import '../../data/repositories/cart/cart_repository.dart';
import '../../data/repositories/wishlist/wishlist_repository.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../res/app_network_image.dart';
import '../../widgets/plus_minus_title/plus_minus_tile.dart';
import '../../widgets/size_selector/size_selector_botton.dart';
import '../../widgets/sliver_delegate.dart';
import '../../widgets/tab_bar.dart';
import '../products/components/cart_icon_button.dart';
import 'components/custom_product_watch_button.dart';
import 'components/price_breakup_dialog.dart';
import 'product_details_controller.dart';
import 'widgets/Diamonds_tab/diamonds_tab.dart';
import 'widgets/family_product/family_product_tab.dart';
import 'widgets/product_info/product_info.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ProductDetailsController con = Get.put(ProductDetailsController());

  EdgeInsets get bodyPadding => EdgeInsets.symmetric(horizontal: defaultPadding);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: MyAppBar(
          title: con.productName.value,
          backgroundColor: Colors.white,
          actions: [
            CartIconButton(),
          ],
        ),
        body: con.loader.isFalse
            ? DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  controller: con.scrollController.value,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // padding: EdgeInsets.zero,
                          children: [
                            ...[
                              /// ***********************************************************************************
                              ///                                    IMAGE VIEW
                              /// ***********************************************************************************

                              if (con.productDetailModel.value.inventoryImages != null && con.productDetailModel.value.inventoryImages!.isNotEmpty)
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.imageViewScreen,
                                        arguments: {'imageList': con.productDetailModel.value.inventoryImages, "name": con.productName.value},
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        /// IMAGES
                                        PageView.builder(
                                          controller: con.imagesPageController.value,
                                          itemCount: con.productDetailModel.value.inventoryImages?.length,
                                          onPageChanged: (index) {
                                            con.currentPage.value = index;
                                          },
                                          itemBuilder: (context, index) {
                                            return AppNetworkImage(
                                              imageUrl: con.productDetailModel.value.inventoryImages?[index] ?? "",
                                              fit: BoxFit.cover,
                                              borderRadius: BorderRadius.zero,
                                            );
                                          },
                                        ),

                                        /// PAGE INDEX INDICATOR
                                        Positioned(
                                          bottom: defaultPadding,
                                          left: Get.width / 2.3,
                                          child: Obx(() {
                                            return Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Theme.of(context).colorScheme.surface.withOpacity(.1),
                                                    blurRadius: 20,
                                                    spreadRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: AnimatedSmoothIndicator(
                                                activeIndex: con.currentPage.value,
                                                count: con.productDetailModel.value.inventoryImages != null ? con.productDetailModel.value.inventoryImages!.length : 0,
                                                effect: ScrollingDotsEffect(
                                                  dotHeight: 8.0,
                                                  dotWidth: 8.0,
                                                  spacing: 5.0,
                                                  dotColor: Theme.of(context).primaryColor.withOpacity(0.15),
                                                  activeDotColor: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            );
                                          }),
                                        ),

                                        /// LIKE
                                        Positioned(
                                          bottom: defaultPadding * 1,
                                          right: defaultPadding * 1,
                                          child: Obx(() {
                                            return AppIconButton(
                                              backgroundColor: Theme.of(context).cardColor.withOpacity(1),
                                              icon: SvgPicture.asset(
                                                con.isLike.value ? AppAssets.likeFill : AppAssets.like,
                                                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                              ),
                                              onPressed: () async {
                                                con.isLike.value = !con.isLike.value;
                                                con.isLike.refresh();

                                                /// CREATE WISHLIST API
                                                await WishlistRepository.createWishlistAPI(productListType: ProductsListType.normal, inventoryId: con.inventoryId.value, isWishlist: con.isLike.value);
                                              },
                                              shadowColor: Theme.of(context).colorScheme.surface.withOpacity(.1),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              /// ***********************************************************************************
                              ///                                  PRODUCT DETAILS
                              /// ***********************************************************************************

                              defaultPadding.verticalSpace,
                              // Padding(
                              //   padding: bodyPadding,
                              //   child: Text(
                              //     "SARDUNYA RING",
                              //     style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                              //   ),
                              // ),
                              // (defaultPadding / 6).verticalSpace,

                              /// PRODUCT PRICE
                              Padding(
                                padding: bodyPadding,
                                child: Row(
                                  children: [
                                    Text(
                                      UiUtils.amountFormat(con.productDetailModel.value.priceBreaking?.total ?? 0),
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    defaultPadding.horizontalSpace,

                                    /// PRICE BREAKUP
                                    AppButton(
                                      height: 15.h,
                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                      borderRadius: BorderRadius.circular(5.r),
                                      flexibleWidth: true,
                                      title: "Price breakup",
                                      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColors.background,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .3,
                                          ),
                                      onPressed: () {
                                        PriceBreakupDialog.priceBreakupDialog(context, priceBreakModel: con.productDetailModel.value.priceBreaking ?? PriceBreaking());
                                      },
                                    )
                                  ],
                                ),
                              ),

                              Divider(height: defaultPadding * 2, indent: defaultPadding, endIndent: defaultPadding),
                              Padding(
                                padding: bodyPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /// Wear
                                    // CustomProductWatchButton(
                                    //   size: 58.h,
                                    //   icon: AppAssets.jewelleryWearIcon,
                                    //   title: "Wear",
                                    //   onPressed: () {},
                                    // ),

                                    /// Watch
                                    CustomProductWatchButton(
                                      size: 58.h,
                                      icon: AppAssets.watchlistFilled,
                                      title: "Watch",
                                      onPressed: () {
                                        Get.toNamed(
                                          AppRoutes.addWatchListScreen,
                                          arguments: {
                                            'inventoryId': con.inventoryId.value,
                                            'quantity': con.quantity.value,
                                            'sizeId': con.productDetailModel.value.sizeId,
                                            'metalId': con.productDetailModel.value.metalId,
                                            'diamond': (con.productDetailModel.value.diamonds != null && con.productDetailModel.value.diamonds!.isNotEmpty) ? con.productDetailModel.value.diamonds?.first.diamondClarity?.value : "",
                                          },
                                        );
                                      },
                                    ),

                                    /// Add Metal
                                    CustomProductWatchButton(
                                      size: 58.h,
                                      title: "Add\nmetal",
                                      onPressed: () {
                                        AppDialogs.addMetalDialog(
                                          context,
                                          metalWeight: con.productDetailModel.value.extraMetalWeight,
                                          metalPrice: con.productDetailModel.value.priceBreaking?.metal?.pricePerGram ?? 0,
                                        ).then(
                                          (value) {
                                            if (value != null) {
                                              con.extraMetalPrice = value['price'];
                                              con.extraMetalWt = value['wt'];
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              (defaultPadding).verticalSpace,
                            ],
                          ],
                        ),
                      ),

                      /// TAB BAR
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverAppBarDelegate(
                            maxHeight: 50,
                            minHeight: 48,
                            child: Container(
                              color: AppColors.background,
                              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                              child: MySlideTabBar(
                                  tabAlignment: TabAlignment.start,
                                  backgroundColor: AppColors.background,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor.withOpacity(0.15),
                                  ),
                                  tabs: const [
                                    Tab(
                                      text: "Product Info",
                                    ),
                                    // Tab(
                                    //   text: "Variants",
                                    // ),
                                    Tab(
                                      text: "Diamonds",
                                    ),
                                    Tab(
                                      text: "Family Product",
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    children: [
                      /// PRODUCT INFO TAB
                      ProductInfoTab(infoList: con.productDetailModel.value.productInfo?.toJson().entries.toList() ?? []),

                      // /// VARIANTS TAB
                      // VariantsTab(
                      //   productCategory: con.productCategory.value,
                      //   isSize: con.isSize.value,
                      // ),
                      /// DIAMOND TAB
                      DiamondsTab(diamondList: con.productDetailModel.value.diamonds ?? []),

                      /// FAMILY PRODUCT TAB
                      FamilyProductTab(
                        productList: con.productDetailModel.value.familyProducts ?? [],
                        category: con.productCategory.value,
                      )
                    ],
                  ),
                ),
              )
            : ListView(
                physics: const RangeMaintainingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 50.h),
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ShimmerUtils.shimmer(
                      child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  (defaultPadding / 1.5).verticalSpace,
                  Padding(
                    padding: bodyPadding,
                    child: Row(
                      children: [
                        ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 20.h, width: Get.width / 3),
                        ),
                        (defaultPadding / 2).horizontalSpace,
                        ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius / 2), height: 18.h, width: Get.width / 4),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: defaultPadding,
                    endIndent: defaultPadding,
                    height: defaultPadding * 2,
                  ),
                  Padding(
                    padding: bodyPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius * 5), height: 60.h, width: 60.h),
                        ),
                        (defaultPadding * 3).horizontalSpace,
                        ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius * 5), height: 60.h, width: 60.h),
                        ),
                      ],
                    ),
                  ),
                  defaultPadding.verticalSpace,
                  Padding(
                    padding: bodyPadding,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(defaultPadding / 1.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.textFiledBorder, width: 1),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(defaultRadius / 2),
                        ),
                      ),
                      child: Row(
                        children: [
                          ShimmerUtils.shimmer(
                            child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 18.h, width: 60.h),
                          ),
                          defaultPadding.horizontalSpace,
                          ShimmerUtils.shimmer(
                            child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 18.h, width: 60.h),
                          ),
                          defaultPadding.horizontalSpace,
                          ShimmerUtils.shimmer(
                            child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 18.h, width: 60.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: bodyPadding,
                    child: Table(
                      border: TableBorder.all(color: Theme.of(context).dividerColor.withOpacity(0.15)),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        ...List.generate(
                          6,
                          (index) => TableRow(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(defaultPadding / 3),
                                  child: ShimmerUtils.shimmer(
                                    child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 16.h, width: 60.h),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(defaultPadding / 3),
                                  child: ShimmerUtils.shimmer(
                                    child: ShimmerUtils.shimmerContainer(borderRadius: BorderRadius.circular(defaultRadius), height: 16.h, width: 60.h),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
        // bottom sheet
        bottomNavigationBar: Container(
          height: 60.h,
          decoration: BoxDecoration(color: AppColors.background, boxShadow: [
            BoxShadow(
              color: Theme.of(context).iconTheme.color!.withOpacity(0.03),
              blurRadius: 4,
              spreadRadius: 7,
            ),
          ]),
          padding: EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              /// Size Selector
              if (!isValEmpty(con.productDetailModel.value.sizeId))
                horizontalSelectorButton(
                  context,
                  categoryId: con.productCategory.value,
                  selectedSize: con.selectedSize,
                  selectableItemType: SelectableItemType.size,
                  sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
                  axisDirection: Axis.vertical,
                  sizeOnChanged: (value) async {
                    /// Selected Size
                    if ((value.runtimeType == DiamondModel)) {
                      con.selectedSize.value = value;

                      /// GET NEW PRODUCT PRICE
                      con.priceChangeAPI();
                    }
                  },
                ),
              (defaultPadding / 5).horizontalSpace,

              /// Metal Selector
              horizontalSelectorButton(
                context,
                categoryId: con.selectedMetal.value.id?.value ?? "",
                selectedMetal: con.selectedMetal,
                selectableItemType: SelectableItemType.metal,
                sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
                axisDirection: Axis.vertical,
                metalOnChanged: (value) async {
                  printYellow(value.name);

                  /// Selected Metal
                  if ((value.runtimeType == MetalModel)) {
                    con.selectedMetal.value = value;

                    /// GET NEW PRODUCT PRICE
                    con.priceChangeAPI();
                  }
                },
              ),
              (defaultPadding / 5).horizontalSpace,

              /// Diamond Selector
              horizontalSelectorButton(
                context,
                categoryId: con.selectedDiamond.value.id?.value ?? "",
                selectedDiamond: con.selectedDiamond,
                isFancy: con.isFancy.value,
                diamondsList: RxList(con.productDetailModel.value.diamonds ?? []),
                selectableItemType: SelectableItemType.diamond,
                sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
                axisDirection: Axis.vertical,
                multiRubyOnChanged: (diamondList) async {
                  /// Return List of Selected Diamond
                  if ((diamondList.runtimeType == RxList<DiamondListModel>)) {
                    con.diamondList.value = diamondList;

                    /// GET NEW PRODUCT PRICE
                    con.priceChangeAPI();
                  }
                },
                rubyOnChanged: (value) {
                  /// Selected Diamond
                  if ((value.runtimeType == DiamondModel)) {
                    con.selectedDiamond.value = value;

                    /// GET NEW PRODUCT PRICE
                    con.priceChangeAPI();
                  }
                },
              ),
              (defaultPadding / 5).horizontalSpace,

              /// Add Remark
              horizontalSelectorButton(
                context,
                remarkSelected: con.selectedRemark,
                selectableItemType: SelectableItemType.remarks,
                sizeColorSelectorButtonType: SizeMetalSelectorButtonType.small,
                axisDirection: Axis.vertical,
                remarkOnChanged: (value) {
                  con.selectedRemark.value = value;
                },
              ),
              (defaultPadding / 5).horizontalSpace,
              plusMinusTile(
                context,
                textValue: con.quantity,
                onIncrement: (value) {
                  CartRepository.updateCartApi(
                    inventoryId: con.inventoryId.value,
                    quantity: value,
                    extraMetalWeight: con.extraMetalWt,
                    metalId: con.selectedMetal.value.id?.value ?? "",
                    sizeId: con.selectedSize.value.id?.value ?? "",
                    diamondClarity: con.selectedDiamond.value.shortName ?? "",
                    diamonds: List.generate(
                      con.diamondList.length,
                      (index) => {
                        "diamond_clarity": con.diamondList[index].diamondClarity?.value ?? "",
                        "diamond_shape": con.diamondList[index].diamondShape ?? "",
                        "diamond_size": con.diamondList[index].diamondSize ?? "",
                        "diamond_count": con.diamondList[index].diamondCount ?? 0,
                        "_id": con.diamondList[index].id ?? "",
                      },
                    ),
                  );
                },
                onDecrement: (value) {
                  CartRepository.updateCartApi(
                    inventoryId: con.inventoryId.value,
                    extraMetalWeight: con.extraMetalWt,
                    quantity: value,
                    metalId: con.selectedMetal.value.id?.value ?? "",
                    sizeId: con.selectedSize.value.id?.value ?? "",
                    diamondClarity: con.selectedDiamond.value.shortName ?? "",
                    diamonds: List.generate(
                      con.diamondList.length,
                      (index) => {
                        "diamond_clarity": con.diamondList[index].diamondClarity?.value ?? "",
                        "diamond_shape": con.diamondList[index].diamondShape ?? "",
                        "diamond_size": con.diamondList[index].diamondSize ?? "",
                        "diamond_count": con.diamondList[index].diamondCount ?? 0,
                        "_id": con.diamondList[index].id ?? "",
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
