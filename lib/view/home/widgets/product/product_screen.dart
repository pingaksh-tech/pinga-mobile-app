import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';

import '../../../../packages/like_button/like_button.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_network_image.dart';
import '../../components/product_sort_tile.dart';
import 'product_controller.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController con = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
        title: "Rings",
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      width: Get.width,
                      padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                        border: Border.all(color: Theme.of(context).iconTheme.color!.withAlpha(15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Sort by",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.titleStyle(context).copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.close_sharp),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: con.sortOptions.length,
                              itemBuilder: (context, index) => ProductSortTile(
                                isCheck: con.sortOptions[index]["isChecked"],
                                title: con.sortOptions[index]["title"],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.sortIcon,
                      height: 18.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
                    ).paddingOnly(right: defaultPadding),
                    Text(
                      "Sort",
                      style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
                child: const VerticalDivider(
                  thickness: 1.5,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.filter,
                    height: 20.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
                  ).paddingOnly(right: defaultPadding / 2),
                  Text(
                    "Filter",
                    style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 15.sp),
                  ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 1.5,
            indent: defaultPadding / 2,
            endIndent: defaultPadding / 2,
          ),
          Wrap(
            children: List.generate(
              10,
              (index) => Container(
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
                              "Gshgdghg",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            UiUtils.amountFormat("458454", symbol: "₹"),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
