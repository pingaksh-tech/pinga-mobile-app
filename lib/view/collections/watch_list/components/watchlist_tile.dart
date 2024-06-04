import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../widgets/custom_check_box_tile.dart';
import 'icon_title_button.dart';

class WatchlistTile extends StatelessWidget {
  final String? name;
  final int? noOfItem;
  final String? createdBy;
  final VoidCallback? downloadOnPressed;
  final VoidCallback? shareOnPressed;
  final VoidCallback? deleteOnPressed;
  final VoidCallback? cartOnPressed;
  final bool? isShowButtons;
  final RxBool? selected;
  final void Function(bool?)? onChanged;

  const WatchlistTile({
    super.key,
    this.name,
    this.noOfItem,
    this.createdBy,
    this.downloadOnPressed,
    this.shareOnPressed,
    this.deleteOnPressed,
    this.isShowButtons = true,
    this.selected,
    this.onChanged,
    this.cartOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding / 1.5).copyWith(right: defaultPadding / 4, top: defaultPadding / 4),
      decoration: BoxDecoration(
        boxShadow: defaultShadow(context),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: defaultPadding / 2.8),
            child: Column(
              children: [
                titleSubtitleTile(context, title: "Name${'\t' * 15}:  ", subTitle: name ?? ''),
                titleSubtitleTile(context, title: "No. of items${'\t' * 4}:  ", subTitle: noOfItem.toString()),
                titleSubtitleTile(context, title: "Created by${'\t' * 7}:  ", subTitle: createdBy ?? ''),
                if (isShowButtons ?? true) ...[
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// CART
                      IconTitleButton(
                        title: "Add to Cart",
                        icon: AppAssets.cart,
                        onPressed: cartOnPressed,
                      ),

                      /// DOWNLOAD
                      IconTitleButton(
                        title: "Download",
                        icon: AppAssets.downloadIcon,
                        onPressed: downloadOnPressed,
                      ),

                      /// SHARE
                      IconTitleButton(
                        title: "Share",
                        icon: AppAssets.shareIcon,
                        onPressed: shareOnPressed,
                      ),

                      /// DELETE
                      IconTitleButton(
                        title: "Delete",
                        icon: AppAssets.trash,
                        onPressed: deleteOnPressed,
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
          if (selected != null)
            Positioned(
              right: 0,
              top: 0,
              child: CustomCheckboxTile(
                scale: 1,
                isSelected: selected ?? RxBool(false),
                titleStyle: null,
                onChanged: onChanged,
              ),
            ),
        ],
      ),
    );
  }

  Widget titleSubtitleTile(BuildContext context, {required String title, required String subTitle}) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font.withOpacity(.5)),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: AppColors.font),
        )
      ],
    );
  }
}
