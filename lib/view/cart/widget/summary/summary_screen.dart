import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/tab_bar.dart';
import 'summary_controller.dart';

class SummaryScreen extends StatelessWidget {
  SummaryScreen({super.key});

  final SummaryController con = Get.put(SummaryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "Summary/Weight",
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              (defaultPadding / 2).verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.textFiledBorder,
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius - 3),
                ),
                child: const MyTabBar(
                  tabs: [
                    Text(
                      "Summary",
                    ),
                    Text(
                      "Weight",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        ListView.builder(
                          physics: const RangeMaintainingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                          shrinkWrap: true,
                          itemCount: con.summaryList.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              summaryTile(
                                context,
                                image: AppAssets.deliveryIcon,
                                titleText: "Delivery",
                                subtitleText: "15 Days",
                              ),
                              (defaultPadding / 4).verticalSpace,
                              summaryTile(
                                context,
                                image: AppAssets.quantityIcon,
                                titleText: "Quantity",
                                subtitleText: "18",
                              ),
                              (defaultPadding / 4).verticalSpace,
                              summaryTile(
                                context,
                                image: AppAssets.mrpIcon,
                                titleText: "MRP",
                                subtitleText: UiUtils.amountFormat("1250041", decimalDigits: 0),
                                subTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                              Divider(
                                color: AppColors.lightGrey.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                          padding: EdgeInsets.all(defaultPadding / 1.5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(
                              defaultRadius,
                            ),
                          ),
                          child: Column(
                            children: [
                              totalPriceTile(context, title: "Total quantity", subTitle: "98"),
                              totalPriceTile(
                                context,
                                title: "Total amount",
                                subTitle: UiUtils.amountFormat(1052001, decimalDigits: 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //? Weight TabBar View
                    Column(
                      children: [
                        ListView.builder(
                          physics: const RangeMaintainingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                          shrinkWrap: true,
                          itemCount: con.summaryList.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              summaryTile(
                                context,
                                image: AppAssets.diamondIcon,
                                titleText: "Diamond Type",
                                subtitleText: "Solitare",
                              ),
                              (defaultPadding / 4).verticalSpace,
                              summaryTile(
                                context,
                                image: AppAssets.metalWeight,
                                titleText: "Metal Wt",
                                subtitleText: "125.16",
                              ),
                              (defaultPadding / 4).verticalSpace,
                              summaryTile(
                                context,
                                image: AppAssets.diamondWeight,
                                titleText: "Diamond Wt",
                                subtitleText: "0.37",
                                subTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                              Divider(color: AppColors.lightGrey.withOpacity(0.5)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                          padding: EdgeInsets.all(defaultPadding / 1.5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(
                              defaultRadius,
                            ),
                          ),
                          child: Column(
                            children: [
                              totalPriceTile(
                                context,
                                title: "Total metal wt",
                                subTitle: "5024.12",
                              ),
                              totalPriceTile(
                                context,
                                title: "Total diamond wt",
                                subTitle: "1.2",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryTile(
    BuildContext context, {
    required String image,
    required String titleText,
    required String subtitleText,
    TextStyle? subTitleStyle,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: 15.h,
        ),
        (defaultPadding / 3).horizontalSpace,
        Expanded(
          child: Text(
            titleText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          subtitleText,
          style: subTitleStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget totalPriceTile(BuildContext context, {required String title, required String subTitle}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ],
    );
  }
}
