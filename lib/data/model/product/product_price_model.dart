import 'dart:convert';

import 'package:get/get.dart';

import 'products_model.dart';

GetProductPriceModel getProductPriceModelFromJson(String str) => GetProductPriceModel.fromJson(json.decode(str));

String getProductPriceModelToJson(GetProductPriceModel data) => json.encode(data.toJson());

class GetProductPriceModel {
  final String? message;
  final ProductPriceModel? data;

  GetProductPriceModel({
    this.message,
    this.data,
  });

  factory GetProductPriceModel.fromJson(Map<String, dynamic> json) => GetProductPriceModel(
        message: json["message"],
        data: json["data"] == null ? null : ProductPriceModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductPriceModel {
  final RxNum? inventoryTotalPrice;
  final CartQty? cartQty;

  ProductPriceModel({
    this.inventoryTotalPrice,
    this.cartQty,
  });

  factory ProductPriceModel.fromJson(Map<String, dynamic> json) => ProductPriceModel(
        inventoryTotalPrice: RxNum(json["inventory_total_price"] ?? 0),
        cartQty: json["cartQty"] == null ? null : CartQty.fromJson(json["cartQty"]),
      );

  Map<String, dynamic> toJson() => {
        "inventory_total_price": inventoryTotalPrice?.value,
        "cartQty": cartQty?.toJson(),
      };
}

class CartQty {
  final int? extraMetalWeight;
  final String? id;
  final String? sizeId;
  final String? userId;
  final List<DiamondListModel>? diamonds;
  final String? diamondClarity;
  final String? metalId;
  final String? inventoryId;
  final int? v;
  final DateTime? createdAt;
  final num? diamondTotalPrice;
  final int? quantity;
  final dynamic remark;
  final DateTime? updatedAt;

  CartQty({
    this.extraMetalWeight,
    this.id,
    this.sizeId,
    this.userId,
    this.diamonds,
    this.diamondClarity,
    this.metalId,
    this.inventoryId,
    this.v,
    this.createdAt,
    this.diamondTotalPrice,
    this.quantity,
    this.remark,
    this.updatedAt,
  });

  factory CartQty.fromJson(Map<String, dynamic> json) => CartQty(
        extraMetalWeight: json["extra_metal_weight"],
        id: json["_id"],
        sizeId: json["size_id"],
        userId: json["user_id"],
        diamonds: json["diamonds"] == null ? [] : List<DiamondListModel>.from(json["diamonds"]!.map((x) => DiamondListModel.fromJson(x))),
        diamondClarity: json["diamond_clarity"],
        metalId: json["metal_id"],
        inventoryId: json["inventory_id"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        diamondTotalPrice: json["diamond_total_price"],
        quantity: json["quantity"],
        remark: json["remark"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "extra_metal_weight": extraMetalWeight,
        "_id": id,
        "size_id": sizeId,
        "user_id": userId,
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "diamond_clarity": diamondClarity,
        "metal_id": metalId,
        "inventory_id": inventoryId,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "diamond_total_price": diamondTotalPrice,
        "quantity": quantity,
        "remark": remark,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
