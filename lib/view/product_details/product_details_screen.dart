import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../data/model/product/product_colors_model.dart';
import '../../data/model/product/product_diamond_model.dart';
import '../../data/model/product/product_size_model.dart';
import '../../res/app_dialog.dart';
import '../../widgets/plus_minus_title/plus_minus_tile.dart';
import '../../widgets/size_selector/size_selector_botton.dart';
import '../products/components/cart_icon_button.dart';
import 'widgets/family_product/family_product_tab.dart';
import 'widgets/product_info/product_info.dart';
import 'widgets/variants/variants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_network_image.dart';
import '../../widgets/sliver_delegate.dart';
import '../../widgets/tab_bar.dart';
import 'components/custom_product_watch_button.dart';
import 'components/price_breakup_dialog.dart';
import 'product_details_controller.dart';

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
          title: "PLKMR7423746",
          backgroundColor: Colors.white,
          actions: const [CartIconButton()],
        ),
        body: DefaultTabController(
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

                        if (con.productImages.isNotEmpty)
                          AspectRatio(
                            aspectRatio: 1,
                            child: Stack(
                              children: [
                                /// IMAGES
                                PageView.builder(
                                  controller: con.imagesPageController.value,
                                  itemCount: con.productImages.length,
                                  onPageChanged: (index) {
                                    con.currentPage.value = index;
                                  },
                                  itemBuilder: (context, index) {
                                    return AppNetworkImage(
                                      imageUrl: con.productImages[index],
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
                                        count: con.productImages.length,
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
                                      onPressed: () {
                                        con.isLike.value = !con.isLike.value;
                                        con.isLike.refresh();
                                      },
                                      shadowColor: Theme.of(context).colorScheme.surface.withOpacity(.1),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                        /// ***********************************************************************************
                        ///                                  PRODUCT DETAILS
                        /// ***********************************************************************************

                        defaultPadding.verticalSpace,
                        Padding(
                          padding: bodyPadding,
                          child: Text(
                            "SARDUNYA RING",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                          ),
                        ),
                        (defaultPadding / 6).verticalSpace,

                        /// PRODUCT PRICE
                        Padding(
                          padding: bodyPadding,
                          child: Row(
                            children: [
                              Text(
                                UiUtils.amountFormat(32500),
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
                                  PriceBreakupDialog.priceBreakupDialog(context);
                                },
                              )
                            ],
                          ),
                        ),

                        Divider(height: defaultPadding * 2, indent: defaultPadding, endIndent: defaultPadding),
                        Padding(
                          padding: bodyPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// Wear
                              CustomProductWatchButton(
                                size: 58.h,
                                icon: AppAssets.jewelleryWearIcon,
                                title: "Wear",
                                onPressed: () {},
                              ),

                              /// Watch
                              CustomProductWatchButton(
                                size: 58.h,
                                icon: AppAssets.watchlistFilled,
                                title: "Watch",
                                onPressed: () {
                                  Get.toNamed(AppRoutes.addWatchListScreen);
                                },
                              ),

                              /// Add Metal
                              CustomProductWatchButton(
                                size: 58.h,
                                title: "Add\nmetal",
                                onPressed: () {
                                  AppDialogs.addMetalDialog(context);
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
                            backgroundColor: AppColors.background,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                            border: Border.all(
                              color: Theme.of(context).dividerColor.withOpacity(0.15),
                            ),
                            tabs: const [
                              Tab(
                                text: "Product Info",
                              ),
                              Tab(
                                text: "Variants",
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
                ProductInfo(),

                /// VARIANTS TAB
                VariantsTab(),

                /// FAMILY PRODUCT TAB
                FamilyProductTab()
              ],
            ),
          ),
        ),
        // bottom sheet
        bottomSheet: Container(
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
              horizontalSelectorButton(
                context,
                selectedSize: RxString(con.selectedSize.value.size ?? ''),
                selectableItemType: SelectableItemType.size,
                sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                axisDirection: Axis.vertical,
                sizeOnChanged: (value) {
                  /// Selected Size
                  if ((value.runtimeType == SizeModel)) {
                    con.selectedSize.value = value;
                  }
                },
              ),
              (defaultPadding / 5).horizontalSpace,

              /// Color Selector
              horizontalSelectorButton(
                context,
                selectedColor: RxString(con.selectedColor.value.color ?? ''),
                selectableItemType: SelectableItemType.color,
                sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                axisDirection: Axis.vertical,
                colorOnChanged: (value) {
                  /// Selected Color
                  if ((value.runtimeType == ColorModel)) {
                    con.selectedColor.value = value;
                  }
                },
              ),
              (defaultPadding / 5).horizontalSpace,

              /// Diamond Selector
              horizontalSelectorButton(
                context,
                selectedDiamond: RxString(con.selectedDiamond.value.diamond ?? ''),
                selectableItemType: SelectableItemType.diamond,
                sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                axisDirection: Axis.vertical,
                rubyOnChanged: (value) {
                  /// Selected Diamond
                  if ((value.runtimeType == Diamond)) {
                    con.selectedDiamond.value = value;
                  }
                },
              ),
              (defaultPadding / 5).horizontalSpace,

              /// Add Remark
              horizontalSelectorButton(
                context,
                remarkSelected: con.selectedRemark,
                selectableItemType: SelectableItemType.remarks,
                sizeColorSelectorButtonType: SizeColorSelectorButtonType.small,
                axisDirection: Axis.vertical,
                remarkOnChanged: (value) {
                  con.selectedRemark.value = value;
                },
              ),
              (defaultPadding / 5).horizontalSpace,
              plusMinusTile(
                context,
                textValue: 0.obs,
                onIncrement: (v) {
                  // UiUtils.toast("Added Successfully");
                },
                onDecrement: (v) {},
              )
            ],
          ),
        ),
      );
    });
  }
}
