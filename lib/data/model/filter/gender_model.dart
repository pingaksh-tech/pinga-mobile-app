// To parse this JSON data, do
//
//     final getGenderModel = getGenderModelFromJson(jsonString);

import 'dart:convert';

GetGenderModel getGenderModelFromJson(String str) => GetGenderModel.fromJson(json.decode(str));

String getGenderModelToJson(GetGenderModel data) => json.encode(data.toJson());

class GetGenderModel {
  final bool? success;
  final String? message;
  final Data? data;

  GetGenderModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetGenderModel.fromJson(Map<String, dynamic> json) => GetGenderModel(
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
  final List<Product>? products;

  Data({
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  final String? title;
  final bool? isChecked;

  Product({
    this.title,
    this.isChecked,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        isChecked: json["isChecked"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isChecked": isChecked,
      };
}
