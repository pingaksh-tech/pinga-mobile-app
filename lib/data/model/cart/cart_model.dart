// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

import '../product/products_model.dart';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  final String? message;
  final GetCartDataModel? data;

  GetCartModel({
    this.message,
    this.data,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : GetCartDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetCartDataModel {
  final CartsDetails? cartsDetails;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<CartModel>? cartList;

  GetCartDataModel({
    this.cartsDetails,
    this.totalCount,
    this.page,
    this.totalPages,
    this.cartList,
  });

  factory GetCartDataModel.fromJson(Map<String, dynamic> json) =>
      GetCartDataModel(
        cartsDetails: json["cartsDetails"] == null
            ? null
            : CartsDetails.fromJson(json["cartsDetails"]),
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        cartList: json["cartList"] == null
            ? []
            : List<CartModel>.from(
                json["cartList"]!.map((x) => CartModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartsDetails": cartsDetails?.toJson(),
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "cartList": cartList == null
            ? []
            : List<dynamic>.from(cartList!.map((x) => x.toJson())),
      };
}

class CartModel {
  final String? id;
  final RxString? metalId;
  final String? diamondClarity;
  final RxString? sizeId;
  final String? userId;
  final String? categoryId;
  final List<DiamondListModel>? diamonds;
  final int? quantity;
  final RxString? remark;
  final String? inventoryId;
  final String? subCategoryId;
  final String? inventoryName;
  final List<String>? inventoryImage;
  final double? inventoryTotalPrice;
  final bool? isDiamondMultiple;

  CartModel({
    this.id,
    this.metalId,
    this.diamondClarity,
    this.sizeId,
    this.userId,
    this.diamonds,
    this.quantity,
    this.remark,
    this.inventoryId,
    this.subCategoryId,
    this.inventoryName,
    this.inventoryImage,
    this.inventoryTotalPrice,
    this.categoryId,
    this.isDiamondMultiple,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        metalId: RxString(json["metal_id"].toString()),
        diamondClarity: json["diamond_clarity"],
        sizeId: RxString(json["size_id"].toString()),
        userId: json["user_id"],
        categoryId: json["category_id"],
        diamonds: json["diamonds"] == null
            ? []
            : List<DiamondListModel>.from(
                json["diamonds"]!.map((x) => DiamondListModel.fromJson(x))),
        quantity: json["quantity"],
        remark: RxString(json["remark"].toString()),
        inventoryId: json["inventory_id"],
        subCategoryId: json["sub_category_id"],
        inventoryName: json["inventory_name"],
        inventoryImage: json["inventory_image"] == null
            ? []
            : List<String>.from(json["inventory_image"]!.map((x) => x)),
        inventoryTotalPrice: json["inventory_total_price"]?.toDouble(),
        isDiamondMultiple: json["isDiamondMultiple"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "metal_id": metalId.obs,
        "diamond_clarity": diamondClarity,
        "size_id": sizeId.obs,
        "user_id": userId,
        "category_id": categoryId,
        "diamonds": diamonds == null
            ? []
            : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "quantity": quantity,
        "remark": remark.obs,
        "inventory_id": inventoryId,
        "sub_category_id": subCategoryId,
        "inventory_name": inventoryName,
        "inventory_image": inventoryImage == null
            ? []
            : List<dynamic>.from(inventoryImage!.map((x) => x)),
        "inventory_total_price": inventoryTotalPrice,
        "isDiamondMultiple": isDiamondMultiple,
      };
}

class CartsDetails {
  final dynamic id;
  final int? totalItems;
  final int? totalQuantity;
  final double? totalPrice;

  CartsDetails({
    this.id,
    this.totalItems,
    this.totalQuantity,
    this.totalPrice,
  });

  factory CartsDetails.fromJson(Map<String, dynamic> json) => CartsDetails(
        id: json["_id"],
        totalItems: json["total_items"],
        totalQuantity: json["total_quantity"],
        totalPrice: json["total_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total_items": totalItems,
        "total_quantity": totalQuantity,
        "total_price": totalPrice,
      };
}
