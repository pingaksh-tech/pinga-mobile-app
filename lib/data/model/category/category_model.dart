// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  final bool? success;
  final String? message;
  final CategoryModel? data;

  GetCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : CategoryModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class CategoryModel {
  final List<CategoryList>? category;

  CategoryModel({
    this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category: json["category"] == null ? [] : List<CategoryList>.from(json["category"]!.map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class CategoryList {
  final String? catName;
  final String? productAvailable;
  final String? image;

  CategoryList({
    this.catName,
    this.productAvailable,
    this.image,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        catName: json["catName"],
        productAvailable: json["productAvailable"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "catName": catName,
        "productAvailable": productAvailable,
        "image": image,
      };
}
