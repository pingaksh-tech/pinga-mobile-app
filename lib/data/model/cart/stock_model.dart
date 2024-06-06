// To parse this JSON data, do
//
//     final getStockModel = getStockModelFromJson(jsonString);

import 'dart:convert';

GetStockModel getStockModelFromJson(String str) => GetStockModel.fromJson(json.decode(str));

String getStockModelToJson(GetStockModel data) => json.encode(data.toJson());

class GetStockModel {
  final bool? success;
  final String? message;
  final Data? stockModel;

  GetStockModel({
    this.success,
    this.message,
    this.stockModel,
  });

  factory GetStockModel.fromJson(Map<String, dynamic> json) => GetStockModel(
        success: json["success"],
        message: json["message"],
        stockModel: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": stockModel?.toJson(),
      };
}

class Data {
  final List<StockList>? stocks;

  Data({
    this.stocks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stocks: json["stocks"] == null ? [] : List<StockList>.from(json["stocks"]!.map((x) => StockList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stocks": stocks == null ? [] : List<dynamic>.from(stocks!.map((x) => x.toJson())),
      };
}

class StockList {
  final String? id;
  final String? value;
  final String? stock;
  final String? image;

  StockList({
    this.id,
    this.value,
    this.stock,
    this.image,
  });

  factory StockList.fromJson(Map<String, dynamic> json) => StockList(
        id: json["id"],
        value: json["value"],
        stock: json["stock"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "stock": stock,
        "image": image,
      };
}
