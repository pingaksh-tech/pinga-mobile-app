// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  final String? message;
  final GetCategoryDataModel? data;

  GetCategoryModel({
    this.message,
    this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
        message: json["message"],
        data: json["data"] == null ? null : GetCategoryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetCategoryDataModel {
  final int? filteredCount;
  final int? totalCount;
  final int? totalPages;
  final List<CategoryModel>? categories;
  final int? page;

  GetCategoryDataModel({
    this.filteredCount,
    this.totalCount,
    this.categories,
    this.totalPages,
    this.page,
  });

  factory GetCategoryDataModel.fromJson(Map<String, dynamic> json) => GetCategoryDataModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        page: json["page"],
        categories: json["categories"] == null ? [] : List<CategoryModel>.from(json["categories"]!.map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "page": page,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class CategoryModel {
  final String? id;
  final String? name;
  final int? v;
  final String? categoryImage;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? deletedAt;
  final String? slug;
  final bool? status;
  final DateTime? updatedAt;
  final DateTime? updatedBy;

  CategoryModel({
    this.id,
    this.name,
    this.v,
    this.categoryImage,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.slug,
    this.status,
    this.updatedAt,
    this.updatedBy,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        categoryImage: json["category_image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
        slug: json["slug"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        updatedBy: json["updated_by"] == null ? null : DateTime.parse(json["updated_by"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "category_image": categoryImage,
        "createdAt": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "deleted_at": deletedAt?.toIso8601String(),
        "slug": slug,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "updated_by": updatedBy?.toIso8601String(),
      };
}
