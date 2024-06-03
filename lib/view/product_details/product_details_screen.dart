import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/res/app_dialog.dart';
import 'package:pingaksh_mobile/view/product_details/components/price_breakup_dialog.dart';
import 'package:pingaksh_mobile/view/product_details/components/custom_product_watch_button.dart';
import 'package:pingaksh_mobile/widgets/sliver_delegate.dart';
import 'package:pingaksh_mobile/widgets/tab_bar.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/product_info/product_info.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/variants/variants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../exports.dart';
import '../../packages/rating_widget/rating_widget.dart';
import 'product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ProductDetailsController con = Get.put(ProductDetailsController());

  EdgeInsets get bodyPadding => EdgeInsets.symmetric(horizontal: defaultPadding);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(() {
        return DefaultTabController(
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
                                  child: Container(
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
                                  ),
                                ),

                                /// LIKE
                                Positioned(
                                  bottom: defaultPadding * 1,
                                  right: defaultPadding * 1,
                                  child: AppIconButton(
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
                                  ),
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

                        /// STAR RATING
                        Padding(
                          padding: bodyPadding.copyWith(/*top: defaultPadding, bottom: defaultPadding / 4*/),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StarRatingWidget(rating: 5.5, size: 20.w),
                              (defaultPadding / 4).horizontalSpace,
                              Flexible(
                                child: Text(
                                  "(257 Reviews)",
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.subText),
                                ),
                              )
                            ],
                          ),
                        ),
                        (defaultPadding / 3).verticalSpace,

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
                              AppButton(
                                height: 15.h,
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
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
                        /* (defaultPadding / 1).verticalSpace,
                  Padding(
                  padding: bodyPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Your Favorite Color',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: AppColors.subText),
                      ),
                      (defaultPadding / 3).verticalSpace,
                      Row(
                        children: con.colors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              con.selectedColor?.value = color;
                              con.selectedColor?.refresh();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: defaultPadding / 1.5, top: defaultPadding / 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                                border: Border.all(
                                  color: con.selectedColor?.value == color ? Theme.of(context).primaryColor : Colors.transparent,
                                  width: con.selectedColor?.value == color ? 2.sp : 0,
                                ),
                              ),
                              width: 40.sp,
                              height: 40.sp,
                              child: con.selectedColor?.value == color
                                  ? Icon(
                                      Icons.done,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),*/

                        Divider(height: defaultPadding * 2, indent: defaultPadding, endIndent: defaultPadding),
                        Padding(
                          padding: bodyPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// Wear
                              CustomProductWatchButton(
                                icon: AppAssets.jewelleryWearIcon,
                                title: "Wear",
                                onPressed: () {
                                  AppDialogs.selectColorDialog(context)?.then(
                                    (value) => printOkStatus(value),
                                  );
                                },
                              ),

                              /// Watch
                              CustomProductWatchButton(
                                icon: AppAssets.watchlistIcon,
                                title: "Watch",
                                onPressed: () {
                                  Get.toNamed(AppRoutes.addWatchListScreen);
                                },
                              ),

                              /// Add Metal
                              CustomProductWatchButton(
                                title: "Add\nmetal",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        (defaultPadding / 1.4).verticalSpace,
                        AppButton(
                          padding: bodyPadding,
                          height: 30.h,
                          title: "ADD TO CART",
                          onPressed: () {
                            UiUtils.toast("Added Successfully");
                          },
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: MyTabBar(
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
                Variants(),

                /// FAMILY PRODUCT TAB
                Container(color: Colors.yellow),
              ],
            ),
          ),
        );
      }),
    );
  }
}
