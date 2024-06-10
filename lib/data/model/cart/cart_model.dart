// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

CartDataModel cartModelFromJson(String str) => CartDataModel.fromJson(json.decode(str));

String cartModelToJson(CartDataModel data) => json.encode(data.toJson());

class CartDataModel {
  final bool? success;
  final String? message;
  final Data? data;

  CartDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final List<CartItemModel>? products;
  final double? total;

  Data({
    this.products,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null ? [] : List<CartItemModel>.from(json["products"]!.map((x) => CartItemModel.fromJson(x))),
        total: double.tryParse(json["total"].toString()) ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
      };
}

class CartItemModel {
  final String? id;
  final String? user;
  final ProductProduct? product;
  RxInt? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CartItemModel({
    this.id,
    this.user,
    this.product,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json["_id"],
        user: json["user"],
        product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
        quantity: RxInt(json["quantity"] ?? 1),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "product": product?.toJson(),
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProductProduct {
  final String? id;
  final String? title;
  final String? description;
  final num? price;
  final String? color;
  final String? category;
  final String? brandName;
  final String? rate;
  final num? weight;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductImage>? productImages;

  ProductProduct({
    this.id,
    this.title,
    this.description,
    this.price,
    this.color,
    this.category,
    this.brandName,
    this.rate,
    this.weight,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productImages,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: double.tryParse(json["price"].toString()) ?? 0.0,
        color: json["color"],
        category: json["category"],
        brandName: json["brand_name"],
        rate: json["rate"],
        weight: double.tryParse(json["weight"].toString()) ?? 0.0,
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        productImages: json["productimages"] == null ? [] : List<ProductImage>.from(json["productimages"]!.map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "color": color,
        "category": category,
        "brand_name": brandName,
        "rate": rate,
        "weight": weight,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "productimages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x.toJson())),
      };
}

class ProductImage {
  final String? id;
  final String? image;

  ProductImage({
    this.id,
    this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
      };
}
