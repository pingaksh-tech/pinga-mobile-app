import 'dart:convert';

GetProductSizeModel getProductSizeModelFromJson(String str) => GetProductSizeModel.fromJson(json.decode(str));

String getProductSizeModelToJson(GetProductSizeModel data) => json.encode(data.toJson());

class GetProductSizeModel {
  final bool? success;
  final String? message;
  final ProductSizeModel? data;

  GetProductSizeModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetProductSizeModel.fromJson(Map<String, dynamic> json) => GetProductSizeModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductSizeModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductSizeModel {
  final List<SizeModel>? sizes;

  ProductSizeModel({
    this.sizes,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) => ProductSizeModel(
        sizes: json["sizes"] == null ? [] : List<SizeModel>.from(json["sizes"]!.map((x) => SizeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x.toJson())),
      };
}

class SizeModel {
  final String? id;
  final String? size;

  SizeModel({
    this.id,
    this.size,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        id: json["id"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
      };
}
