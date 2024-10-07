import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/repositories/cart/cart_repository.dart';
import '../data/repositories/product/product_repository.dart';
import '../exports.dart';
import '../view/cart/cart_controller.dart';
import '../view/product_details/product_details_controller.dart';

/// Set the preferred screen orientation to portrait
void screenPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

/// * * * * * * * * * * * * OLD COMPONENTS * * * * * * * * * * * * * * ///

extension StrExtension on String {
  static String getFirstName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the first name
      String firstName = nameParts[0];
      return firstName;
    } else {
      // Handle case where full name doesn't have spaces
      return fullName;
    }
  }

  static String getLastName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the last name
      return nameParts.last;
    } else {
      return ""; // Return empty string if last name doesn't exist
    }
  }

  static String getFullName(String firstName, String lastName) {
    return "$firstName $lastName";
  }

  static String formatTime(int totalMinutes, {bool sortForm = false}) {
    int hours = totalMinutes ~/ 60; // Getting total hours
    int minutes = totalMinutes % 60; // Getting remaining minutes

    // Formatting the time into a string representation
    if (sortForm) {
      return '${hours >= 1 ? '${hours}h' : ''} $minutes min${minutes != 1 ? 's' : ''}';
    } else {
      return '$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}';
    }
  }

  static String camelCaseToSnakeCase(String input) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (char.toUpperCase() == char) {
        if (i > 0) {
          result.write('_');
        }
        result.write(char.toLowerCase());
      } else {
        result.write(char);
      }
    }
    return result.toString();
  }

  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1);
  }

  String truncateText({int? limit}) {
    if (limit == null) {
      return this;
    }

    if (length <= limit) return this;

    final endIndex = substring(0, limit).lastIndexOf(' ');
    final truncatedText = substring(0, endIndex > 0 ? endIndex : limit);
    return "$truncatedText...";
  }
}

const int defaultAmountLength = 12;
const int defaultQuantityLength = 12;
const Duration defaultDuration = Duration(milliseconds: 200);
const Duration defaultSearchDebounceDuration = Duration(milliseconds: 400);

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null ||
      value.isEmpty ||
      value == "null" ||
      value == "" ||
      value == "NULL" ||
      value == '');
}

bool isValZero(num? number) {
  return number != null && number.isEqual(0);
}

bool isAmountValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) > 100.0) {
    return false;
  } else {
    return true;
  }
}

bool isPeriodValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) < 15.0) {
    return false;
  } else {
    return true;
  }
}

bool isProcessingFeesValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) > 50.0) {
    return false;
  } else {
    return true;
  }
}

String formatAmount(amount) {
  num myAmount = num.parse((amount ?? "0").toString());
  final formatter = NumberFormat('#,##,###.####');
  return formatter.format(myAmount);
}

bool isRegistered<S>() {
  if (Get.isRegistered<S>()) {
    return true;
  } else {
    printErrors(
        type: "Function 'isRegistered' in utils:",
        errText: "$S Controller not initialize");
    /* if (forcePut == true) {
      printData(key: "Force Putting", value: "Controller $S");
    } */
    return false;
  }
}

void deleteGetXController<S>() {
  if (Get.isRegistered<S>()) {
    Get.delete<S>();
  }
}

/// ***********************************************************************************
///                                DUPLICATE ROUTE ISSUE RESOLVER
/// ***********************************************************************************

addProductDetailsToGlobalList(Map productDetails,
    {required GlobalProductPrefixType type}) {
  if (isRegistered<BaseController>() &&
      productDetails["productId"].length > 10) {
    BaseController con = Get.find<BaseController>();

    con.globalProductDetails.add(productDetails);

    return productDetails;
  } else {
    return "";
  }
}

removeProductDetailsToGlobalList() {
  if (isRegistered<BaseController>()) {
    BaseController con = Get.find<BaseController>();
    con.globalProductDetails.removeLast();
    return con.lastProductDetails;
  } else {
    return "";
  }
}

void navigateToProductDetailsScreen(
    {Map? arguments,
    required Map productDetails,
    required GlobalProductPrefixType type,
    Function()? whenComplete}) {
  void apiCall({
    required Map productDetails,
  }) {
    /// API CALL
    try {
      var productDetailsId =
          addProductDetailsToGlobalList(productDetails, type: type);
      printBlue(productDetailsId);
      if (isRegistered<ProductDetailsController>()) {
        ProductDetailsController con = Get.find<ProductDetailsController>();

        if (type == GlobalProductPrefixType.productDetails) {
          ProductRepository.getSingleProductAPI(
            inventoryId: productDetailsId["productId"],
            loader: con.loader,
            sizeId: productDetailsId["sizeId"] ?? '',
            metalId: productDetailsId["metalId"] ?? "",
            diamondClarity: productDetailsId["diamondClarity"] ?? "",
            diamondList: productDetailsId["diamonds"] ?? [],
          ).then(
            (value) {
              con.predefinedValue();
              // priceChangeAPI();
            },
          );
        } else {
          CartRepository.getSingleCartItemAPI(
                  cartId: productDetailsId["productId"], loader: con.loader)
              .then(
            (value) {
              con.predefinedValue();
              // priceChangeAPI();
            },
          );
        }
      }
    } catch (e) {
      printErrors(
          type: "navigateToProductDetailsScreen",
          errText: "PROD: ${productDetails["productId"]} $e");
    }
  }

  apiCall(
    productDetails: productDetails,
  );
  Get.toNamed(AppRoutes.productDetailsScreen,
          arguments: arguments, preventDuplicates: false)
      ?.whenComplete(() {
    if (whenComplete != null) {
      whenComplete();
    }
    if (Get.currentRoute == AppRoutes.productDetailsScreen) {
      apiCall(productDetails: removeProductDetailsToGlobalList());
    }
  });
}

void navigateToCartScreen({Map? arguments, Function()? whenComplete}) {
  Get.delete<CartController>();
  Get.toNamed(
    AppRoutes.cartScreen,
    arguments: arguments,
  )?.whenComplete(() {
    if (whenComplete != null) {
      whenComplete();
    }
    {
      /// API CALL
      // String pId = addProductIdToGlobalList(productId, type: type);

      if (isRegistered<ProductDetailsController>() &&
          isRegistered<BaseController>()) {
        ProductDetailsController con = Get.find<ProductDetailsController>();
        BaseController baseCon = Get.find<BaseController>();

        if (baseCon.lastProductDetails["type"] ==
            GlobalProductPrefixType.productDetails) {
          ProductRepository.getSingleProductAPI(
            inventoryId: baseCon.lastProductDetails["productId"],
            loader: con.loader,
            sizeId: baseCon.lastProductDetails["sizeId"],
            metalId: baseCon.lastProductDetails["metalId"] ?? "",
            diamondClarity: baseCon.lastProductDetails["diamondClarity"] ?? "",
            diamondList: baseCon.lastProductDetails["diamonds"] ?? [],
          ).then(
            (value) {
              con.predefinedValue();
              // priceChangeAPI();
            },
          );
        } else {
          CartRepository.getSingleCartItemAPI(
                  cartId: baseCon.lastProductDetails["productId"],
                  loader: con.loader)
              .then(
            (value) {
              con.predefinedValue();
              // priceChangeAPI();
            },
          );
        }
      }
    }
  });
}

/// ***********************************************************************************
///                                       DEBOUNCE TIMER
/// ***********************************************************************************

Timer? _debounceTimer;

void commonDebounce({
  required Future<void> Function() callback,
  Duration duration = const Duration(milliseconds: 400),
}) {
  if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
  _debounceTimer = Timer(
    duration,
    () async {
      ///  CALL
      await callback();
    },
  );
}

/// ***********************************************************************************
///                                 Check Internet Ability
/// ***********************************************************************************

List<ConnectivityResult> connectivityResults = [ConnectivityResult.none];
final Connectivity connectivity = Connectivity();

Future<bool> getConnectivityResult(
    {bool showToast = true, RxBool? isLoader}) async {
  try {
    connectivityResults = await connectivity.checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.ethernet) ||
        connectivityResults.contains(ConnectivityResult.vpn)) {
      return true;
    } else {
      if (showToast == true) {
        UiUtils.toast(AppStrings.noInternetAvailable);
      }
      return false;
    }
  } on PlatformException catch (e) {
    printErrors(type: "getConnectivityResult Function", errText: e);
    UiUtils.toast(AppStrings.noInternetAvailable);
    isLoader?.value = false;
    return false;
  }
}

BoxBorder defaultBorder = Border.all(color: const Color(0xffE8E8E8));

DateTime defaultDateTime = DateTime.parse("1999-01-01 12:00:00.974368");

Future<void> storeDeviceInformation(fcmToken) async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo =
          (await deviceInfoPlugin.androidInfo);
      await LocalStorage.storeDeviceInfo(
        deviceID: androidDeviceInfo.id,
        deviceTOKEN: fcmToken,
        deviceTYPE: AppStrings.androidSlug,
        deviceNAME: androidDeviceInfo.model,
      );
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = (await deviceInfoPlugin.iosInfo);
      await LocalStorage.storeDeviceInfo(
        deviceID: iosDeviceInfo.identifierForVendor ?? "",
        deviceTOKEN: fcmToken,
        deviceTYPE: AppStrings.iOSSlug,
        deviceNAME: iosDeviceInfo.utsname.machine,
      );
    }
  } catch (k) {
    debugPrint(k.toString());
  }
}

Future<PackageInfo> getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  printData(key: "AppName", value: packageInfo.appName);
  printData(key: "Version", value: packageInfo.version);
  printData(key: "PackageName", value: packageInfo.packageName);

  return packageInfo;
}

Future<void> launchUrlFunction(url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

DateTime findFutureDate({DateTime? futureDate, required double totalMonths}) {
  futureDate ??= DateTime.now();

  for (int i = 1; i <= totalMonths; i++) {
    int year = futureDate!.year;
    int month = futureDate.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }

    futureDate = DateTime(
        year,
        month,
        futureDate.day,
        futureDate.hour,
        futureDate.minute,
        futureDate.second,
        futureDate.millisecond,
        futureDate.microsecond);
  }

  return futureDate!;
}

Future<File> createTempFile(Uint8List uint8List) async {
  // Create a temporary directory
  Directory tempDir = await Directory.systemTemp.createTemp();

  // Create a temporary file
  File tempFile = File('${tempDir.path}/temp_image.png');

  // Write the image bytes to the file
  await tempFile.writeAsBytes(uint8List);

  return tempFile;
}

UnsupportedError get platformUnsupportedError => UnsupportedError(
    "Sorry, this app is Android and iOS so it does not support another platform.");

Future<void> deleteCacheDir() async {
  // final Directory cacheDir = await getTemporaryDirectory();
  //
  // if (cacheDir.existsSync()) {
  //   cacheDir.deleteSync(recursive: true);
  // }
}

class Restart {
  /// A private constant `MethodChannel`. This channel is used to communicate with the
  /// platform-specific code to perform the restart operation.
  static const MethodChannel _channel = MethodChannel('restart');

  /// Restarts the Flutter application.

  /// The `webOrigin` parameter is optional. If it's null, the method uses the `window.origin`
  /// to get the site origin. This parameter should only be filled when your current origin
  /// is different than the app's origin. It defaults to null.

  /// This method communicates with the platform-specific code to perform the restart operation,
  /// and then checks the response. If the response is "ok", it returns true, signifying that
  /// the restart operation was successful. Otherwise, it returns false.
  static Future<bool> restartApp({String? webOrigin}) async =>
      (await _channel.invokeMethod('restartApp', webOrigin)) == "ok";
}

Future<void> pickImages(
  BuildContext context, {
  bool isSingleImage = true,
  bool withCropper = true,
  ImageSource? source,
  // CropStyle? cropStyle,
  CropAspectRatio? aspectRatio,
  void Function(XFile?)? xFileChange,
  void Function(List<XFile>?)? imageListOnChange,
  void Function(CroppedFile?)? croppedFileChange,
  bool isCircleCrop = false,
}) async {
  void callingAllNull() {
    xFileChange != null ? xFileChange(null) : null;
    croppedFileChange != null ? croppedFileChange(null) : null;
    imageListOnChange != null ? imageListOnChange(null) : null;
  }

  final ImagePicker imagePicker = ImagePicker();

  if (isSingleImage) {
    final XFile? image =
        await imagePicker.pickImage(source: source ?? ImageSource.gallery);

    if (image != null && withCropper) {
      XFile? compressedFile = await _compressImage(image.path);

      CroppedFile? cropper = await singleImageCropper(
        context,
        fileImage: compressedFile!,
        aspectRatio: aspectRatio,
        isCircleCrop: isCircleCrop,
      );

      if (withCropper) {
        croppedFileChange != null ? croppedFileChange(cropper) : null;
      } else {
        xFileChange != null ? xFileChange(compressedFile) : null;
      }
    } else {
      //? Null calling...
      callingAllNull();
    }
  } else {
    List<XFile>? pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      imageListOnChange != null ? imageListOnChange(pickedImages) : null;

      //? Null calling...
      xFileChange != null ? xFileChange(null) : null;
      croppedFileChange != null ? croppedFileChange(null) : null;
    } else {
      //? Null calling...
      callingAllNull();
    }
  }
}

Future<XFile?> _compressImage(String path) async {
  XFile? result = await FlutterImageCompress.compressAndGetFile(
    path,
    '${path}_compressed.jpg',
    quality: 50,
  );
  return result;
}

Future<CroppedFile?> singleImageCropper(
  BuildContext context, {
  required XFile fileImage,
  String? cropperTitle,
  CropStyle? cropStyle,
  CropAspectRatio? aspectRatio,
  bool isCircleCrop = false,
}) async {
  String toolbarTitle = cropperTitle ?? "Cropper";

  CroppedFile? cropper = await ImageCropper().cropImage(
    sourcePath: fileImage.path,
    aspectRatio: aspectRatio,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: toolbarTitle,
        initAspectRatio: CropAspectRatioPreset.original,
        cropGridColor: Colors.grey,
        cropStyle: isCircleCrop ? CropStyle.circle : CropStyle.rectangle,
        hideBottomControls: false,
        cropFrameColor: Colors.grey,
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor:
            AppColors.getColorOnBackground(Theme.of(context).primaryColor),
        statusBarColor: Theme.of(context).primaryColor,
        activeControlsWidgetColor: Theme.of(context).primaryColor,
      ),
      IOSUiSettings(
        title: toolbarTitle,
        resetButtonHidden: true,
        rotateClockwiseButtonHidden: true,
        rotateButtonsHidden: true,
        aspectRatioPickerButtonHidden: true,
        minimumAspectRatio: 1,
      ),
    ],
  );
  return cropper;
}

Future<void> shareAppLink({required String link}) async {
  final result = await Share.share(link, subject: AppStrings.appName.value);
  if (result.status == ShareResultStatus.success) {
    // printOkStatus('Thank you for sharing my website!');
  }
}

String convertToTitleCase(String input) {
  if (input.isEmpty) return '';

  StringBuffer result = StringBuffer();

  for (int i = 0; i < input.length; i++) {
    if (i == 0) {
      // Capitalize the first character
      result.write(input[i].toUpperCase());
    } else {
      // If character is uppercase, add a space before it
      if (input[i].toUpperCase() == input[i] &&
          input[i].toLowerCase() != input[i]) {
        result.write(' ');
      }
      result.write(input[i]);
    }
  }

  return result.toString();
}

/// ***********************************************************************************
///                            CustomRange TextInput Formatter
/// ***********************************************************************************

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  CustomRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}

/// get widget position
Offset? getWidgetPosition(BuildContext context, {GlobalKey? widgetKey}) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  final RenderBox? widgetRenderBox =
      widgetKey?.currentContext?.findRenderObject() as RenderBox?;

  if (widgetRenderBox != null) {
    return Offset(position.dx, position.dy + widgetRenderBox.size.height);
  } else {
    return null;
  }
}

Rx<OverlayEntry?> overlayEntry = Rx<OverlayEntry?>(null);

void showOverlay(BuildContext context, {required Widget child}) {
  if (overlayEntry.value == null) {
    overlayEntry.value = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) => child,
    );
    Overlay.of(context).insert(overlayEntry.value!);
  }
}

void removeOverlay() {
  if (overlayEntry.value != null) {
    overlayEntry.value?.remove();
    overlayEntry.value = null;
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> sendEmail(String email) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launchUrl(launchUri);
}

Map<String, String> convertStringMap(Map<String, dynamic> data) {
  final Map<String, String> stringMap = {};
  for (var key in data.keys) {
    if (data[key] is String) {
      stringMap[key] = data[key] as String;
    } else {
      // Handle non-string values (e.g., ignore, log a warning)
      printYellow(
          'Warning: Key "$key" in data has a non-string value. Ignoring.');
    }
  }
  return stringMap;
}
