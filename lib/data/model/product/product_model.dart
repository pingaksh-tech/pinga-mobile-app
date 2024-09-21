// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetProductModel getProductModelFromJson(String str) => GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) => json.encode(data.toJson());

class GetProductModel {
  final bool? success;
  final String? message;
  final ProductData? data;

  GetProductModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductData {
  final List<ProductListModel>? products;
  final double? total;

  ProductData({
    this.products,
    this.total,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      ProductData(
        products: json["products"] == null ? [] : List<ProductListModel>.from(json["products"]!.map((x) => ProductListModel.fromJson(x))),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() =>
      {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
      };
}

class ProductListModel {
  final String? id;
  final String? user;
  final ProductProduct? product;
  final RxInt? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductListModel({
    this.id,
    this.user,
    this.product,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["_id"],
        user: json["user"],
        product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"] == null ? null : RxInt(int.tryParse(json["quantity"].toString()) ?? 0),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "user": user,
        "product": product?.toJson(),
        "quantity": quantity?.value,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProductProduct {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? color;
  final String? category;
  final String? rate;
  final double? weight;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? productImage;
  final String? brandName;

  ProductProduct({
    this.id,
    this.title,
    this.description,
    this.price,
    this.color,
    this.category,
    this.rate,
    this.weight,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productImage,
    this.brandName,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) =>
      ProductProduct(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        color: json["color"],
        category: json["category"],
        rate: json["rate"],
        weight: json["weight"]?.toDouble(),
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        productImage: json["productImages"],
        brandName: json["brand_name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "color": color,
        "category": category,
        "rate": rate,
        "weight": weight,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "productImages": productImage,
        "brand_name": brandName,
      };
}
