import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';
import 'package:pingaksh_mobile/view/product_details/widgets/product_info/product_info_controller.dart';

import '../../../../packages/like_button/like_button.dart';
import '../../../../res/app_network_image.dart';

class ProductInfo extends StatelessWidget {
  ProductInfo({super.key});

  final ProductInfoController con = Get.put(ProductInfoController());

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const RangeMaintainingScrollPhysics(), children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: 48),
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Text(
                      detail.values.first,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      (defaultPadding / 2).verticalSpace,

/*      /// RELATED PRODUCTS
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
      (defaultPadding * 1.5).verticalSpace,*/
    ]);
  }

  Widget relatedProductsView(BuildContext context) {
    return Padding(
      padding: /*bodyPadding*/ EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: Wrap(
        children: List.generate(
          2,
          (index) => GestureDetector(
            // onDoubleTap: () {
            //   printOkStatus("---");
            //   Get.toNamed(
            //     AppRoutes.productDetailsScreen,
            //     arguments: {
            //       // "brandName": con.brandList[index]["brandName"],
            //     },
            //   );
            // },
            // behavior: HitTestBehavior.opaque,
            onTap: () {
              printOkStatus("---");
              Get.toNamed(
                AppRoutes.productDetailsScreen,
                preventDuplicates: false,
                arguments: {
                  // "brandName": con.brandList[index]["brandName"],
                },
              );
            },
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
                            selectedIcon: SvgPicture.asset(AppAssets.basketShoppingSimple, colorFilter: ColorFilter.mode(AppColors.lightSecondary, BlendMode.srcIn), height: 20, width: 20),
                            // ignore: deprecated_member_use
                            unSelectedIcon: SvgPicture.asset(AppAssets.basketShopping, color: AppColors.lightSecondary, height: 20, width: 20),
                            // ignore: deprecated_member_use
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
