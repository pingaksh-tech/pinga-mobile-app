import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool disableButton = true.obs;

  Rx<TextEditingController> numberCon = TextEditingController(text: kDebugMode ? "9876543210" : null).obs;
  RxBool numberValidation = true.obs;
  RxString numberError = ''.obs;
}
