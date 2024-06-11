import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../utils/app_datetime_formator.dart';
import 'catalogue_controller.dart';

class CatalogueScreen extends StatelessWidget {
  CatalogueScreen({super.key});

  final CatalogueController con = Get.put(CatalogueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Catalogue",
      ),
      body: Obx(() {
        return ListView.separated(
          physics: const RangeMaintainingScrollPhysics(),
          padding: EdgeInsets.all(defaultPadding),
          itemCount: con.catalogueList.length,
          separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
          itemBuilder: (context, index) => catalogueTile(
            context,
            title: con.catalogueList[index].title,
            subtitle: con.catalogueList[index].subtitle,
            date: con.catalogueList[index].createdAt.toString(),
          ),
        );
      }),
    );
  }

  Widget catalogueTile(BuildContext context, {String? title, String? subtitle, String? date}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: defaultShadowAllSide,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      padding: EdgeInsets.all(defaultPadding / 1.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Theme.of(context).primaryColor.withOpacity(.05),
            ),
            child: SvgPicture.asset(
              height: 20.h,
              AppAssets.catalogueAlt,
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor.withOpacity(.6), BlendMode.srcIn),
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                Text(
                  subtitle ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.font.withOpacity(.5),
                      ),
                ),
                Text(
                  AppDateTimeFormatter.formatDateInDigit(date ?? ''),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.font.withOpacity(.5),
                      ),
                ),
              ],
            ),
          ),
          AppIconButton(
            size: 20.sp,
            icon: Icon(
              shadows: const [Shadow(color: AppColors.background, blurRadius: 4)],
              Icons.more_vert_rounded,
              size: 18.sp,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.pdfViewerScreen, arguments: {"title": title});
            },
          )
        ],
      ),
    );
  }
}
