import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';

class FeedbackController extends GetxController {
  String vectorImageLink = "https://www.shutterstock.com/image-vector/manager-providing-constructive-feedback-vector-600nw-2344800575.jpg";

  Rx<FeedbackType> feedbackType = FeedbackType.newDesign.obs;

  RxString isSatisfiedDesign = ''.obs;
  RxString isNewDesign = ''.obs;
  RxList<String> satisfyNewOrOldDesignList = ["Yes", "No"].obs;

  Rx<TextEditingController> existingDesignCon = TextEditingController().obs;
  Rx<TextEditingController> appImprovementCon = TextEditingController().obs;
  Rx<TextEditingController> orderProcessingCon = TextEditingController().obs;
  Rx<TextEditingController> areaImprovementCon = TextEditingController().obs;

  RxString selectedArea = ''.obs;
  RxList<String> areaImprovementList = ["Other", "Service", "Accuracy", "Quality", "Sales Visit", "Courier"].obs;

  RxList<String> attachmentList = <String>[].obs;
}
