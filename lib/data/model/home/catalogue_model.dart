import 'dart:convert';

GetCatalogueModel getCatalogueModelFromJson(String str) => GetCatalogueModel.fromJson(json.decode(str));

String getCatalogueModelToJson(GetCatalogueModel data) => json.encode(data.toJson());

class GetCatalogueModel {
  final bool? success;
  final String? message;
  final List<CatalogueModel>? data;

  GetCatalogueModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetCatalogueModel.fromJson(Map<String, dynamic> json) => GetCatalogueModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CatalogueModel>.from(json["data"]!.map((x) => CatalogueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CatalogueModel {
  final String? id;
  String? title;
  final String? subtitle;
  final DateTime? createdAt;
  final String? pdf;

  CatalogueModel({
    this.id,
    this.title,
    this.subtitle,
    this.createdAt,
    this.pdf,
  });

  factory CatalogueModel.fromJson(Map<String, dynamic> json) => CatalogueModel(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        pdf: json["pdf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "created_at": createdAt?.toIso8601String(),
        "pdf": pdf,
      };
}
