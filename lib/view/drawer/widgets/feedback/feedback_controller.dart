import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';

class FeedbackController extends GetxController {
  RxBool isLoading = false.obs;
  String vectorImageLink = "https://www.shutterstock.com/image-vector/manager-providing-constructive-feedback-vector-600nw-2344800575.jpg";

  Rx<FeedbackType> feedbackType = FeedbackType.newDesign.obs;

  RxString isOldDesign = ''.obs;
  RxString isNewDesign = ''.obs;
  RxList<String> satisfyNewOrOldDesignList = ["Yes", "No"].obs;

  Rx<TextEditingController> detailCon = TextEditingController().obs;
  RxString selectedArea = ''.obs;
  RxList<String> areaImprovementList = ["Other", "Service", "Accuracy", "Quality", "Sales Visit", "Courier"].obs;

  RxList<String> attachmentList = <String>[].obs;
}
