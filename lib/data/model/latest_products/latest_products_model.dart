/*
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
  final int? page;
  final List<LatestProductsModel>? latestProducts;

  LatestProductsDataModel({
    this.filteredCount,
    this.totalCount,
    this.totalPages,
    this.page,
    this.latestProducts,
  });

  factory LatestProductsDataModel.fromJson(Map<String, dynamic> json) => LatestProductsDataModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        page: json["page"],
        latestProducts: json["latestProducts"] == null ? [] : List<LatestProductsModel>.from(json["latestProducts"]!.map((x) => LatestProductsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "page": page,
        "latestProducts": latestProducts == null ? [] : List<dynamic>.from(latestProducts!.map((x) => x.toJson())),
      };
}

class LatestProductsModel {
  final String? id;
  final String? productName;
  final List<String>? inventoryIds;
  final Category? category;
  final String? productImage;
  final String? inventoryId;

  LatestProductsModel({
    this.id,
    this.productName,
    this.inventoryIds,
    this.category,
    this.productImage,
    this.inventoryId,
  });

  factory LatestProductsModel.fromJson(Map<String, dynamic> json) => LatestProductsModel(
        id: json["_id"],
        productName: json["product_name"],
        inventoryIds: json["inventory_ids"] == null ? [] : List<String>.from(json["inventory_ids"]!.map((x) => x)),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        productImage: json["product_image"],
        inventoryId: json["inventory_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_name": productName,
        "inventory_ids": inventoryIds == null ? [] : List<dynamic>.from(inventoryIds!.map((x) => x)),
        "category": category?.toJson(),
        "product_image": productImage,
        "inventory_id": inventoryId,
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
*/
import 'dart:convert';

import '../sub_category/sub_category_model.dart';

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
  final int? page;
  final List<LatestProductsModel>? latestProducts;

  LatestProductsDataModel({
    this.filteredCount,
    this.totalCount,
    this.totalPages,
    this.page,
    this.latestProducts,
  });

  factory LatestProductsDataModel.fromJson(Map<String, dynamic> json) => LatestProductsDataModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        page: json["page"],
        latestProducts: json["latestProducts"] == null ? [] : List<LatestProductsModel>.from(json["latestProducts"].map((x) => LatestProductsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "page": page,
        "latestProducts": latestProducts == null ? [] : List<dynamic>.from(latestProducts!.map((x) => x.toJson())),
      };
}

class LatestProductsModel {
  final String? id;
  final String? productName;
  final List<String>? inventoryIds;
  final String? inventoryId;
  final String? productImage;
  final Category? category;
  final InventoryDetails? inventoryDetails;
  final List<Diamond>? diamonds;
  final String? diamondClarity;
  final String? metalId;
  final String? sizeId;
  final bool? isDiamondMultiple;

  LatestProductsModel({
    this.id,
    this.productName,
    this.inventoryIds,
    this.inventoryId,
    this.productImage,
    this.category,
    this.inventoryDetails,
    this.diamonds,
    this.diamondClarity,
    this.metalId,
    this.sizeId,
    this.isDiamondMultiple,
  });

  factory LatestProductsModel.fromJson(Map<String, dynamic> json) => LatestProductsModel(
        id: json["_id"],
        productName: json["product_name"],
        inventoryIds: json["inventory_ids"] == null ? [] : List<String>.from(json["inventory_ids"]),
        inventoryId: json["inventory_id"],
        productImage: json["product_image"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        inventoryDetails: json["inventory_details"] == null ? null : InventoryDetails.fromJson(json["inventory_details"]),
        diamonds: json["diamonds"] == null ? [] : List<Diamond>.from(json["diamonds"].map((x) => Diamond.fromJson(x))),
        diamondClarity: json["diamondClarity"],
        metalId: json["metalId"],
        sizeId: json["sizeId"],
        isDiamondMultiple: json["isDiamondMultiple"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_name": productName,
        "inventory_ids": inventoryIds == null ? [] : List<dynamic>.from(inventoryIds!),
        "inventory_id": inventoryId,
        "product_image": productImage,
        "category": category?.toJson(),
        "inventory_details": inventoryDetails?.toJson(),
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "diamondClarity": diamondClarity,
        "metalId": metalId,
        "sizeId": sizeId,
        "isDiamondMultiple": isDiamondMultiple,
      };
}

class InventoryDetails {
  final String? id;
  final String? name;
  final String? slug;
  final String? sku;
  final List<String>? inventoryImages;
  final String? categoryId;
  final String? subCategoryId;
  final String? sizeId;
  final String? metalId;
  final double? metalWeight;
  final bool? status;
  final List<Diamond>? diamonds;
  final double? diamondTotalPrice;
  final double? manufacturingPrice;
  final String? gender;
  final List<dynamic>? productTags;
  final String? createdBy;
  final String? updatedBy;
  final bool? inStock;
  final bool? wearItItem;
  final String? delivery;
  final String? productionName;
  final dynamic deletedAt;
  final List<dynamic>? familyProducts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  InventoryDetails({
    this.id,
    this.name,
    this.slug,
    this.sku,
    this.inventoryImages,
    this.categoryId,
    this.subCategoryId,
    this.sizeId,
    this.metalId,
    this.metalWeight,
    this.status,
    this.diamonds,
    this.diamondTotalPrice,
    this.manufacturingPrice,
    this.gender,
    this.productTags,
    this.createdBy,
    this.updatedBy,
    this.inStock,
    this.wearItItem,
    this.delivery,
    this.productionName,
    this.deletedAt,
    this.familyProducts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory InventoryDetails.fromJson(Map<String, dynamic> json) => InventoryDetails(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        metalWeight: (json["metal_weight"] as num?)?.toDouble(),
        status: json["status"],
        diamonds: json["diamonds"] == null ? [] : List<Diamond>.from(json["diamonds"].map((x) => Diamond.fromJson(x))),
        diamondTotalPrice: (json["diamond_total_price"] as num?)?.toDouble(),
        manufacturingPrice: (json["manufacturing_price"] as num?)?.toDouble(),
        gender: json["gender"],
        productTags: json["product_tags"] ?? [],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        inStock: json["in_stock"],
        wearItItem: json["wear_it_item"],
        delivery: json["delivery"],
        productionName: json["production_name"],
        deletedAt: json["deleted_at"],
        familyProducts: json["family_products"] ?? [],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "inventory_images": inventoryImages,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "size_id": sizeId,
        "metal_id": metalId,
        "metal_weight": metalWeight,
        "status": status,
        "diamonds": diamonds == null ? [] : diamonds!.map((x) => x.toJson()).toList(),
        "diamond_total_price": diamondTotalPrice,
        "manufacturing_price": manufacturingPrice,
        "gender": gender,
        "product_tags": productTags,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "in_stock": inStock,
        "wear_it_item": wearItItem,
        "delivery": delivery,
        "production_name": productionName,
        "deleted_at": deletedAt,
        "family_products": familyProducts,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Diamond {
  final String? id;
  final String? diamondClarity;
  final String? diamondShape;
  final String? diamondSize;
  final int? diamondCount;
  final double? totalPrice;

  Diamond({
    this.id,
    this.diamondClarity,
    this.diamondShape,
    this.diamondSize,
    this.diamondCount,
    this.totalPrice,
  });

  factory Diamond.fromJson(Map<String, dynamic> json) => Diamond(
        id: json["_id"],
        diamondClarity: json["diamond_clarity"],
        diamondShape: json["diamond_shape"],
        diamondSize: json["diamond_size"],
        diamondCount: json["diamond_count"],
        totalPrice: (json["total_price"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "diamond_clarity": diamondClarity,
        "diamond_shape": diamondShape,
        "diamond_size": diamondSize,
        "diamond_count": diamondCount,
        "total_price": totalPrice,
      };
}
