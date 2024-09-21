import 'dart:convert';

import '../product/products_model.dart';

GetSingleWatchlistModel getWatchlistModelFromJson(String str) => GetSingleWatchlistModel.fromJson(json.decode(str));

String getWatchlistModelToJson(GetSingleWatchlistModel data) => json.encode(data.toJson());

class GetSingleWatchlistModel {
  final String? message;
  final SingleWatchlistModel? data;

  GetSingleWatchlistModel({
    this.message,
    this.data,
  });

  factory GetSingleWatchlistModel.fromJson(Map<String, dynamic> json) => GetSingleWatchlistModel(
        message: json["message"],
        data: json["data"] == null ? null : SingleWatchlistModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class SingleWatchlistModel {
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final WatchList? watchList;
  final List<InventoryModel>? inventories;

  SingleWatchlistModel({
    this.totalCount,
    this.page,
    this.totalPages,
    this.watchList,
    this.inventories,
  });

  factory SingleWatchlistModel.fromJson(Map<String, dynamic> json) => SingleWatchlistModel(
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        watchList: json["watchList"] == null ? null : WatchList.fromJson(json["watchList"]),
        inventories: json["inventories"] == null ? [] : List<InventoryModel>.from(json["inventories"]!.map((x) => InventoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "watchList": watchList?.toJson(),
        "inventories": inventories == null ? [] : List<dynamic>.from(inventories!.map((x) => x.toJson())),
      };
}

class WatchList {
  final String? id;
  final String? name;
  final String? createdBy;
  final int? v;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final bool? status;
  final DateTime? updatedAt;
  final dynamic updatedBy;

  WatchList({
    this.id,
    this.name,
    this.createdBy,
    this.v,
    this.createdAt,
    this.deletedAt,
    this.status,
    this.updatedAt,
    this.updatedBy,
  });

  factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
        id: json["_id"],
        name: json["name"],
        createdBy: json["created_by"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "created_by": createdBy,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
      };
}
