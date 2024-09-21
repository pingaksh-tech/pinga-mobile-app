import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/drawer/widgets/feedback/feedback_history/feedback_history_controller.dart';
import '../../model/home/feedback_history_model.dart';

class FeedbackRepository {
  static Map<String, dynamic> historyResponse = {
    "success": true,
    "message": "feedback history fetched successfully",
    "data": [
      {
        "id": "1",
        "feedback_type": "new_design",
        "details": "widget will be centered, or at a fixed distance from the top. This decision was made by interpreting the Material Design Specs",
        "category": null,
        "old_design": "no",
        "new_design": "yes",
      },
      {"id": "2", "feedback_type": "area_improvement", "details": "don't have anything that can be interpreted as if the height of the widget influences", "category": "quality", "old_design": null, "new_design": null},
      {"id": "3", "feedback_type": "app_improvement", "details": "I would propose that this feature request is extended to support", "category": null, "old_design": null, "new_design": null},
      {"id": "4", "feedback_type": "new_design", "details": "at a fixed distance from the top. This decision was made by interpreting the Material Design Specs", "category": null, "old_design": "yes", "new_design": ""},
      {"id": "5", "feedback_type": "area_improvement", "details": "This thread has been automatically locked since there has not been any recent activity after it was closed", "category": "service", "old_design": null, "new_design": null},
      {"id": "6", "feedback_type": "order_processing", "details": "will be centered, or at a fixed distance from the top. This decision was made", "category": null, "old_design": null, "new_design": null},
    ]
  };

  /// ***********************************************************************************
  ///                                      GET FEEDBACK HISTORY
  /// ***********************************************************************************
  static Future<dynamic> getFeedbackHistory({RxBool? isLoading}) async {
    final FeedbackHistoryController historyCon = Get.find<FeedbackHistoryController>();
    GetFeedbackHistoryModel model = GetFeedbackHistoryModel.fromJson(historyResponse /*response*/);
    historyCon.feedbackHistory.value = model.feedbackHistoryModel ?? [];
    // try {
    //   isLoading?.value = true;
    //
    //   await APIFunction.getApiCall(apiUrl: 'getCatalogue' /* API URl*/).then(
    //     (response) async {
    //      final FeedbackHistoryController historyCon = Get.find<FeedbackHistoryController>();
    //      GetFeedbackHistoryModel model = GetFeedbackHistoryModel.fromJson(historyResponse /*response*/);
    //     historyCon.feedbackHistory.value = model.feedbackHistoryModel ?? [];
    //       isLoading?.value = false;
    //     },
    //   );
    // } catch (e) {
    //   printErrors(type: "getFeedbackHistory", errText: "$e");
    //   isLoading?.value = false;
    // } finally {}
  }

  /// ***********************************************************************************
  ///                                     ADD FEEDBACK
  /// ***********************************************************************************
  static Future<dynamic> addFeedback({
    RxBool? isLoading,
    required String feedbackType,
    String? details,
    String? category,
    String? isOldDesign,
    String? isNewDesign,
  }) async {
    try {
      isLoading?.value = true;
      /*  await APIFunction.putApiCall(apiUrl: "url" */ /*api url*/ /*, body: {
        "feedback_type": feedbackType,
        "details": details,
        "category": category,
        "old_design": isOldDesign,
        "new_design": isNewDesign,
      }).then(
        (response) async {
          UiUtils.toast(response["message"]);
        },
      );*/
    } catch (e) {
      printErrors(type: "addFeedback", errText: "$e");
    } finally {
      isLoading?.value = false;
    }
  }
}
