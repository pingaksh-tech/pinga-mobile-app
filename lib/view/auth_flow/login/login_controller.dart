import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class LoginController extends GetxController {
  // Common
  RxBool isLoading = false.obs;
  RxBool disableButton = true.obs;

  // Login
  Rx<AuthScreenType> screenType = AuthScreenType.login.obs;

  Rx<TextEditingController> numberCon = TextEditingController(text: kDebugMode ? "9876543210" : null).obs;
  RxBool numberValidation = true.obs;
  RxString numberError = ''.obs;

  bool mobileValidation() {
    // Phone number validation
    if (numberCon.value.text.trim().isEmpty) {
      numberError.value = "Please enter number";
      numberValidation.value = false;
      //? number.length > 16 || number.length < 9
    } else if (!GetUtils.isPhoneNumber(numberCon.value.text.trim())) {
      numberError.value = "Please enter valid number";
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
}
