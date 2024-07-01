import 'dart:convert';

import 'package:get/get.dart';

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
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<CartModel>? cartList;

  GetCartDataModel({
    this.totalCount,
    this.page,
    this.totalPages,
    this.cartList,
  });

  factory GetCartDataModel.fromJson(Map<String, dynamic> json) => GetCartDataModel(
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        cartList: json["cartList"] == null ? [] : List<CartModel>.from(json["cartList"]!.map((x) => CartModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "cartList": cartList == null ? [] : List<dynamic>.from(cartList!.map((x) => x.toJson())),
      };
}

class CartModel {
  final String? id;
  final String? userId;
  final String? diamondClarity;
  final String? metalId;
  final String? sizeId;
  RxInt? quantity;
  final dynamic remark;
  final String? inventoryName;
  final String? inventoryImage;
  final String? categoryName;
  final num? inventoryTotalPrice;

  CartModel({
    this.id,
    this.userId,
    this.diamondClarity,
    this.metalId,
    this.sizeId,
    this.quantity,
    this.remark,
    this.inventoryName,
    this.inventoryImage,
    this.categoryName,
    this.inventoryTotalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(id: json["_id"], userId: json["user_id"], diamondClarity: json["diamond_clarity"], metalId: json["metal_id"], sizeId: json["size_id"], quantity: RxInt(json["quantity"] ?? 1), remark: json["remark"], inventoryName: json["inventory_name"], inventoryImage: json["inventory_image"], categoryName: json["category_name"], inventoryTotalPrice: double.tryParse(json["inventory_total_price"].toString()) ?? 0.0);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "diamond_clarity": diamondClarity,
        "metal_id": metalId,
        "size_id": sizeId,
        "quantity": quantity,
        "remark": remark,
        "inventory_name": inventoryName,
        "inventory_image": inventoryImage,
        "category_name": categoryName,
        "inventory_total_price": inventoryTotalPrice,
      };
}
