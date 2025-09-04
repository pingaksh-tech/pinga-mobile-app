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
import '../../../../packages/cached_network_image/cached_network_image.dart';
import '../../../../res/app_bar.dart';
import '../../../../utils/device_utils.dart';
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
            if (con.isFromCatalog.isFalse)
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
            ? con.isFromCatalog.isTrue
                ? con.productList.isNotEmpty
                    ? widget.SafeArea(
                        child: widget.Padding(
                          padding: widget.EdgeInsets.all(defaultPadding),
                          child: widget.GridView.builder(
                            gridDelegate: widget.SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: DeviceUtil.isTablet(context) ? 4 : 3,
                              crossAxisSpacing: defaultPadding / 2,
                              mainAxisSpacing: defaultPadding / 2,
                              childAspectRatio: 2 / 3.3, // Match PDF aspect ratio
                            ),
                            itemCount: con.productList.length,
                            itemBuilder: (context, index) {
                              final product = con.productList[index];
                              return widget.Container(
                                decoration: widget.BoxDecoration(
                                  border: widget.Border.all(),
                                  borderRadius: widget.BorderRadius.circular(10),
                                ),
                                child: widget.Column(
                                  children: [
                                    widget.Padding(
                                      padding: const widget.EdgeInsets.only(bottom: 3),
                                      child: widget.AspectRatio(
                                        aspectRatio: 1.3,
                                        child: /*product.inventoryImage != null && product.inventoryImage!.isNotEmpty
                                            ?*/
                                            AppNetworkImage(
                                          imageUrl: product.inventoryImage ?? "",
                                          borderRadius: widget.BorderRadius.circular(10),
                                          fit: widget.BoxFit.cover,
                                        ),

                                        /*widget.ClipRRect(
                                                borderRadius: widget.BorderRadius.circular(10),
                                                child: widget.Image.network(
                                                  product.inventoryImage!,
                                                  fit: widget.BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) => const widget.Icon(widget.Icons.broken_image),
                                                ),
                                              )*/
                                        /*  : widget.Container(
                                                alignment: widget.Alignment.center,
                                                child: SvgPicture.asset(AppAssets.placeHolderImage, fit: widget.BoxFit.cover),
                                              ),*/
                                      ),
                                    ),
                                    widget.Padding(
                                      padding: const widget.EdgeInsets.symmetric(horizontal: 8),
                                      child: widget.Column(
                                        children: [
                                          widget.SizedBox(height: defaultPadding),
                                          widget.Text(
                                            product.name ?? '',
                                            style: const widget.TextStyle(
                                              fontSize: 10,
                                              fontWeight: widget.FontWeight.bold,
                                            ),
                                            /* widget.Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: widget.FontWeight.bold,
                                              fontSize: 10,
                                            ),*/
                                            textAlign: widget.TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          widget.SizedBox(height: defaultPadding),
                                          //TODO: ADD Collection Name
                                          const widget.Text(
                                            "Collection: -",
                                            style: widget.TextStyle(fontSize: 10),
                                            textAlign: widget.TextAlign.center,
                                          ),
                                          widget.SizedBox(height: defaultPadding),
                                          widget.Text(
                                            "MRP: \t${UiUtils.amountFormat(product.price ?? 0)}",
                                            style: const widget.TextStyle(
                                              fontSize: 10,
                                              color: widget.Color(0xFF993F8A),
                                            ),
                                            textAlign: widget.TextAlign.center,
                                          ),
                                          widget.SizedBox(height: defaultPadding / 2),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const widget.Center(
                        child: widget.Text(
                        "NO ITEM FOUND",
                        style: widget.TextStyle(
                          fontSize: 18,
                          color: AppColors.lightGrey,
                          fontWeight: widget.FontWeight.bold,
                        ),
                      ))
                : PdfPreview(
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
                      // if (con.isFromCatalog.isFalse) {
                      //   con.downloadPDF(isDownload: true);
                      // }
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

                                  //TODO: ADD Collection Name
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
