// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart'; // for compute()
// import 'package:image/image.dart' as img;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// import '../../../../data/model/catalog/get_catalog_pdf_model.dart';
// import '../../../../data/repositories/home/catalogue_repository.dart';
// import '../../../../data/repositories/watchlist/watchlist_repository.dart';
// import '../../../../exports.dart';
//
// class PdfPreviewController extends GetxController {
//   RxBool isListView = false.obs;
//   RxBool isLoader = false.obs;
//
//   Rx<Uint8List>? docPdf = Uint8List(0).obs;
//   RxList<CatalogPdfModel> productList = <CatalogPdfModel>[].obs;
//
//   RxString catalogueId = ''.obs;
//   RxString pdfTitle = ''.obs;
//   RxBool isFromCatalog = true.obs;
//
//   final Dio _dio = Dio();
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (Get.arguments != null) {
//       if (Get.arguments["title"].runtimeType == String) {
//         pdfTitle.value = Get.arguments["title"];
//       }
//       if (Get.arguments["catalogueId"].runtimeType == String) {
//         catalogueId.value = Get.arguments["catalogueId"];
//       }
//       if (Get.arguments["isFromCatalog"].runtimeType == bool) {
//         isFromCatalog.value = Get.arguments["isFromCatalog"];
//       }
//     }
//   }
//
//   @override
//   void onReady() async {
//     super.onReady();
//
//     if (isFromCatalog.isTrue) {
//       await CatalogueRepository.downloadCatalogueAPI(
//         loader: isLoader,
//         catalogueId: catalogueId.value,
//         title: pdfTitle.value,
//         catalogueType: CatalogueType.grid,
//         onSuccess: () {},
//       );
//     } else {
//       await WatchListRepository.downloadWatchAPI(
//         loader: isLoader,
//         watchId: catalogueId.value,
//         title: pdfTitle.value,
//         onSuccess: () async {
//           preloadImagesInBackground();
//           generatePdfFromProducts();
//         },
//       );
//     }
//   }
//
//   /// 🔹 Load and compress image from URL
//   Future<Uint8List?> loadImageFromUrl(String imageUrl) async {
//     if (isValEmpty(imageUrl)) return null;
//     try {
//       final response = await _dio.get<List<int>>(
//         imageUrl,
//         options: Options(responseType: ResponseType.bytes),
//       );
//
//       final original = Uint8List.fromList(response.data ?? []);
//       final decoded = img.decodeImage(original);
//       if (decoded == null) return null;
//
//       // resize + compress for faster PDF
//       final resized = img.copyResize(decoded, width: 800);
//       return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
//     } catch (e) {
//       printErrors(
//         type: "loadImageFromUrl",
//         errText: 'Failed to load image from $imageUrl. Error: $e',
//       );
//       return null;
//     }
//   }
//
//   Future<List<pw.MemoryImage?>> preloadImagesInBackground() async {
//     final List<String> imageUrls = productList.map((e) => e.inventoryImage?.toString() ?? '').where((url) => url.isNotEmpty).toList();
//     return await compute(_loadImagesInBackground, imageUrls);
//   }
//
//   Future<List<pw.MemoryImage?>> _loadImagesInBackground(List<String> urls) async {
//     final dio = Dio();
//     final List<pw.MemoryImage?> images = [];
//
//     for (final url in urls) {
//       try {
//         final response = await dio.get<List<int>>(
//           url,
//           options: Options(responseType: ResponseType.bytes),
//         );
//
//         if (response.statusCode == 200 && response.data != null && response.data!.isNotEmpty) {
//           final original = Uint8List.fromList(response.data!);
//           final decoded = img.decodeImage(original);
//
//           if (decoded != null) {
//             final resized = img.copyResize(decoded, width: 900); // ✅ smaller width
//             final lower = url.toLowerCase();
//             final encoded = Uint8List.fromList(
//               lower.endsWith('.png') ? img.encodePng(resized) : img.encodeJpg(resized, quality: 85), // ✅ reduce quality slightly
//             );
//
//             images.add(pw.MemoryImage(encoded));
//           } else {
//             images.add(null);
//           }
//         } else {
//           images.add(null);
//         }
//       } catch (_) {
//         images.add(null);
//       }
//     }
//
//     return images;
//   }
//
//   /// 🔸 Generate PDF with all product images
//   Future<void> generatePdfFromProducts() async {
//     if (isLoader.value) return;
//     isLoader.value = true;
//     // ✅ Load fonts on main isolate (rootBundle only works here)
//     final boldData = await rootBundle.load(AppAssets.montserratBold);
//     final mediumData = await rootBundle.load(AppAssets.montserratMedium);
//
//     try {
//       // Run in background isolate to prevent UI freeze
//       final pdfBytes = await compute(_generatePdfInBackground, {
//         'products': productList.map((e) => e.toJson()).toList(),
//         'fontBold': boldData.buffer.asUint8List(),
//         'fontMedium': mediumData.buffer.asUint8List(),
//       });
//
//       docPdf!.value = pdfBytes;
//     } catch (e, st) {
//       printErrors(type: "generatePdfFromProducts", errText: e.toString());
//       printYellow(st);
//     } finally {
//       isLoader.value = false;
//     }
//   }
//
//   /// 🔸 Save the generated PDF to storage
//   Future<void> downloadPDF({bool isDownload = false}) async {
//     Directory appDocDir = Directory("");
//     if (isDownload) {
//       if (Platform.isAndroid) {
//         appDocDir = Directory("/storage/emulated/0/Download");
//       } else {
//         appDocDir = await getApplicationDocumentsDirectory();
//       }
//     } else {
//       appDocDir = await getTemporaryDirectory();
//     }
//
//     String appDocPath = appDocDir.path;
//     Directory catalogueDir = Directory("$appDocPath/pingaksh");
//
//     if (!await catalogueDir.exists()) {
//       await catalogueDir.create();
//     }
//
//     String filePath = '${catalogueDir.path}/${pdfTitle.value} ${DateTime.now().second}.pdf';
//
//     File file = File(filePath);
//     if (docPdf != null && docPdf!.value.isNotEmpty) {
//       await file.writeAsBytes(docPdf!.value);
//       printOkStatus('✅ File saved at $filePath');
//       if (isDownload) UiUtils.toast("PDF downloaded successfully");
//     } else {
//       printErrors(type: "downloadPDF", errText: "PDF data is empty!");
//     }
//   }
//
//   /// 🧠 Background isolate function (runs off UI thread)
//   Future<Uint8List> _generatePdfInBackground(Map<String, dynamic> args) async {
//     final products = args['products'] as List<dynamic>;
//
//     printYellow(products);
//     final fontBoldBytes = args['fontBold'];
//     final fontMediumBytes = args['fontMedium'];
//     final dio = Dio();
//     final pdf = pw.Document();
//
//     final List<pw.Widget> imageWidgets = [];
//
//     for (int i = 0; i < products.length; i++) {
//       final imageUrl = products[i]['inventory_image'] ?? '';
//       pw.MemoryImage? imgMem;
//
//       if (imageUrl.isNotEmpty) {
//         try {
//           printYellow('🔗 Fetching: $imageUrl');
//           final response = await dio.get<List<int>>(
//             imageUrl,
//             options: Options(
//               responseType: ResponseType.bytes,
//               followRedirects: true,
//               headers: {'User-Agent': 'FlutterApp'},
//             ),
//           );
//
//           if (response.statusCode == 200 && response.data != null && response.data!.isNotEmpty) {
//             final original = Uint8List.fromList(response.data!);
//
//             // ✅ Decode + resize + compress for PDF
//             final decoded = img.decodeImage(original);
//             if (decoded != null) {
//               // Limit size to keep memory safe but preserve detail
//               final resized = img.copyResize(decoded, width: 1200);
//
//               // ✅ Detect image type from URL (handles .png / .jpg / .jpeg / .webp)
//               final lowerUrl = imageUrl.toLowerCase();
//               Uint8List compressedBytes;
//
//               if (lowerUrl.endsWith('.png')) {
//                 // PNG → preserve transparency & lossless quality
//                 compressedBytes = Uint8List.fromList(img.encodePng(resized));
//               } else {
//                 // JPEG or any other → high-quality compression
//                 compressedBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 92));
//               }
//
//               // ✅ Create PDF image
//               imgMem = pw.MemoryImage(compressedBytes);
//               printYellow('✅ Image ready: ${compressedBytes.lengthInBytes} bytes');
//             } else {
//               printYellow('⚠️ Failed to decode image: $imageUrl');
//             }
//           } else {
//             printYellow('⚠️ Invalid response for image: $imageUrl');
//           }
//         } catch (e) {
//           printYellow('❌ Error loading image $imageUrl → $e');
//         }
//       }
//
//       // ✅ Load fonts from provided bytes
//       final montserratBold = pw.Font.ttf((fontBoldBytes as Uint8List).buffer.asByteData());
//       final montserratMedium = pw.Font.ttf((fontMediumBytes as Uint8List).buffer.asByteData());
//
//       final commonBoldText = pw.TextStyle(fontSize: 12, font: montserratBold);
//       final commonMediumStyle = pw.TextStyle(fontSize: 12, font: montserratMedium);
//       // Add the image or placeholder
//       // imageWidgets.add(
//       //   pw.Container(
//       //     width: 150,
//       //     height: 150,
//       //     decoration: pw.BoxDecoration(
//       //       border: pw.Border.all(color: PdfColors.grey, width: 0.5),
//       //     ),
//       //     child: imgMem != null
//       //         ? pw.Image(imgMem, fit: pw.BoxFit.cover)
//       //         : pw.Center(
//       //             child: pw.Text(
//       //               "No Image",
//       //               style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
//       //             ),
//       //           ),
//       //   ),
//       // );
//
//       imageWidgets.add(
//         pw.Container(
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(),
//             borderRadius: pw.BorderRadius.circular(10),
//           ),
//           child: pw.Column(
//             children: [
//               /// 🔹 Image section
//               pw.Padding(
//                 padding: const pw.EdgeInsets.only(bottom: 3),
//                 child: pw.AspectRatio(
//                   aspectRatio: 1.3,
//                   child: imgMem != null
//                       ? pw.Container(
//                           decoration: pw.BoxDecoration(
//                             borderRadius: pw.BorderRadius.circular(10),
//                             image: pw.DecorationImage(
//                               fit: pw.BoxFit.cover,
//                               image: imgMem,
//                             ),
//                           ),
//                         )
//                       : pw.Container(
//                           alignment: pw.Alignment.center,
//                           child: pw.Text(
//                             "No Image",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                               color: PdfColors.grey,
//                             ),
//                           ),
//                         ),
//                 ),
//               ),
//
//               /// 🔹 Name + Details section
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 4),
//                 child: pw.Column(
//                   children: [
//                     pw.SizedBox(height: 6),
//
//                     // Name
//                     pw.Text(
//                       products[i]["name"] ?? "-",
//                       style: commonBoldText,
//                       textAlign: pw.TextAlign.center,
//                       maxLines: 2,
//                     ),
//                     pw.SizedBox(height: 6),
//
//                     // Collection
//                     pw.Text(
//                       "Collection: -",
//                       style: commonMediumStyle,
//                       textAlign: pw.TextAlign.center,
//                     ),
//                     pw.SizedBox(height: 6),
//
//                     // MRP
//                     pw.Text(
//                       "MRP: ₹${products[i]["price"] ?? 0}",
//                       style: commonMediumStyle.copyWith(
//                         color: PdfColor.fromHex("#993F8A"),
//                       ),
//                       textAlign: pw.TextAlign.center,
//                     ),
//                     pw.SizedBox(height: 4),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     // ✅ Build PDF pages dynamically (auto flow)
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         maxPages: 999,
//         margin: const pw.EdgeInsets.all(10),
//         build: (context) => [
//           pw.Container(
//             child: pw.GridView(childAspectRatio: 1.6, crossAxisCount: 3, crossAxisSpacing: defaultPadding, mainAxisSpacing: defaultPadding, children: imageWidgets),
//           ),
//         ],
//       ),
//     );
//
//     await downloadPDF(isDownload: true);
//
//     return pdf.save();
//   }
// }
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/model/catalog/get_catalog_pdf_model.dart';
import '../../../../data/repositories/home/catalogue_repository.dart';
import '../../../../data/repositories/watchlist/watchlist_repository.dart';
import '../../../../exports.dart';

class PdfPreviewController extends GetxController {
  RxBool isListView = false.obs;
  RxBool isLoader = false.obs;
  RxDouble pdfProgress = 0.0.obs;
  Rx<Uint8List>? docPdf = Uint8List(0).obs;

  RxList<CatalogPdfModel> productList = <CatalogPdfModel>[].obs;
  RxString catalogueId = ''.obs;
  RxString pdfTitle = ''.obs;
  RxBool isFromCatalog = true.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      pdfTitle.value = Get.arguments["title"] ?? '';
      catalogueId.value = Get.arguments["catalogueId"] ?? '';
      isFromCatalog.value = Get.arguments["isFromCatalog"] ?? true;
    }
  }

  @override
  void onReady() async {
    super.onReady();

    if (isFromCatalog.isTrue) {
      await CatalogueRepository.downloadCatalogueAPI(
        loader: isLoader,
        catalogueId: catalogueId.value,
        title: pdfTitle.value,
        catalogueType: CatalogueType.grid,
      );
    } else {
      await WatchListRepository.downloadWatchAPI(
        loader: isLoader,
        watchId: catalogueId.value,
        title: pdfTitle.value,
        onSuccess: () async {
          await generatePdfFromProducts();
        },
      );
    }
  }

  // ✅ Background image preloader
  Future<List<pw.MemoryImage?>> preloadImagesInBackground() async {
    final List<String> urls = productList.map((e) => e.inventoryImage?.toString() ?? '').where((url) => url.isNotEmpty).toList();
    return await compute(loadImagesInBackground, urls);
  }

  // 🔹 Runs in background isolate
  static Future<List<pw.MemoryImage?>> loadImagesInBackground(List<String> urls) async {
    final dio = Dio();
    final List<pw.MemoryImage?> loaded = [];

    for (int i = 0; i < urls.length; i++) {
      final url = urls[i];
      try {
        final res = await dio.get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        if (res.statusCode == 200 && res.data != null) {
          final data = Uint8List.fromList(res.data!);
          final decoded = img.decodeImage(data);
          if (decoded != null) {
            final resized = img.copyResize(decoded, width: 900);
            final lower = url.toLowerCase();
            final encoded = Uint8List.fromList(
              lower.endsWith('.png') ? img.encodePng(resized) : img.encodeJpg(resized, quality: 85),
            );
            loaded.add(pw.MemoryImage(encoded));
          } else {
            loaded.add(null);
          }
        } else {
          loaded.add(null);
        }
      } catch (_) {
        loaded.add(null);
      }
    }
    return loaded;
  }

  /// 🔹 Load and compress image from URL
  Future<Uint8List?> loadImageFromUrl(String imageUrl) async {
    if (isValEmpty(imageUrl)) return null;
    try {
      final response = await _dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final original = Uint8List.fromList(response.data ?? []);
      final decoded = img.decodeImage(original);
      if (decoded == null) return null;

      // resize + compress for faster PDF
      final resized = img.copyResize(decoded, width: 800);
      return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
    } catch (e) {
      printErrors(
        type: "loadImageFromUrl",
        errText: 'Failed to load image from $imageUrl. Error: $e',
      );
      return null;
    }
  }

  // ✅ Generate PDF with progress updates
  Future<void> generatePdfFromProducts() async {
    if (isLoader.value) return;
    isLoader.value = true;
    pdfProgress.value = 0;

    try {
      // Preload fonts in main isolate
      final boldFont = await rootBundle.load(AppAssets.montserratBold);
      final mediumFont = await rootBundle.load(AppAssets.montserratMedium);

      // Run the heavy part in isolate
      final pdfBytes = await compute(_generatePdfInBackground, {
        'products': productList.map((e) => e.toJson()).toList(),
        'fontBold': boldFont.buffer.asUint8List(),
        'fontMedium': mediumFont.buffer.asUint8List(),
      });

      docPdf?.value = pdfBytes;

      await downloadPDF(isDownload: true);
    } catch (e, st) {
      printErrors(type: "generatePdfFromProducts", errText: e.toString());
      printYellow(st);
    } finally {
      isLoader.value = false;
    }
  }

  // ✅ Background PDF generator (isolate safe)
  static Future<Uint8List> _generatePdfInBackground(Map<String, dynamic> args) async {
    final List products = args['products'] ?? [];
    final bold = pw.Font.ttf((args['fontBold'] as Uint8List).buffer.asByteData());
    final medium = pw.Font.ttf((args['fontMedium'] as Uint8List).buffer.asByteData());
    final dio = Dio();

    final pdf = pw.Document();
    final List<pw.Widget> items = [];

    for (final p in products) {
      final imageUrl = p['inventory_image'] ?? '';
      pw.MemoryImage? image;

      if (imageUrl.toString().isNotEmpty) {
        try {
          final res = await dio.get<List<int>>(imageUrl, options: Options(responseType: ResponseType.bytes));
          if (res.statusCode == 200 && res.data != null) {
            final bytes = Uint8List.fromList(res.data!);
            final decoded = img.decodeImage(bytes);
            if (decoded != null) {
              final resized = img.copyResize(decoded, width: 900);
              final lower = imageUrl.toString().toLowerCase();
              final encoded = Uint8List.fromList(
                lower.endsWith('.png') ? img.encodePng(resized) : img.encodeJpg(resized, quality: 90),
              );
              image = pw.MemoryImage(encoded);
            }
          }
        } catch (_) {}
      }

      final styleBold = pw.TextStyle(font: bold, fontSize: 12);
      final styleMedium = pw.TextStyle(font: medium, fontSize: 12);

      items.add(
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all(), borderRadius: pw.BorderRadius.circular(10)),
          child: pw.Column(
            children: [
              pw.AspectRatio(
                aspectRatio: 1.3,
                child: image != null
                    ? pw.Image(image, fit: pw.BoxFit.cover)
                    : pw.Center(
                        child: pw.Text("No Image", style: const pw.TextStyle(color: PdfColors.grey, fontSize: 10)),
                      ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Column(
                  children: [
                    pw.Text(p["name"] ?? "-", style: styleBold, textAlign: pw.TextAlign.center),
                    pw.SizedBox(height: 6),
                    pw.Text("Collection: -", style: styleMedium, textAlign: pw.TextAlign.center),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      "MRP: ₹${p["price"] ?? 0}",
                      style: styleMedium.copyWith(color: PdfColor.fromHex("#993F8A")),
                      textAlign: pw.TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
// ✅ Define layout constants
    const spacing = 8.0;
    const columns = 3;
    final usableWidth = PdfPageFormat.a4.availableWidth - (spacing * (columns - 1));
    final cellWidth = usableWidth / columns;
    // ✅ chunk items to prevent TooManyPagesException
    const chunkSize = 60;
    for (int i = 0; i < items.length; i += chunkSize) {
      final pageItems = items.sublist(i, (i + chunkSize > items.length) ? items.length : i + chunkSize);
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          maxPages: 999,
          margin: const pw.EdgeInsets.all(10),
          build: (context) => [
            pw.Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: pageItems.map((item) {
                // ✅ Force each item to have a fixed width
                return pw.Container(
                  width: cellWidth,
                  child: item,
                );
              }).toList(),
            ),
            // pw.Wrap(spacing: 8, runSpacing: 8, children: pageItems),
          ],
        ),
      );
    }

    return pdf.save();
  }

  // // ✅ Save generated file
  // Future<void> downloadPDF({bool isDownload = false}) async {
  //   final dir = isDownload ? (Platform.isAndroid ? Directory("/storage/emulated/0/Download") : await getApplicationDocumentsDirectory()) : await getTemporaryDirectory();
  //   final catalogueDir = Directory("${dir.path}/pingaksh");
  //   if (!await catalogueDir.exists()) await catalogueDir.create();
  //
  //   final filePath = '${catalogueDir.path}/${pdfTitle.value}_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //   final file = File(filePath);
  //   if (docPdf != null || docPdf!.value.isNotEmpty) {
  //     await file.writeAsBytes(docPdf!.value);
  //     printYellow(filePath);
  //     UiUtils.toast("PDF saved successfully!");
  //   }
  // }

  Future<void> downloadPDF({bool isDownload = false}) async {
    try {
      isLoader.value = true;
      UiUtils.toast("📄 Generating PDF file...");

      // ✅ Sanitize file name
      var pdfFileName = pdfTitle.value.replaceAll('/', '-');

      Directory? directory;

      if (Platform.isAndroid) {
        // ✅ Ask for storage permission
        if (await _needsStoragePermission()) {
          var status = await Permission.storage.request();
          if (!status.isGranted) {
            throw Exception('Storage permission denied');
          }
        }
        directory = Directory('/storage/emulated/0/Download');
      } else {
        // ✅ For iOS - use Documents directory
        directory = await getApplicationDocumentsDirectory();
      }

      // ✅ Create subfolder
      final pingakshDir = Directory('${directory.path}/Pingaksh');
      if (!await pingakshDir.exists()) {
        await pingakshDir.create(recursive: true);
      }

      final filePath = '${pingakshDir.path}/$pdfFileName.pdf';
      final file = File(filePath);

      // ✅ Write the actual PDF bytes
      if (docPdf != null && docPdf!.value.isNotEmpty) {
        await file.writeAsBytes(docPdf!.value);

        // ✅ Show toast / snackbar
        UiUtils.toast("PDF saved successfully!");

        // ✅ Open PDF automatically
        await OpenFile.open(file.path);

        // ✅ (Optional) Print path for debugging
        printYellow("📄 Saved PDF path: $filePath");
      } else {
        throw Exception("PDF data is empty!");
      }
    } catch (e) {
      printErrors(type: "downloadPDF", errText: e.toString());
      UiUtils.toast("❌ PDF Generation Error: $e");
    } finally {
      isLoader.value = false;
    }
  }

  Future<bool> _needsStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt < 33;
    }
    return false;
  }
}
