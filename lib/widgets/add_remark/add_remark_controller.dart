import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddRemarkController extends GetxController {
  Rx<TextEditingController> remarkCon = TextEditingController().obs;
  RxBool remarkValidation = true.obs;
  RxString remarkError = ''.obs;

  RxBool disableButton = true.obs;

  RxBool isSelected = false.obs;
  RxList<String> selectedRemark = <String>[].obs;

  RxList<String> remarkList = [
    "Big Loop",
    "Mangalsutra",
    "Add Gold",
    "Line sale",
    "New Month Bill Entry",
    "Only IGI and Bill",
    "EF Diamond",
    "Safety Lock",
    "Without Black Bits",
    "Without Chain",
    "Without Titanium",
    "Diamond Quality",
    "Dandi yellow gold & uppar white gold",
    "Dandi yello gold & uppa three colors(Y,P,W)",
    "Against Credit Note",
  ].obs;

  void checkDisableButton() {
    if (selectedRemark.isNotEmpty || remarkCon.value.text.isNotEmpty) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }
}
