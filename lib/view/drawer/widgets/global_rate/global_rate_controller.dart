import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalRateController extends GetxController {
  Rx<TextEditingController> rateCon = TextEditingController().obs;
  RxBool rateValidation = true.obs;
  RxString rateError = ''.obs;

  RxBool disableButton = true.obs;
  RxBool isLoading = false.obs;

  checkValidation(String value) {
    if (num.parse(value) > 100) {
      rateError.value = 'Enter valid discount';
      rateValidation.value = false;
    } else {
      rateError.value = '';
      rateValidation.value = true;
    }

    return rateValidation.value;
  }

  checkDisableButton() {
    disableButton.value = !rateCon.value.text.isNotEmpty;
  }
}
