import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/packages/cached_network_image/cached_network_image.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../exports.dart';
import '../../packages/like_button/like_button.dart';
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
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.cartScreen);
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
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
                          color: Theme.of(context).primaryColor,
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
              child: Text(
                UiUtils.amountFormat(32500),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            (defaultPadding / 1).verticalSpace,
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
            ),
            (defaultPadding * 1.5).verticalSpace,
            AppButton(
              padding: bodyPadding,
              height: 30.h,
              title: "ADD TO CART",
              onPressed: () {
                UiUtils.toast("Added Successfully");
              },
            ),

            (defaultPadding * 1.5).verticalSpace,

            /// PRODUCT DETAILS
            Padding(
              padding: bodyPadding,
              child: Text(
                "Product Details",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
              ),
            ),
            (defaultPadding / 2).verticalSpace,

            Padding(
              padding: bodyPadding,
              child: Table(
                border: TableBorder.all(color: Theme.of(context).dividerColor.withOpacity(0.15)),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  // TableRow(
                  //   decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1)),
                  //   children: const [
                  //     Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text('Attribute', style: TextStyle(fontWeight: FontWeight.bold)),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                  //     ),
                  //   ],
                  // ),
                  ...con.productDetails.map((detail) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(defaultPadding / 3),
                          child: Text(
                            detail.keys.first,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(defaultPadding / 3),
                          child: Text(
                            detail.values.first,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            (defaultPadding * 1.5).verticalSpace,

            /// RELATED PRODUCTS
            Padding(
              padding: bodyPadding,
              child: Text(
                "Related Products",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
              ),
            ),
            (defaultPadding / 4).verticalSpace,
            relatedProductsView(context),
            (defaultPadding * 1.5).verticalSpace,
          ],
        );
      }),
    );
  }

  Widget relatedProductsView(BuildContext context) {
    return Padding(
      padding: /*bodyPadding*/ EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: Wrap(
        children: List.generate(
          2,
          (index) => GestureDetector(
            onTap: () => Get.toNamed(
              AppRoutes.productDetailsScreen,
              arguments: {
                // "brandName": con.brandList[index]["brandName"],
              },
            ),
            child: Container(
              width: Get.width / 2 - defaultPadding * 1.5,
              margin: EdgeInsets.all(defaultPadding / 2),
              padding: EdgeInsets.all(defaultPadding / 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(defaultRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width / 2 - defaultPadding,
                    child: Stack(
                      children: [
                        AppNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.scaleDown,
                          padding: EdgeInsets.only(bottom: defaultPadding * 1.2),
                          borderRadius: BorderRadius.circular(defaultRadius),
                          imageUrl: "https://i.pinimg.com/736x/71/56/2b/71562bfee51fd6ffb222dae63e605eec.jpg",
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MFLikeButton(
                            iconSize: 20,
                            buttonSize: 30,
                            isLiked: false,
                            onTap: (isLiked) async {
                              isLiked = !isLiked;
                              return isLiked;
                            },
                            selectedIcon: SvgPicture.asset(AppAssets.basketShoppingSimple, color: AppColors.lightSecondary, height: 20, width: 20), // ignore: deprecated_member_use
                            unSelectedIcon: SvgPicture.asset(AppAssets.basketShopping, color: AppColors.lightSecondary, height: 20, width: 20), // ignore: deprecated_member_use
                            shape: BoxShape.circle,
                            padding: EdgeInsets.only(right: defaultPadding / 2),
                            backgroundColor: Theme.of(context).primaryColor,
                            borderColor: Theme.of(context).scaffoldBackgroundColor,
                            likeColor: AppColors.goldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            index == 0 ? "Diamond Ring" : "Diamond Shine Ring ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          UiUtils.amountFormat("102500", symbol: "₹"),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
