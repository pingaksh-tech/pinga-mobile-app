import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/empty_element.dart';
import '../../../../res/tab_bar.dart';
import '../../components/cart_summary_simmer.dart';
import 'summary_controller.dart';

class SummaryScreen extends StatelessWidget {
  SummaryScreen({super.key});

  final SummaryController con = Get.put(SummaryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: MyAppBar(
              title: "Summary/Weight",
              centerTitle: false,
            ),
            body: con.isLoading.isFalse
                ? con.diamondSummaryList.isNotEmpty
                    ? Column(
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
                                    Expanded(
                                      child: ListView.builder(
                                        physics: const RangeMaintainingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                                        shrinkWrap: true,
                                        itemCount: con.diamondSummaryList.length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            summaryTile(
                                              context,
                                              image: AppAssets.deliveryIcon,
                                              titleText: "Delivery",
                                              subtitleText: con.diamondSummaryList[index].id ?? "",
                                            ),
                                            (defaultPadding / 4).verticalSpace,
                                            summaryTile(
                                              context,
                                              image: AppAssets.quantityIcon,
                                              titleText: "Quantity",
                                              subtitleText: con.diamondSummaryList[index].totalQuantity.toString(),
                                            ),
                                            (defaultPadding / 4).verticalSpace,
                                            summaryTile(
                                              context,
                                              image: AppAssets.mrpSVG,
                                              titleText: "MRP",
                                              subtitleText: UiUtils.amountFormat(con.diamondSummaryList[index].totalAmount, decimalDigits: 2),
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
                                    ),
                                    Container(
                                      width: Get.width,
                                      margin: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                                      padding: EdgeInsets.all(defaultPadding / 1.5),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(
                                          defaultRadius,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          totalPriceTile(context, title: "Total Quantity", subTitle: con.totalDiamond.value.totalQty.toString()),
                                          totalPriceTile(
                                            context,
                                            title: "Total Amount",
                                            subTitle: UiUtils.amountFormat(con.totalDiamond.value.totalAmount.toString(), decimalDigits: 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                //? Weight TabBar View
                                Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        physics: const RangeMaintainingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                                        shrinkWrap: true,
                                        itemCount: con.weightSummaryList.length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            summaryTile(
                                              context,
                                              image: AppAssets.diamondIcon,
                                              titleText: "Diamond",
                                              subtitleText: con.weightSummaryList[index].id ?? "",
                                            ),
                                            (defaultPadding / 4).verticalSpace,
                                            summaryTile(
                                              context,
                                              image: AppAssets.metalWeight,
                                              titleText: "Metal Wt",
                                              subtitleText: con.weightSummaryList[index].metalWeight.toString(),
                                            ),
                                            (defaultPadding / 4).verticalSpace,
                                            summaryTile(
                                              context,
                                              image: AppAssets.diamondWeight,
                                              titleText: "Diamond Wt",
                                              subtitleText: con.weightSummaryList[index].diamondWeight.toString(),
                                              subTitleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                            ),
                                            Divider(color: AppColors.lightGrey.withOpacity(0.5)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width,
                                      margin: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
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
                                            subTitle: con.totalWeight.value.totalMetalWeight.toString(),
                                          ),
                                          totalPriceTile(
                                            context,
                                            title: "Total diamond wt",
                                            subTitle: con.totalWeight.value.totalDiamondWeight.toString(),
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
                      )
                    : const EmptyElement(title: "Cart Summary not found!")
                : ListView.separated(
                    padding: EdgeInsets.all(defaultPadding),
                    separatorBuilder: (context, index) => defaultPadding.verticalSpace,
                    itemBuilder: (context, index) => const CartSummarySimmer(),
                    itemCount: 5,
                  )),
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
