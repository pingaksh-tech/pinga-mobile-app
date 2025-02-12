import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/home/catalogue_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_dialog.dart';
import '../../../../res/empty_element.dart';
import '../../../../res/pop_up_menu_button.dart';
import '../../../../utils/app_datetime_formator.dart';
import '../../../../widgets/pull_to_refresh_indicator.dart';
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
        return PullToRefreshIndicator(
          onRefresh: () => CatalogueRepository.getCatalogue(isPullToRefresh: true),
          child: ListView(
            controller: con.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(defaultPadding),
            children: [
              con.loader.isFalse
                  ? con.catalogueList.isNotEmpty
                      ? Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: con.catalogueList.length,
                              separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                              itemBuilder: (context, index) => Obx(
                                () {
                                  return catalogueTile(
                                    context,
                                    index: index,
                                    title: con.catalogueList[index].name,
                                    subtitle: con.catalogueList[index].name?.value,
                                    date: con.catalogueList[index].createdAt.toString(),
                                    onPressed: () {
                                      CatalogueRepository.resetDownloadRequest();
                                      Get.toNamed(
                                        AppRoutes.pdfViewerScreen,
                                        arguments: {
                                          "title": con.catalogueList[index].name?.value,
                                          "catalogueId": con.catalogueList[index].id ?? "",
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            /// PAGINATION LOADER
                            Visibility(
                              visible: con.paginationLoader.isTrue,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2).copyWith(top: 0),
                                child: shimmerTile(),
                              ),
                            )
                          ],
                        )
                      :

                      /// EMPTY DATA VIEW
                      EmptyElement(
                          title: "Catalogue Not Found!",
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: Get.width / 2.5),
                        )
                  :

                  /// LOADING VIEW
                  shimmerListView()
            ],
          ),
        );
      }),
    );
  }

  Widget shimmerTile({bool showShimmer = true}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      width: Get.width,
      height: Get.width / 4,
      child: showShimmer
          ? ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                borderRadiusSize: defaultRadius,
              ),
            )
          : const SizedBox(),
    );
  }

  Widget shimmerListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => shimmerTile(),
      itemCount: 10,
    );
  }

  Widget catalogueTile(BuildContext context, {RxString? title, String? subtitle, String? date, int index = 0, required VoidCallback onPressed}) {
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
                      title?.value ?? '',
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
                menuList: const [/*"Download",*/ "Rename", "Delete"],
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
                    /*  case "Download":
                      await CatalogueRepository.downloadCatalogueAPI(catalogueId: con.catalogueList[index].id ?? "", catalogueType: CatalogueType.grid).then(
                        (value) {
                          // FileDownloaderFlutter().;
                        },
                      );
                      // UiUtils.toast("Downloading...");
                      break;*/

                    case "Rename":
                      AppDialogs.renameCatalogueDialog(
                        context,
                        name: con.catalogueList[index].name?.value ?? "",
                        dialogTitle: "Rename Catalogue",
                        title: "Enter name",
                        onChanged: (val) async {
                          if (!isValEmpty(val)) {
                            con.catalogueList[index].name?.value = val;

                            /// RENAME CATALOGUE
                            await CatalogueRepository.renameCatalogueAPI(catalogueId: con.catalogueList[index].id ?? "", catalogueName: val);
                          }
                        },
                      );
                      break;
                    case "Delete":

                      /// DELETE CATALOGUE API
                      await CatalogueRepository.deleteCatalogueAPI(catalogueId: con.catalogueList[index].id ?? "");
                      break;
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
