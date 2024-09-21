import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../utils/country_list.dart';

class AuthController extends GetxController {
  // Common
  RxBool isLoading = false.obs;
  RxBool disableButton = true.obs;

  // Login
  Rx<AuthScreenType> screenType = AuthScreenType.login.obs;

  Rx<TextEditingController> numberCon =
      TextEditingController(text: kDebugMode ? "5555555555" : null).obs;
  RxBool numberValidation = true.obs;
  RxString numberError = ''.obs;

  String get userMobileNumberWithISDCode =>
      "${countryObject.value.dialCode.trim()}${numberCon.value.text.trim()}";

  bool mobileValidation() {
    // Phone number validation
    if (numberCon.value.text.trim().isEmpty) {
      numberError.value = "Please enter phone number";
      numberValidation.value = false;
    } else if (numberCon.value.text.trim().length < 10) {
      numberError.value = "Phone number must be 10 digits long";
      numberValidation.value = false;
    } else {
      numberValidation.value = true;
    }

    return numberValidation.isTrue;
  }

  // Forgot Password
  Rx<TextEditingController> otpController = TextEditingController().obs;

  RxBool otpValidation = true.obs;
  RxBool isResendOtp = false.obs;
  RxString otpError = "".obs;

  int maxOTPLength = 4;

  Timer? timer;
  RxInt timeLimit = 0.obs;
  RxBool isTimerComplete = true.obs;

  Future<void> timerStart() async {
    isResendOtp.value = false;
    isTimerComplete.value = false;
    timeLimit = 30.obs;
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (timeLimit.value > 1) {
          timeLimit.value--;
        } else if (timeLimit.value >= 1) {
          isTimerComplete.value = true;
          timeLimit.value = 0;
          timer.cancel();
        }
      },
    );
  }

  void checkOTPButtonDisableStatus() {
    if (otpController.value.text.trim().length != maxOTPLength) {
      disableButton.value = true;
    } else {
      disableButton.value = false;
    }
  }

  /// COUNTRY CODE
  Rx<Country> countryObject = const Country(
    name: "India",
    flag: "🇮🇳",
    code: "IN",
    dialCode: "+91",
    minLength: 10,
    maxLength: 10,
  ).obs;
}
