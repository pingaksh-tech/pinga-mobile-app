import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/model/product/products_model.dart';
import '../../../../exports.dart';

class DiamondsTab extends StatelessWidget {
  final List<DiamondListModel> diamondList;

  const DiamondsTab({super.key, required this.diamondList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: 52, bottom: defaultPadding * 5),
      itemCount: diamondList.length,
      separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 2),
      itemBuilder: (context, index) => Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
            boxShadow: defaultShadowAllSide,
          ),
          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Clarity  : ${diamondList[index].diamondClarity?.value ?? '-'}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Text(
                    UiUtils.amountFormat(diamondList[index].totalPrice ?? 0, decimalDigits: 2),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              Text(
                "Shape     : ${diamondList[index].diamondShape ?? '-'}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font.withOpacity(.6)),
              ),
              Text(
                "Quantity  : ${diamondList[index].diamondCount ?? '-'}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font.withOpacity(.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
