import 'dart:convert';

import 'package:get/get.dart';

MrpModel mrpModelFromJson(String str) => MrpModel.fromJson(json.decode(str));

String mrpModelToJson(MrpModel data) => json.encode(data.toJson());

class MrpModel {
  final RxString? label;
  final RxInt? min;
  final RxInt? max;

  MrpModel({
    this.label,
    this.min,
    this.max,
  });

  factory MrpModel.fromJson(Map<String, dynamic> json) => MrpModel(
        label: RxString(json["label"].toString()),
        min: RxInt(json["min"]),
        max: RxInt(json["max"]),
      );

  Map<String, dynamic> toJson() => {
        "label": label?.value,
        "min": min?.value,
        "max": max?.value,
      };
}
