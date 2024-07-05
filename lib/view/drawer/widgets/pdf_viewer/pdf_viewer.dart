import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'pdf_controller.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key});

  final PdfController con = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    final Completer<PDFViewController> _controller = Completer<PDFViewController>();
    printWhite(con.pdfFile);
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: con.pdfTitle.value,
        ),
        // body: SfPdfViewer.memory(con.temp ?? Uint8List(3)),
        body: Container(
          color: Colors.red,
          child: PDFView(
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
          ),
        ),
      );
    });
  }
}
