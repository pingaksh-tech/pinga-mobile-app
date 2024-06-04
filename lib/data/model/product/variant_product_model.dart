import 'dart:convert';

GetVariantProductModel getVariantProductModelFromJson(String str) => GetVariantProductModel.fromJson(json.decode(str));

String getVariantProductModelToJson(GetVariantProductModel data) => json.encode(data.toJson());

class GetVariantProductModel {
  final bool? success;
  final String? message;
  final ProductVariantModel? data;

  GetVariantProductModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetVariantProductModel.fromJson(Map<String, dynamic> json) => GetVariantProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductVariantModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductVariantModel {
  final List<ProductVariant>? products;

  ProductVariantModel({
    this.products,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) => ProductVariantModel(
        products: json["products"] == null ? [] : List<ProductVariant>.from(json["products"]!.map((x) => ProductVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class ProductVariant {
  final String? id;
  final String? name;
  final int? price;
  final String? color;
  final String? size;
  final int? quantity;
  final String? diamond;

  ProductVariant({
    this.id,
    this.name,
    this.price,
    this.color,
    this.size,
    this.quantity,
    this.diamond,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        color: json["color"],
        size: json["size"],
        quantity: json["quantity"],
        diamond: json["diamond"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "color": color,
        "size": size,
        "quantity": quantity,
        "diamond": diamond,
      };
}
