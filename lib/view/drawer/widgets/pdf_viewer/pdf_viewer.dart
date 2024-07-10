import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'pdf_controller.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key});

  final PdfController con = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    // final Completer<PDFViewController> _controller = Completer<PDFViewController>();
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: con.pdfTitle.value,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
          ),
        ),
        body: Center(
          child: con.pdfFile.path.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: appButtonHeight * 2),
                  child: Text(
                    "PDF Loading....",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor),
                  ))
              : const SizedBox.shrink(),
        ) /*PDFView(
          filePath: con.pdfFile.path,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (_pages) {
            // setState(() {
            //   pages = _pages;
            //   isReady = true;
            // });
          },
          // onError: (error) {
          //   printWarning(error.toString());
          // },
          onPageError: (page, error) {
            printWarning('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int? page, int? total) {
            printOkStatus('page change: $page/$total');
          },
        )*/
        ,
      );
    });
  }
}
