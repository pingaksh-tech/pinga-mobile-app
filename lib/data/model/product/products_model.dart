// To parse this JSON data, do
//
//     final getProductsModel = getProductsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetProductsModel getProductsModelFromJson(String str) => GetProductsModel.fromJson(json.decode(str));

String getProductsModelToJson(GetProductsModel data) => json.encode(data.toJson());

class GetProductsModel {
  final bool? success;
  final String? message;
  final ProductsModel? data;

  GetProductsModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetProductsModel.fromJson(Map<String, dynamic> json) => GetProductsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductsModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductsModel {
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<InventoryModel>? inventories;

  ProductsModel({
    this.totalCount,
    this.page,
    this.totalPages,
    this.inventories,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        inventories: json["inventories"] == null ? [] : List<InventoryModel>.from(json["inventories"]!.map((x) => InventoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "inventories": inventories == null ? [] : List<dynamic>.from(inventories!.map((x) => x.toJson())),
      };
}

class InventoryModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? sku;
  final List<String>? inventoryImages;
  final String? categoryId;
  final String? subCategoryId;
  final String? sizeId;
  final String? metalId;
  final int? metalWeight;
  final bool? status;
  final List<DiamondListModel>? diamonds;
  final double? diamondTotalPrice;
  final int? manufacturingPrice;
  final RxInt? quantity;
  final String? gender;
  final List<String>? productTags;
  final String? createdBy;
  final String? updatedBy;
  final bool? inStock;
  final bool? wearItItem;
  final String? delivery;
  final String? productionName;
  final DateTime? deletedAt;
  final List<dynamic>? familyProducts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final MetalListModel? metal;
  final List<DiamondPricingModel>? diamondPricings;
  final List<DiamondWeight>? diamondWeight;
  RxNum? inventoryTotalPrice;
  final String? singleInvImage;
  final List<CollectionModel>? collection;
  final List<dynamic>? watchlist;

  InventoryModel({
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
    this.metal,
    this.diamondPricings,
    this.diamondWeight,
    this.inventoryTotalPrice,
    this.singleInvImage,
    this.collection,
    this.watchlist,
    this.quantity,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        quantity: 0.obs,
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]!.map((x) => x)),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        metalWeight: json["metal_weight"],
        status: json["status"],
        diamonds: json["diamonds"] == null ? [] : List<DiamondListModel>.from(json["diamonds"]!.map((x) => DiamondListModel.fromJson(x))),
        diamondTotalPrice: json["diamond_total_price"]?.toDouble(),
        manufacturingPrice: json["manufacturing_price"],
        gender: json["gender"],
        productTags: json["product_tags"] == null ? [] : List<String>.from(json["product_tags"]!.map((x) => x)),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        inStock: json["in_stock"],
        wearItItem: json["wear_it_item"],
        delivery: json["delivery"],
        productionName: json["production_name"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
        familyProducts: json["family_products"] == null ? [] : List<dynamic>.from(json["family_products"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        metal: json["metal"] == null ? null : MetalListModel.fromJson(json["metal"]),
        diamondPricings: json["diamond_pricings"] == null ? [] : List<DiamondPricingModel>.from(json["diamond_pricings"]!.map((x) => DiamondPricingModel.fromJson(x))),
        diamondWeight: json["diamond_weight"] == null ? [] : List<DiamondWeight>.from(json["diamond_weight"]!.map((x) => DiamondWeight.fromJson(x))),
        inventoryTotalPrice: json["inventory_total_price"] == null ? null : RxNum(num.tryParse(json["inventory_total_price"].toString()) ?? 0),
        singleInvImage: json["single_inv_image"],
        collection: json["collection"] == null ? [] : List<CollectionModel>.from(json["collection"]!.map((x) => CollectionModel.fromJson(x))),
        watchlist: json["watchlist"] == null ? [] : List<dynamic>.from(json["watchlist"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "quantity": quantity.obs,
        "inventory_images": inventoryImages == null ? [] : List<dynamic>.from(inventoryImages!.map((x) => x)),
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "size_id": sizeId,
        "metal_id": metalId,
        "metal_weight": metalWeight,
        "status": status,
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "diamond_total_price": diamondTotalPrice,
        "manufacturing_price": manufacturingPrice,
        "gender": gender,
        "product_tags": productTags == null ? [] : List<dynamic>.from(productTags!.map((x) => x)),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "in_stock": inStock,
        "wear_it_item": wearItItem,
        "delivery": delivery,
        "production_name": productionName,
        "deleted_at": deletedAt,
        "family_products": familyProducts == null ? [] : List<dynamic>.from(familyProducts!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "metal": metal?.toJson(),
        "diamond_pricings": diamondPricings == null ? [] : List<dynamic>.from(diamondPricings!.map((x) => x.toJson())),
        "diamond_weight": diamondWeight == null ? [] : List<dynamic>.from(diamondWeight!.map((x) => x.toJson())),
        "inventory_total_price": inventoryTotalPrice?.value,
        "single_inv_image": singleInvImage,
        "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "watchlist": watchlist == null ? [] : List<dynamic>.from(watchlist!.map((x) => x)),
      };
}

class CollectionModel {
  final String? id;
  final String? name;

  CollectionModel({
    this.id,
    this.name,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class DiamondPricingModel {
  final String? id;
  final double? carat;

  DiamondPricingModel({
    this.id,
    this.carat,
  });

  factory DiamondPricingModel.fromJson(Map<String, dynamic> json) => DiamondPricingModel(
        id: json["_id"],
        carat: json["carat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "carat": carat,
      };
}

class DiamondWeight {
  final double? totalWeight;

  DiamondWeight({
    this.totalWeight,
  });

  factory DiamondWeight.fromJson(Map<String, dynamic> json) => DiamondWeight(
        totalWeight: json["total_weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "total_weight": totalWeight,
      };
}

class DiamondListModel {
  RxString? diamondClarity;
  final String? diamondShape;
  final String? diamondSize;
  final int? diamondCount;
  final double? totalPrice;
  final String? id;

  DiamondListModel({
    this.diamondClarity,
    this.diamondShape,
    this.diamondSize,
    this.diamondCount,
    this.totalPrice,
    this.id,
  });

  factory DiamondListModel.fromJson(Map<String, dynamic> json) => DiamondListModel(
        diamondClarity: RxString(json["diamond_clarity"].toString()),
        diamondShape: json["diamond_shape"],
        diamondSize: json["diamond_size"],
        diamondCount: json["diamond_count"],
        totalPrice: json["total_price"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "diamond_clarity": diamondClarity?.value,
        "diamond_shape": diamondShape,
        "diamond_size": diamondSize,
        "diamond_count": diamondCount,
        "total_price": totalPrice,
        "_id": id,
      };
}

class MetalListModel {
  final String? id;
  final String? name;
  final String? sortName;
  final String? metalCarat;
  final String? metalColor;
  final int? pricePerGram;
  final String? createdBy;
  final String? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MetalListModel({
    this.id,
    this.name,
    this.sortName,
    this.metalCarat,
    this.metalColor,
    this.pricePerGram,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MetalListModel.fromJson(Map<String, dynamic> json) => MetalListModel(
        id: json["_id"],
        name: json["name"],
        sortName: json["sort_name"],
        metalCarat: json["metal_carat"],
        metalColor: json["metal_color"],
        pricePerGram: json["price_per_gram"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "sort_name": sortName,
        "metal_carat": metalCarat,
        "metal_color": metalColor,
        "price_per_gram": pricePerGram,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
