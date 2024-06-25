// To parse this JSON data, do
//
//     final getLatestProductsModel = getLatestProductsModelFromJson(jsonString);

import 'dart:convert';

GetLatestProductsModel getLatestProductsModelFromJson(String str) => GetLatestProductsModel.fromJson(json.decode(str));

String getLatestProductsModelToJson(GetLatestProductsModel data) => json.encode(data.toJson());

class GetLatestProductsModel {
  final String? message;
  final LatestProductsDataModel? data;

  GetLatestProductsModel({
    this.message,
    this.data,
  });

  factory GetLatestProductsModel.fromJson(Map<String, dynamic> json) => GetLatestProductsModel(
    message: json["message"],
    data: json["data"] == null ? null : LatestProductsDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class LatestProductsDataModel {
  final int? filteredCount;
  final int? totalCount;
  final int? totalPages;
  final List<LatestProductsModel>? latestProducts;

  LatestProductsDataModel({
    this.filteredCount,
    this.totalCount,
    this.totalPages,
    this.latestProducts,
  });

  factory LatestProductsDataModel.fromJson(Map<String, dynamic> json) => LatestProductsDataModel(
    filteredCount: json["filteredCount"],
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    latestProducts: json["latestProducts"] == null ? [] : List<LatestProductsModel>.from(json["latestProducts"]!.map((x) => LatestProductsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filteredCount": filteredCount,
    "totalCount": totalCount,
    "totalPages": totalPages,
    "latestProducts": latestProducts == null ? [] : List<dynamic>.from(latestProducts!.map((x) => x.toJson())),
  };
}

class LatestProductsModel {
  final String? id;
  final String? productName;
  final List<String>? inventoryIds;
  final Category? category;
  final String? productImage;

  LatestProductsModel({
    this.id,
    this.productName,
    this.inventoryIds,
    this.category,
    this.productImage,
  });

  factory LatestProductsModel.fromJson(Map<String, dynamic> json) => LatestProductsModel(
    id: json["_id"],
    productName: json["product_name"],
    inventoryIds: json["inventory_ids"] == null ? [] : List<String>.from(json["inventory_ids"]!.map((x) => x)),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
    "inventory_ids": inventoryIds == null ? [] : List<dynamic>.from(inventoryIds!.map((x) => x)),
    "category": category?.toJson(),
    "product_image": productImage,
  };
}

class Category {
  final String? id;
  final String? name;
  final int? v;
  final dynamic categoryImage;
  final DateTime? createdAt;
  final String? createdBy;
  final dynamic deletedAt;
  final String? slug;
  final bool? status;
  final DateTime? updatedAt;
  final String? updatedBy;

  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    v: json["__v"],
    categoryImage: json["category_image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    createdBy: json["created_by"],
    deletedAt: json["deleted_at"],
    slug: json["slug"],
    status: json["status"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "__v": v,
    "category_image": categoryImage,
    "createdAt": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "deleted_at": deletedAt,
    "slug": slug,
    "status": status,
    "updatedAt": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
  };
}
