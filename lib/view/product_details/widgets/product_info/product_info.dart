import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../product_details_controller.dart';
import 'product_info_controller.dart';

class ProductInfoTab extends StatelessWidget {
  final List<MapEntry> infoList;

  ProductInfoTab({super.key, required this.infoList});

  final ProductInfoController con = Get.put(ProductInfoController());
  final ProductDetailsController productDetailsCon = Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      // physics: const RangeMaintainingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Table(
            border: TableBorder.all(color: Theme.of(context).dividerColor.withOpacity(0.15)),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: [
              ...List.generate(
                productDetailsCon.productDetailModel.value.productInfo?.toJson().length ?? 0,
                (index) => TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        con.formatKey((infoList[index]).key),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        ((infoList[index].value).runtimeType == List && ((infoList[index]).value as List).isEmpty) ? "-" : "${(infoList[index]).value ?? ""}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        (defaultPadding / 2).verticalSpace,
      ],
    );
  }
}
