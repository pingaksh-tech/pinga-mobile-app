import 'package:flutter/material.dart' as widget;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../data/model/catalog/get_catalog_pdf_model.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'pdf_preview_controller.dart';

class PdfPreviewScreen extends widget.StatelessWidget {
  PdfPreviewScreen({super.key});

  final PdfPreviewController con = Get.put(PdfPreviewController());

  @override
  widget.Widget build(widget.BuildContext context) {
    return Obx(
      () => widget.Scaffold(
        backgroundColor: widget.Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "${con.pdfTitle.value} PDF Preview",
          actions: [
            AppIconButton(
              icon: SvgPicture.asset(AppAssets.shareIcon),
              onPressed: () async {
                if (con.docPdf?.value != null) {
                  await Printing.sharePdf(bytes: con.docPdf!.value, filename: '${con.pdfTitle.value}(Pingaksh).pdf');
                }
              },
            ),
            (defaultPadding / 2).horizontalSpace,
          ],
        ),
        body: con.isLoader.isFalse
            ? PdfPreview(
                pdfFileName: '${con.pdfTitle.value}(Pingaksh).pdf',
                previewPageMargin: const widget.EdgeInsets.only(bottom: 15),
                allowPrinting: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
                allowSharing: false,
                pdfPreviewPageDecoration: const widget.BoxDecoration(color: widget.Colors.white),
                loadingWidget: const CircularLoader(),
                build: (format) async {
                  final Document doc = Document(pageMode: PdfPageMode.fullscreen);
                  final Document exportDoc = Document(pageMode: PdfPageMode.fullscreen);

                  /// Font Family
                  final Font montserratBold = Font.ttf(await rootBundle.load(AppAssets.montserratBold));
                  final Font montserratMedium = Font.ttf(await rootBundle.load(AppAssets.montserratMedium));

                  TextStyle commonMediumStyle = TextStyle(fontSize: 12.sp, font: montserratMedium);
                  TextStyle commonBoldText = TextStyle(fontSize: 12.sp, font: montserratBold);

                  final PdfColor primaryColor = PdfColor.fromHex(AppColors.fromColor(widget.Theme.of(context).primaryColor));

                  // images beforehand
                  List<Uint8List?> productImages = [];
                  for (var product in con.productList) {
                    productImages.add(await con.loadImageFromUrl(product.inventoryImage ?? ''));
                  }

                  doc.addPage(
                    index: 0,
                    multiPage(
                      format: format,
                      montserratBold: montserratBold,
                      montserratMedium: montserratMedium,
                      commonBoldText: commonBoldText,
                      commonMediumStyle: commonMediumStyle,
                      primaryColor: primaryColor,
                      productImages: productImages,
                      productList: con.productList,
                      isListView: false,
                    ),
                  );

                  exportDoc.addPage(
                    index: 0,
                    multiPage(
                      format: format,
                      montserratBold: montserratBold,
                      montserratMedium: montserratMedium,
                      commonBoldText: commonBoldText,
                      commonMediumStyle: commonMediumStyle,
                      primaryColor: primaryColor,
                      productImages: productImages,
                      productList: con.productList,
                      isListView: false,
                    ),
                  );
                  con.docPdf?.value = await exportDoc.save();
                  if (con.isFromCatalog.isFalse) {
                    con.downloadPDF(isDownload: true);
                  }
                  return await doc.save();
                },
              )
            : const CircularLoader(),
      ),
    );
  }
}

MultiPage multiPage({
  required PdfPageFormat format,
  required PdfColor primaryColor,
  required Font montserratBold,
  required Font montserratMedium,
  required TextStyle commonBoldText,
  required TextStyle commonMediumStyle,
  List<Uint8List?>? productImages,
  required List<CatalogPdfModel> productList,
  bool isListView = false,
}) {
  return MultiPage(
    pageTheme: PageTheme(
      margin: const EdgeInsets.symmetric(horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm).copyWith(top: defaultPadding),
      textDirection: TextDirection.ltr,
      orientation: PageOrientation.portrait,
      pageFormat: format.copyWith(
        marginBottom: 0,
        marginLeft: 40,
        marginRight: 40,
        marginTop: 0,
      ),
    ),
    build: (context) => [
      !isListView
          ? Container(
              child: GridView(
                childAspectRatio: 1.6,
                crossAxisCount: 3,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                children: List.generate(
                  productList.length,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          /// Image
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: AspectRatio(
                              aspectRatio: 1.3,
                              child: !isValEmpty(productImages?[index])
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                              Uint8List.fromList(productImages![index]!),
                                            ),
                                          )),
                                    )
                                  : Container(
                                      child: SvgImage(
                                        svg: AppAssets.placeHolderImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),

                          /// Name
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                children: [
                                  SizedBox(height: defaultPadding),

                                  Text("${productList[index].name}", style: commonBoldText, textAlign: TextAlign.center, maxLines: 2),
                                  SizedBox(height: defaultPadding),

                                  /// Collection
                                  Text("Collection: -", style: commonMediumStyle, textAlign: TextAlign.center),
                                  SizedBox(height: defaultPadding),

                                  /// MRP
                                  Text("MRP: ${productList[index].price}", style: commonMediumStyle.copyWith(color: PdfColor.fromHex("#993F8A")), textAlign: TextAlign.center),
                                  SizedBox(height: defaultPadding / 2),
                                ],
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          : Container(
              child: ListView(
                spacing: defaultPadding,
                direction: Axis.vertical,
                children: List.generate(
                  productList.length,
                  (index) {
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          /// Image
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: AspectRatio(
                              aspectRatio: 1.1,
                              child: productImages != null && !isValEmpty(productImages[index])
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                              Uint8List.fromList(productImages[index]!),
                                            ),
                                          )),
                                    )
                                  : Container(
                                      child: SvgImage(
                                        svg: AppAssets.placeHolderImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(width: defaultPadding),

                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(height: defaultPadding),

                              Text("${productList[index].name}", style: commonBoldText, textAlign: TextAlign.center),
                              SizedBox(height: defaultPadding),

                              /// Collection
                              Text("Collection: -", style: commonMediumStyle, textAlign: TextAlign.center),
                              SizedBox(height: defaultPadding),

                              /// MRP
                              Text("MRP: ${productList[index].price}", style: commonMediumStyle.copyWith(color: PdfColor.fromHex("#993F8A")), textAlign: TextAlign.center),
                              SizedBox(height: defaultPadding / 2),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    ],
  );
}
