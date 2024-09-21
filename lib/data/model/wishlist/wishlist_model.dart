import 'dart:convert';

import 'package:get/get.dart';

import '../product/products_model.dart';

GetWishlistModel getWishlistModelFromJson(String str) => GetWishlistModel.fromJson(json.decode(str));

String getWishlistModelToJson(GetWishlistModel data) => json.encode(data.toJson());

class GetWishlistModel {
  final String? message;
  final WishlistModel? data;

  GetWishlistModel({
    this.message,
    this.data,
  });

  factory GetWishlistModel.fromJson(Map<String, dynamic> json) => GetWishlistModel(
        message: json["message"],
        data: json["data"] == null ? null : WishlistModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class WishlistModel {
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<AllWishlistModel>? wishlists;

  WishlistModel({
    this.totalCount,
    this.page,
    this.totalPages,
    this.wishlists,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        wishlists: json["wishlists"] == null ? [] : List<AllWishlistModel>.from(json["wishlists"]!.map((x) => AllWishlistModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "wishlists": wishlists == null ? [] : List<dynamic>.from(wishlists!.map((x) => x.toJson())),
      };
}

class AllWishlistModel {
  final String? id;
  final DateTime? deletedAt;
  final String? inventoryId;
  final String? createdBy;
  final int? v;
  final DateTime? createdAt;
  final bool? isWishlist;
  final DateTime? updatedAt;
  final WishlistInventory? inventory;

  AllWishlistModel({
    this.id,
    this.deletedAt,
    this.inventoryId,
    this.createdBy,
    this.v,
    this.createdAt,
    this.isWishlist,
    this.updatedAt,
    this.inventory,
  });

  factory AllWishlistModel.fromJson(Map<String, dynamic> json) => AllWishlistModel(
        id: json["_id"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
        inventoryId: json["inventory_id"],
        createdBy: json["created_by"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isWishlist: json["is_wishlist"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        inventory: json["inventory"] == null ? null : WishlistInventory.fromJson(json["inventory"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "deleted_at": deletedAt?.toIso8601String(),
        "inventory_id": inventoryId,
        "created_by": createdBy,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "is_wishlist": isWishlist,
        "updatedAt": updatedAt?.toIso8601String(),
        "inventory": inventory?.toJson(),
      };
}

class WishlistInventory {
  final String? id;
  final String? name;
  final List<String>? inventoryImages;
  final String? categoryId;
  final String? subCategoryId;
  final String? sizeId;
  final String? metalId;
  final num? metalWeight;
  final List<DiamondListModel>? diamonds;
  RxNum? inventoryTotalPrice;
  final String? singleInvImage;
  final RxInt? quantity;
  final bool? isDiamondMultiple;

  WishlistInventory({
    this.id,
    this.name,
    this.inventoryImages,
    this.categoryId,
    this.subCategoryId,
    this.sizeId,
    this.metalId,
    this.metalWeight,
    this.diamonds,
    this.inventoryTotalPrice,
    this.singleInvImage,
    this.quantity,
    this.isDiamondMultiple,
  });

  factory WishlistInventory.fromJson(Map<String, dynamic> json) => WishlistInventory(
        id: json["_id"],
        name: json["name"],
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]!.map((x) => x)),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        metalWeight: json["metal_weight"],
        diamonds: json["diamonds"] == null ? [] : List<DiamondListModel>.from(json["diamonds"]!.map((x) => DiamondListModel.fromJson(x))),
        inventoryTotalPrice: json["inventory_total_price"] == null ? null : RxNum(num.tryParse(json["inventory_total_price"].toString()) ?? 0),
        singleInvImage: json["single_inv_image"],
        quantity: 0.obs,
        isDiamondMultiple: json["isDiamondMultiple"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "inventory_images": inventoryImages == null ? [] : List<dynamic>.from(inventoryImages!.map((x) => x)),
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "size_id": sizeId,
        "metal_id": metalId,
        "metal_weight": metalWeight,
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "inventory_total_price": inventoryTotalPrice?.value,
        "single_inv_image": singleInvImage,
        "quantity": quantity?.value,
        "isDiamondMultiple": isDiamondMultiple,
      };
}
