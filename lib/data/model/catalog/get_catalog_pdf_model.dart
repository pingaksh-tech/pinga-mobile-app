import 'dart:convert';

GetCatalogPdfModel getCatalogPdfModelFromJson(String str) => GetCatalogPdfModel.fromJson(json.decode(str));

String getCatalogPdfModelToJson(GetCatalogPdfModel data) => json.encode(data.toJson());

class GetCatalogPdfModel {
  final String? message;
  final List<CatalogPdfModel>? data;

  GetCatalogPdfModel({
    this.message,
    this.data,
  });

  factory GetCatalogPdfModel.fromJson(Map<String, dynamic> json) => GetCatalogPdfModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<CatalogPdfModel>.from(json["data"]!.map((x) => CatalogPdfModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CatalogPdfModel {
  final dynamic inventoryImage;
  final String? name;
  final num? price;
  final String? size;
  final List<String>? diamondClarity;
  final String? metal;

  CatalogPdfModel({
    this.inventoryImage,
    this.name,
    this.price,
    this.size,
    this.diamondClarity,
    this.metal,
  });

  factory CatalogPdfModel.fromJson(Map<String, dynamic> json) => CatalogPdfModel(
        inventoryImage: json["inventory_image"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        diamondClarity: json["diamond_clarity"] == null ? [] : List<String>.from(json["diamond_clarity"]!.map((x) => x ?? "")),
        metal: json["metal"],
      );

  Map<String, dynamic> toJson() => {
        "inventory_image": inventoryImage,
        "name": name,
        "price": price,
        "size": size,
        "diamond_clarity": diamondClarity == null ? [] : List<dynamic>.from(diamondClarity!.map((x) => x)),
        "metal": metal,
      };
}
