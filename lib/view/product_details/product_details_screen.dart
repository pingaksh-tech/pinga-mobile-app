import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
          actions: [
            AppIconButton(
              // backgroundColor: AppColors.primary.withOpacity(0.1),
              icon: SvgPicture.asset(
                AppAssets.cart,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.cartScreen);
              },
            ),
          ],
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
                                icon: AppAssets.watchlistIcon,
                                title: "Watch",
                                onPressed: () {
                                  Get.toNamed(AppRoutes.addWatchListScreen);
                                },
                              ),

                              /// Add Metal
                              CustomProductWatchButton(
                                size: 58.h,
                                title: "Add\nmetal",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          padding: bodyPadding.copyWith(top: defaultPadding * 2, bottom: defaultPadding * 2),
                          height: 30.h,
                          title: "ADD TO CART",
                          onPressed: () {
                            UiUtils.toast("Added Successfully");
                          },
                        ),
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
                Container(
                  padding: EdgeInsets.all(defaultPadding).copyWith(top: 50),
                  child: Text(
                    "No family products available.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottom sheet
        /*     bottomSheet: Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
          color: AppColors.background,
          child: Row(
            children: [
              sizeSelectorButton(
                context,
                selectedSize: ''.obs,
                backgroundColor: Colors.transparent,
              ),
              colorSelectorButton(
                context,
                selectedColor: ''.obs,
                backgroundColor: Colors.transparent,
              )
            ],
          ),
        ),*/
      );
    });
  }
}
