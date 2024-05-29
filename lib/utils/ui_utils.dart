import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../exports.dart';

class UiUtils {
  UiUtils._();
  static double appButtonHight = 48.w;
  static double bottomBarHight = 85;

  /// Set the status bar style to dark
  static void darkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Set the status bar style to light
  static void lightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Set the preferred screen orientation to portrait
  static Future<void> screenOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static late StreamSubscription<bool> keyboardSubscription;
  // Build a Widget tree and query KeyboardVisibilityProvider
  // for the visibility of the keyboard.

  static RxBool keyboardIsOpen = false.obs;

  static bool keyboardStatusListen() {
    KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      printYellow('Keyboard visibility update. Is visible: $visible');
      keyboardIsOpen.value = visible;
    });
    return keyboardIsOpen.value;
  }

  // Validations
  static bool isPassword(String em) {
    return em.length >= 8;
  }

  /// * * * * * * * * * * * * OLD COMPONENTS * * * * * * * * * * * * * * ///

  /// ***********************************************************************************
  ///                                         TOAST
  /// ***********************************************************************************

  static bool _isShowingToast = false;

  static Future toast(message) async {
    printOkStatus("$message");

    Future showToast() {
      FToast fToast = FToast();
      fToast.removeQueuedCustomToasts();
      fToast.removeCustomToast();
      return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }

    if (!_isShowingToast) {
      _isShowingToast = true;
      showToast().then((_) async {
        await Future.delayed(const Duration(seconds: 1));
        _isShowingToast = false;
      });
    }
  }

  static EdgeInsets textfieldScrollPadding(BuildContext context, {bool? showError = false, double? extendBottom}) {
    return const EdgeInsets.all(20).copyWith(bottom: (UiUtils.appButtonHight + (defaultPadding * 3.3) + (showError != true ? defaultPadding * 1.3 : 0)) + (extendBottom ?? 0));
  }

  /// ***********************************************************************************
  ///                                 TEXT FIELD ICON
  /// ***********************************************************************************
  static Widget textFiledIcon(String svgIconPath, {double? width, double? imageHeight, RxBool? isValid}) {
    return SizedBox(
      width: width ?? 40,
      child: UiUtils.fadeSwitcherWidget(
        child: Center(
          key: ValueKey<RxBool?>(isValid),
          child: SvgPicture.asset(
            svgIconPath,
            height: imageHeight ?? 20,
            colorFilter: isValid?.value == false ? ColorFilter.mode(Theme.of(Get.context!).colorScheme.error, BlendMode.srcIn) : null,
          ),
        ),
      ),
    );
  }

  /// ***********************************************************************************
  ///                                 SECURE PASSWORD EYE
  /// ***********************************************************************************
  // static Widget securePasswordEye(String svgIconPath, {double? width, double? imageHeight, bool isPassShow = true}) {
  //   return SizedBox(
  //     width: width ?? 40,
  //     child: UiUtils.fadeSwitcherWidget(
  //       child: Center(
  //         key: ValueKey<bool>(isPassShow),
  //         child: SvgPicture.asset(
  //           isPassShow ? AppAssets.unlockEyeIcon : AppAssets.lockEyeIcon,
  //           height: imageHeight ?? 20,
  //           colorFilter: ColorFilter.mode(AppColors.secondary.withOpacity(.25), BlendMode.srcIn),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// ***********************************************************************************
  ///                                 SYSTEM UI OVERLAY STYLE
  /// ***********************************************************************************

  static SystemUiOverlayStyle systemUiOverlayStyle({
    bool? isReverse,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
    Color? systemNavigationBarColor,
  }) {
    isReverse = (isReverse ?? Get.isDarkMode);
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent, // <-- SEE HERE
      statusBarIconBrightness: statusBarIconBrightness ?? (isReverse == true ? Brightness.light : Brightness.dark), //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: statusBarBrightness ?? (isReverse == true ? Brightness.dark : Brightness.light), //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: systemNavigationBarColor,
    );
  }

  static Widget fadeSwitcherWidget({required Widget child, Alignment alignment = Alignment.centerLeft}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: Align(alignment: alignment, child: child),
        );
      },
      //? Anytime child key passing deferment.
      child: child,
    );
  }

  static AppButton resetButton(BuildContext context, {required VoidCallback onPressed}) {
    return AppButton(
      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.3),
      padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding, left: defaultPadding / 2),
      onPressed: onPressed,
      child: Text(
        "Reset",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
    );
  }

  static Widget appCircularProgressIndicator({Color? color, EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularLoader(
            color: color,
          ),
        ],
      ),
    );
  }
}
