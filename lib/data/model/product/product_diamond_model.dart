
import 'dart:convert';

GetDiamondModel getDiamondModelFromJson(String str) => GetDiamondModel.fromJson(json.decode(str));

String getDiamondModelToJson(GetDiamondModel data) => json.encode(data.toJson());

class GetDiamondModel {
  final bool? success;
  final String? message;
  final DiamondModel? data;

  GetDiamondModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetDiamondModel.fromJson(Map<String, dynamic> json) => GetDiamondModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DiamondModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DiamondModel {
  final List<Diamond>? diamonds;

  DiamondModel({
    this.diamonds,
  });

  factory DiamondModel.fromJson(Map<String, dynamic> json) => DiamondModel(
    diamonds: json["diamonds"] == null ? [] : List<Diamond>.from(json["diamonds"]!.map((x) => Diamond.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
  };
}

class Diamond {
  final String? id;
  final String? diamond;

  Diamond({
    this.id,
    this.diamond,
  });

  factory Diamond.fromJson(Map<String, dynamic> json) => Diamond(
    id: json["id"],
    diamond: json["diamond"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "diamond": diamond,
  };
}
