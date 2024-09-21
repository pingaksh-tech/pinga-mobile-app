// To parse this JSON data, do
//
//     final getWatchlistModel = getWatchlistModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetWatchListModel getWatchlistModelFromJson(String str) =>
    GetWatchListModel.fromJson(json.decode(str));

String getWatchlistModelToJson(GetWatchListModel data) =>
    json.encode(data.toJson());

class GetWatchListModel {
  final String? message;
  final WatchlistModel? data;

  GetWatchListModel({
    this.message,
    this.data,
  });

  factory GetWatchListModel.fromJson(Map<String, dynamic> json) =>
      GetWatchListModel(
        message: json["message"],
        data:
            json["data"] == null ? null : WatchlistModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class WatchlistModel {
  final int? filteredCount;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<WatchList>? watchLists;

  WatchlistModel({
    this.filteredCount,
    this.totalCount,
    this.page,
    this.totalPages,
    this.watchLists,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) => WatchlistModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        watchLists: json["watchLists"] == null
            ? []
            : List<WatchList>.from(
                json["watchLists"]!.map((x) => WatchList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "watchLists": watchLists == null
            ? []
            : List<dynamic>.from(watchLists!.map((x) => x.toJson())),
      };
}

class WatchList {
  RxString? id;
  final String? name;
  final String? createdBy;
  final String? updatedBy;
  final int? v;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final bool? status;
  final List<WatchlistItemModel>? watchlistItems;
  final int? watchListItemCount;

  WatchList({
    this.id,
    this.name,
    this.createdBy,
    this.updatedBy,
    this.v,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.status,
    this.watchlistItems,
    this.watchListItemCount,
  });

  factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
        id: RxString(json["_id"].toString()),
        name: json["name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        watchlistItems: json["watchlistItems"] == null
            ? []
            : List<WatchlistItemModel>.from(json["watchlistItems"]!
                .map((x) => WatchlistItemModel.fromJson(x))),
        watchListItemCount: json["watchListItemCount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id?.value,
        "name": name,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "watchlistItems": watchlistItems == null
            ? []
            : List<dynamic>.from(watchlistItems!.map((x) => x.toJson())),
        "watchListItemCount": watchListItemCount,
      };
}

class WatchlistItemModel {
  final String? id;
  final String? sizeId;
  final String? metalId;
  final String? watchListId;
  final String? inventoryId;
  final int? v;
  final String? diamondClarity;
  final int? quantity;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final Inventory? inventory;

  WatchlistItemModel({
    this.id,
    this.sizeId,
    this.metalId,
    this.watchListId,
    this.inventoryId,
    this.v,
    this.diamondClarity,
    this.quantity,
    this.remark,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.inventory,
  });

  factory WatchlistItemModel.fromJson(Map<String, dynamic> json) =>
      WatchlistItemModel(
        id: json["_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        watchListId: json["watchListId"],
        inventoryId: json["inventory_id"],
        v: json["__v"],
        diamondClarity: json["diamond_clarity"],
        quantity: json["quantity"],
        remark: json["remark"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        inventory: json["inventory"] == null
            ? null
            : Inventory.fromJson(json["inventory"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size_id": sizeId,
        "metal_id": metalId,
        "watchListId": watchListId,
        "inventory_id": inventoryId,
        "__v": v,
        "diamond_clarity": diamondClarity,
        "quantity": quantity,
        "remark": remark,
        "createdAt": createdAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "inventory": inventory?.toJson(),
      };
}

class Inventory {
  final String? id;
  final String? categoryId;
  final String? subCategoryId;

  Inventory({
    this.id,
    this.categoryId,
    this.subCategoryId,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
      };
}
