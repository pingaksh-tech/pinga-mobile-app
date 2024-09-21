import 'dart:convert';

import 'package:get/get.dart';

GetPredefinedModel getPredefinedModelFromJson(String str) => GetPredefinedModel.fromJson(json.decode(str));

String getPredefinedModelToJson(GetPredefinedModel data) => json.encode(data.toJson());

class GetPredefinedModel {
  final bool? success;
  final String? message;
  final PredefinedModel? data;

  GetPredefinedModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetPredefinedModel.fromJson(Map<String, dynamic> json) => GetPredefinedModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : PredefinedModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class PredefinedModel {
  final CategoryModel? ring;
  final CategoryModel? earRing;
  final CategoryModel? bangles;
  final CategoryModel? nosePin;
  final CategoryModel? bracelet;

  PredefinedModel({
    this.ring,
    this.earRing,
    this.bangles,
    this.nosePin,
    this.bracelet,
  });

  factory PredefinedModel.fromJson(Map<String, dynamic> json) => PredefinedModel(
        ring: json["ring"] == null ? null : CategoryModel.fromJson(json["ring"]),
        earRing: json["ear_ring"] == null ? null : CategoryModel.fromJson(json["ear_ring"]),
        bangles: json["bangles"] == null ? null : CategoryModel.fromJson(json["bangles"]),
        nosePin: json["nose_pin"] == null ? null : CategoryModel.fromJson(json["nose_pin"]),
        bracelet: json["bracelet"] == null ? null : CategoryModel.fromJson(json["bracelet"]),
      );

  Map<String, dynamic> toJson() => {
        "ring": ring?.toJson(),
        "ear_ring": earRing?.toJson(),
        "bangles": bangles?.toJson(),
        "nose_pin": nosePin?.toJson(),
        "bracelet": bracelet?.toJson(),
      };
}

class CategoryModel {
  final List<SizeModel>? size;

  CategoryModel({
    this.size,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        size: json["size"] == null ? [] : List<SizeModel>.from(json["size"]!.map((x) => SizeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x.toJson())),
      };
}

class SizeModel {
  final String? id;
  final RxString? value;
  final String? label;

  SizeModel({
    this.id,
    this.value,
    this.label,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        id: json["id"],
        value: RxString(json["value"].toString()),
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "label": label,
      };
}
