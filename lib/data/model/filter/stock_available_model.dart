// To parse this JSON data, do
//
//     final getStockAvailableModel = getStockAvailableModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetStockAvailableModel getStockAvailableModelFromJson(String str) => GetStockAvailableModel.fromJson(json.decode(str));

String getStockAvailableModelToJson(GetStockAvailableModel data) => json.encode(data.toJson());

class GetStockAvailableModel {
  final bool? success;
  final String? message;
  final GetStockAvailableList? data;

  GetStockAvailableModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetStockAvailableModel.fromJson(Map<String, dynamic> json) => GetStockAvailableModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : GetStockAvailableList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class GetStockAvailableList {
  final List<StockAvailableList>? products;

  GetStockAvailableList({
    this.products,
  });

  factory GetStockAvailableList.fromJson(Map<String, dynamic> json) => GetStockAvailableList(
        products: json["products"] == null ? [] : List<StockAvailableList>.from(json["products"]!.map((x) => StockAvailableList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class StockAvailableList {
  final String? title;
  RxBool? isChecked;

  StockAvailableList({
    this.title,
    this.isChecked,
  });

  factory StockAvailableList.fromJson(Map<String, dynamic> json) => StockAvailableList(
        title: json["title"],
        isChecked: json["isChecked"] == null ? null : RxBool(json["isChecked"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isChecked": isChecked?.value,
      };
}
