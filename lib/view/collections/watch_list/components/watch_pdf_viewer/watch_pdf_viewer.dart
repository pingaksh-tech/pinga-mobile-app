import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// import '../../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../../exports.dart';
import '../../../../../res/app_bar.dart';

import 'watch_pdf_controller.dart';

class WatchPdfViewerScreen extends StatelessWidget {
  WatchPdfViewerScreen({super.key});

  final WatchPdfController con = Get.put(WatchPdfController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        onPopInvoked: (didPop) {
          if (con.isDownloading.value) {
            con.isDownloading.value = false;
            WatchListRepository.cancelDownloadRequest();
          }
        },
        canPop: con.isDownloading.isFalse,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: MyAppBar(
            title: con.pdfTitle.value,
            showBackIcon: false,
            leading: IconButton(
              onPressed: () {
                WatchListRepository
                    .cancelDownloadRequest(); // This will cancel the ongoing API request
                Get.back();
              },
              icon: SvgPicture.asset(
                height: 30,
                AppAssets.backArrowIcon,
                color: AppColors.primary, // ignore: deprecated_member_use
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: LinearProgressIndicator(
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          body: Center(
            child: con.pdfFile.path.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: appButtonHeight * 2),
                    child: Text(
                      "PDF Loading....",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ))
                : const SizedBox.shrink(),
          ),
        ),
      );
    });
  }
}
