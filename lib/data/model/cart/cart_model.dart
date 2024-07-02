// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) => GetCartModel.fromJson(json.decode(str));

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
        data: json["data"] == null ? null : GetCartDataModel.fromJson(json["data"]),
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

  factory GetCartDataModel.fromJson(Map<String, dynamic> json) => GetCartDataModel(
        cartsDetails: json["cartsDetails"] == null ? null : CartsDetails.fromJson(json["cartsDetails"]),
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        cartList: json["cartList"] == null ? [] : List<CartModel>.from(json["cartList"]!.map((x) => CartModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartsDetails": cartsDetails?.toJson(),
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "cartList": cartList == null ? [] : List<dynamic>.from(cartList!.map((x) => x.toJson())),
      };
}

class CartModel {
  final String? id;
  final String? sizeId;
  final String? userId;
  final String? metalId;
  final String? inventoryId;
  final String? diamondClarity;
  final int? quantity;
  final String? remark;
  final String? inventoryName;
  final List<String>? inventoryImage;
  final num? inventoryTotalPrice;

  CartModel({
    this.id,
    this.sizeId,
    this.userId,
    this.metalId,
    this.diamondClarity,
    this.quantity,
    this.remark,
    this.inventoryName,
    this.inventoryImage,
    this.inventoryTotalPrice,
    this.inventoryId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        sizeId: json["size_id"],
        userId: json["user_id"],
        metalId: json["metal_id"],
        diamondClarity: json["diamond_clarity"],
        quantity: json["quantity"],
        remark: json["remark"],
        inventoryName: json["inventory_name"],
        inventoryImage: json["inventory_image"] == null ? [] : List<String>.from(json["inventory_image"]!.map((x) => x)),
        inventoryTotalPrice: json["inventory_total_price"]?.toDouble(),
        inventoryId: json["inventory_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size_id": sizeId,
        "user_id": userId,
        "metal_id": metalId,
        "diamond_clarity": diamondClarity,
        "quantity": quantity,
        "remark": remark,
        "inventory_name": inventoryName,
        "inventory_image": inventoryImage == null ? [] : List<dynamic>.from(inventoryImage!.map((x) => x)),
        "inventory_total_price": inventoryTotalPrice,
        "inventory_id": inventoryId,
      };
}

class CartsDetails {
  final String? id;
  final int? totalItems;
  final int? totalQuantity;
  final num? totalPrice;

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
