import 'dart:convert';

GetProductColorModel getProductColorModelFromJson(String str) => GetProductColorModel.fromJson(json.decode(str));

String getProductColorModelToJson(GetProductColorModel data) => json.encode(data.toJson());

class GetProductColorModel {
  final bool? success;
  final String? message;
  final ProductColorModel? data;

  GetProductColorModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetProductColorModel.fromJson(Map<String, dynamic> json) => GetProductColorModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductColorModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductColorModel {
  final List<ColorModel>? colors;

  ProductColorModel({
    this.colors,
  });

  factory ProductColorModel.fromJson(Map<String, dynamic> json) => ProductColorModel(
        colors: json["colors"] == null ? [] : List<ColorModel>.from(json["colors"]!.map((x) => ColorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x.toJson())),
      };
}

class ColorModel {
  final String? id;
  final String? size;

  ColorModel({
    this.id,
    this.size,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["id"],
        size: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": size,
      };
}
