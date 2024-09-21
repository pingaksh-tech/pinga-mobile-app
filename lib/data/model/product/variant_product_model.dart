import 'dart:convert';

import 'package:get/get.dart';

GetVariantProductModel getVariantProductModelFromJson(String str) => GetVariantProductModel.fromJson(json.decode(str));

String getVariantProductModelToJson(GetVariantProductModel data) => json.encode(data.toJson());

class GetVariantProductModel {
  final bool? success;
  final String? message;
  final VariantProductModel? data;

  GetVariantProductModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetVariantProductModel.fromJson(Map<String, dynamic> json) => GetVariantProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : VariantProductModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class VariantProductModel {
  final List<ProductVariant>? products;

  VariantProductModel({
    this.products,
  });

  factory VariantProductModel.fromJson(Map<String, dynamic> json) => VariantProductModel(
        products: json["products"] == null ? [] : List<ProductVariant>.from(json["products"]!.map((x) => ProductVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class ProductVariant {
  final String? id;
  final String? image;
  final String? name;
  final int? price;
  final RxString? colorId;
  final RxString? sizeId;
  final RxInt? quantity;
  final String? diamond;

  ProductVariant({
    this.id,
    this.image,
    this.name,
    this.price,
    this.colorId,
    this.sizeId,
    this.quantity,
    this.diamond,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        colorId: RxString(json["color_id"].toString()),
        sizeId: RxString(json["size_id"].toString()),
        quantity: json["quantity"] == null ? null : RxInt(int.tryParse(json["quantity"].toString()) ?? 0),
        diamond: json["diamond"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "color_id": colorId?.value,
        "size_id": sizeId?.value,
        "quantity": quantity?.value,
        "diamond": diamond,
      };
}
