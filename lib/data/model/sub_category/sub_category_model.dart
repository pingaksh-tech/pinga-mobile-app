// To parse this JSON data, do
//
//     final getSubCategoryModel = getSubCategoryModelFromJson(jsonString);

import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromJson(String str) => GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel data) => json.encode(data.toJson());

class GetSubCategoryModel {
  final String? message;
  final SubCategoryDataModel? data;

  GetSubCategoryModel({
    this.message,
    this.data,
  });

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) => GetSubCategoryModel(
        message: json["message"],
        data: json["data"] == null ? null : SubCategoryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class SubCategoryDataModel {
  final int? filteredCount;
  final int? totalCount;
  final int? totalPages;
  final int? page;
  final List<SubCategoryModel>? subCategories;

  SubCategoryDataModel({
    this.filteredCount,
    this.totalCount,
    this.totalPages,
    this.page,
    this.subCategories,
  });

  factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) => SubCategoryDataModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        page: json["page"],
        subCategories: json["sub_categories"] == null ? [] : List<SubCategoryModel>.from(json["sub_categories"]!.map((x) => SubCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "page": page,
        "sub_categories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategoryModel {
  final String? id;
  final String? name;
  final List<Category>? categories;
  final int? totalCount;
  final String? subCategoryImage;

  SubCategoryModel({
    this.id,
    this.name,
    this.categories,
    this.totalCount,
    this.subCategoryImage,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        id: json["_id"],
        name: json["name"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        totalCount: json["total_count"],
        subCategoryImage: json["sub_category_image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "total_count": totalCount,
        "sub_category_image": subCategoryImage,
      };
}

class Category {
  final String? id;
  final String? name;
  final String? slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
      };
}
