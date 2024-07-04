import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_dialog.dart';
import '../../../../res/pop_up_menu_button.dart';
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
            index: index,
            title: con.catalogueList[index].name,
            subtitle: "",
            date: defaultDateTime.toString(),
            onPressed: () {
              Get.toNamed(AppRoutes.pdfViewerScreen, arguments: {"title": con.catalogueList[index].name});
            },
          ),
        );
      }),
    );
  }

  Widget catalogueTile(BuildContext context, {String? title, String? subtitle, String? date, int index = 0, required VoidCallback onPressed}) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius),
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: defaultShadowAllSide,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Container(
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
              AppPopUpMenuButton(
                menuList: const ["Download", "Share", "Rename", "Delete"],
                child: Icon(
                  shadows: const [Shadow(color: AppColors.background, blurRadius: 4)],
                  Icons.more_vert_rounded,
                  size: 18.sp,
                ),
                onSelect: (val) async {
                  switch (val) {
                    /*   case "show":
                      Get.toNamed(AppRoutes.pdfViewerScreen, arguments: {"title": title});
                      break;*/
                    case "download":
                      UiUtils.toast("Downloading...");
                      break;
                    case "share":

                      /// share wishlist
                      await Share.share(
                        "Catalogue : $title\nCreated Date : $date",
                      );
                      break;
                    case "rename":
                      AppDialogs.renameCatalogueDialog(
                        context,
                        name: con.catalogueList[index].name,
                        dialogTitle: "Rename Catalogue",
                        title: "Enter name",
                        onChanged: (val) {
                          con.catalogueList[index].name = val;
                        },
                      );
                      break;
                    case "delete":
                      con.catalogueList.removeAt(index);
                      break;
                  }
                },
              )
              // AppIconButton(
              //   size: 20.sp,
              //   icon: Icon(
              //     shadows: const [Shadow(color: AppColors.background, blurRadius: 4)],
              //     Icons.more_vert_rounded,
              //     size: 18.sp,
              //   ),
              //   onPressed: () {
              //     Get.toNamed(AppRoutes.pdfViewerScreen, arguments: {"title": title});
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
