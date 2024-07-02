// To parse this JSON data, do
//
//     final getCartSummaryModel = getCartSummaryModelFromJson(jsonString);

import 'dart:convert';

GetCartSummaryModel getCartSummaryModelFromJson(String str) => GetCartSummaryModel.fromJson(json.decode(str));

String getCartSummaryModelToJson(GetCartSummaryModel data) => json.encode(data.toJson());

class GetCartSummaryModel {
  final String? message;
  final GetCartSummaryDataModel? data;

  GetCartSummaryModel({
    this.message,
    this.data,
  });

  factory GetCartSummaryModel.fromJson(Map<String, dynamic> json) => GetCartSummaryModel(
        message: json["message"],
        data: json["data"] == null ? null : GetCartSummaryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetCartSummaryDataModel {
  final List<WeightSummaryModel>? weightSummary;
  final TotalWeightSummary? totalWeightSummary;
  final List<DiamondSummaryModel>? summary;
  final TotalDeliverySummary? totalDeliverySummary;

  GetCartSummaryDataModel({
    this.weightSummary,
    this.totalWeightSummary,
    this.summary,
    this.totalDeliverySummary,
  });

  factory GetCartSummaryDataModel.fromJson(Map<String, dynamic> json) => GetCartSummaryDataModel(
        weightSummary: json["weight_summary"] == null ? [] : List<WeightSummaryModel>.from(json["weight_summary"]!.map((x) => WeightSummaryModel.fromJson(x))),
        totalWeightSummary: json["total_weight_summary"] == null ? null : TotalWeightSummary.fromJson(json["total_weight_summary"]),
        summary: json["summary"] == null ? [] : List<DiamondSummaryModel>.from(json["summary"]!.map((x) => DiamondSummaryModel.fromJson(x))),
        totalDeliverySummary: json["total_delivery_summary"] == null ? null : TotalDeliverySummary.fromJson(json["total_delivery_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "weight_summary": weightSummary == null ? [] : List<dynamic>.from(weightSummary!.map((x) => x.toJson())),
        "total_weight_summary": totalWeightSummary?.toJson(),
        "summary": summary == null ? [] : List<dynamic>.from(summary!.map((x) => x.toJson())),
        "total_delivery_summary": totalDeliverySummary?.toJson(),
      };
}

class DiamondSummaryModel {
  final String? id;
  final int? totalQuantity;
  final num? totalAmount;

  DiamondSummaryModel({
    this.id,
    this.totalQuantity,
    this.totalAmount,
  });

  factory DiamondSummaryModel.fromJson(Map<String, dynamic> json) => DiamondSummaryModel(
        id: json["_id"],
        totalQuantity: json["total_quantity"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total_quantity": totalQuantity,
        "total_amount": totalAmount,
      };
}

class TotalDeliverySummary {
  final int? totalQty;
  final int? totalAmount;

  TotalDeliverySummary({
    this.totalQty,
    this.totalAmount,
  });

  factory TotalDeliverySummary.fromJson(Map<String, dynamic> json) => TotalDeliverySummary(
        totalQty: json["total_qty"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "total_qty": totalQty,
        "total_amount": totalAmount,
      };
}

class TotalWeightSummary {
  final int? totalMetalWeight;
  final double? totalDiamondWeight;

  TotalWeightSummary({
    this.totalMetalWeight,
    this.totalDiamondWeight,
  });

  factory TotalWeightSummary.fromJson(Map<String, dynamic> json) => TotalWeightSummary(
        totalMetalWeight: json["total_metal_weight"],
        totalDiamondWeight: json["total_diamond_weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "total_metal_weight": totalMetalWeight,
        "total_diamond_weight": totalDiamondWeight,
      };
}

class WeightSummaryModel {
  final String? id;
  final int? metalWeight;
  final double? diamondWeight;

  WeightSummaryModel({
    this.id,
    this.metalWeight,
    this.diamondWeight,
  });

  factory WeightSummaryModel.fromJson(Map<String, dynamic> json) => WeightSummaryModel(
        id: json["_id"],
        metalWeight: json["metal_weight"],
        diamondWeight: json["diamond_weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "metal_weight": metalWeight,
        "diamond_weight": diamondWeight,
      };
}
