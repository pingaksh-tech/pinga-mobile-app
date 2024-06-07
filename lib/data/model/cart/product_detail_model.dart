// To parse this JSON data, do
//
//     final getProductDetailModel = getProductDetailModelFromJson(jsonString);

import 'dart:convert';

GetProductDetailModel getProductDetailModelFromJson(String str) => GetProductDetailModel.fromJson(json.decode(str));

String getProductDetailModelToJson(GetProductDetailModel data) => json.encode(data.toJson());

class GetProductDetailModel {
  final bool? success;
  final String? message;
  final ProductDetailModel? data;

  GetProductDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetProductDetailModel.fromJson(Map<String, dynamic> json) => GetProductDetailModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductDetailModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductDetailModel {
  final List<ProductDetail>? productDetail;

  ProductDetailModel({
    this.productDetail,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        productDetail: json["productDetail"] == null ? [] : List<ProductDetail>.from(json["productDetail"]!.map((x) => ProductDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productDetail": productDetail == null ? [] : List<dynamic>.from(productDetail!.map((x) => x.toJson())),
      };
}

class ProductDetail {
  final String? categoryName;
  final String? value;

  ProductDetail({
    this.categoryName,
    this.value,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        categoryName: json["categoryName"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "value": value,
      };
}
