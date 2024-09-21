import 'package:get/get.dart';

import '../../../../../data/model/home/feedback_history_model.dart';
import '../../../../../data/repositories/home/feedback_repository.dart';

class FeedbackHistoryController extends GetxController {
  RxList<FeedbackHistoryModel> feedbackHistory = <FeedbackHistoryModel>[].obs;

  @override
  void onReady() {
    super.onReady();

    FeedbackRepository.getFeedbackHistory();
  }
}
