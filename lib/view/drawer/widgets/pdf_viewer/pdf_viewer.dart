import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../res/app_bar.dart';
import 'pdf_controller.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key});

  final PdfController con = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: con.pdfTitle.value,
      ),
      body: SfPdfViewer.network(
        "https://css4.pub/2015/icelandic/dictionary.pdf",
      ),
    );
  }
}
