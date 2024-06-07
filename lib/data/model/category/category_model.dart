// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  final bool? success;
  final String? message;
  final CategoryDataModel? data;

  GetCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : CategoryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class CategoryDataModel {
  final List<CategoryModel>? category;

  CategoryDataModel({
    this.category,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
        category: json["category"] == null ? [] : List<CategoryModel>.from(json["category"]!.map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class CategoryModel {
  final String? catName;
  final String? slug;
  final String? productAvailable;
  final String? image;

  CategoryModel({
    this.catName,
    this.slug,
    this.productAvailable,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catName: json["catName"],
        slug: json["slug"],
        productAvailable: json["productAvailable"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "catName": catName,
        "slug": slug,
        "productAvailable": productAvailable,
        "image": image,
      };
}
