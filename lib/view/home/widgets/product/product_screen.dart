import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';

import '../../../../res/app_bar.dart';
import '../../../../res/app_network_image.dart';
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
                    builder: (context) => IntrinsicHeight(
                      child: Container(
                          width: Get.width,
                          padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                            border: Border.all(color: Theme.of(context).iconTheme.color!.withAlpha(15)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sort by",
                                    style: AppTextStyle.titleStyle(context).copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.close_sharp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      value: false,
                                      onChanged: (value) {},
                                      side: BorderSide(
                                        color: AppColors.font.withOpacity(0.5),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Price - Low to High",
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 30,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55),
                    ).paddingOnly(right: defaultPadding / 2),
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
                  Icon(
                    Icons.filter_alt_rounded,
                    size: 30,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55),
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
          Text(
            "Total Products 4098",
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitleStyle(context).copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp),
          ).paddingOnly(bottom: defaultPadding),
          Wrap(
            children: List.generate(
              10,
              (index) => Container(
                width: Get.width / 2 - defaultPadding * 1.5,
                margin: EdgeInsets.all(defaultPadding / 2).copyWith(bottom: defaultPadding),
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.width / 2 - defaultPadding,
                      child: AppNetworkImage(
                        imageUrl: "https://i.pinimg.com/736x/71/56/2b/71562bfee51fd6ffb222dae63e605eec.jpg",
                        fit: BoxFit.fill,
                        padding: EdgeInsets.only(bottom: defaultPadding / 2),
                        borderRadius: BorderRadius.circular(defaultRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PLRMKN1033(KISNA FG)",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.sp),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "₹ 1,90,280",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            Icon(Icons.more_vert_rounded, color: Theme.of(context).primaryColor)
                          ],
                        ),
                      ],
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
