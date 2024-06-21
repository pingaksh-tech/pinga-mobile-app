// To parse this JSON data, do
//
//     final getSubCategoryModel = getSubCategoryModelFromJson(jsonString);

import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromJson(String str) => GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel data) => json.encode(data.toJson());

class GetSubCategoryModel {
  final bool? success;
  final String? message;
  final SubCategoryDataModel? data;

  GetSubCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) => GetSubCategoryModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : SubCategoryDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class SubCategoryDataModel {
  final List<SubCategoryModel>? category;

  SubCategoryDataModel({
    this.category,
  });

  factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) => SubCategoryDataModel(
    category: json["category"] == null ? [] : List<SubCategoryModel>.from(json["category"]!.map((x) => SubCategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class SubCategoryModel {
  final String? catName;
  final String? slug;
  final String? productAvailable;
  final String? image;

  SubCategoryModel({
    this.catName,
    this.slug,
    this.productAvailable,
    this.image,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
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
