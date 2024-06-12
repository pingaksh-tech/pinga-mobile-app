import 'dart:convert';

GetFeedbackHistoryModel getFeedbackHistoryModelFromJson(String str) => GetFeedbackHistoryModel.fromJson(json.decode(str));

String getFeedbackHistoryModelToJson(GetFeedbackHistoryModel data) => json.encode(data.toJson());

class GetFeedbackHistoryModel {
  final bool? success;
  final String? message;
  final List<FeedbackHistoryModel>? feedbackHistoryModel;

  GetFeedbackHistoryModel({
    this.success,
    this.message,
    this.feedbackHistoryModel,
  });

  factory GetFeedbackHistoryModel.fromJson(Map<String, dynamic> json) => GetFeedbackHistoryModel(
        success: json["success"],
        message: json["message"],
        feedbackHistoryModel: json["data"] == null ? [] : List<FeedbackHistoryModel>.from(json["data"]!.map((x) => FeedbackHistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": feedbackHistoryModel == null ? [] : List<dynamic>.from(feedbackHistoryModel!.map((x) => x.toJson())),
      };
}

class FeedbackHistoryModel {
  final String? id;
  final String? feedbackType;
  final String? details;
  final String? category;
  final String? oldDesign;
  final String? newDesign;

  FeedbackHistoryModel({
    this.id,
    this.feedbackType,
    this.details,
    this.category,
    this.oldDesign,
    this.newDesign,
  });

  factory FeedbackHistoryModel.fromJson(Map<String, dynamic> json) => FeedbackHistoryModel(
        id: json["id"],
        feedbackType: json["feedback_type"],
        details: json["details"],
        category: json["category"],
        oldDesign: json["old_design"],
        newDesign: json["new_design"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feedback_type": feedbackType,
        "details": details,
        "category": category,
        "old_design": oldDesign,
        "new_design": newDesign,
      };
}
