// To parse this JSON data, do
//
//     final getCatalogueModel = getCatalogueModelFromJson(jsonString);

import 'dart:convert';

GetCatalogueModel getCatalogueModelFromJson(String str) => GetCatalogueModel.fromJson(json.decode(str));

String getCatalogueModelToJson(GetCatalogueModel data) => json.encode(data.toJson());

class GetCatalogueModel {
  final String? message;
  final CatalogueModel? data;

  GetCatalogueModel({
    this.message,
    this.data,
  });

  factory GetCatalogueModel.fromJson(Map<String, dynamic> json) => GetCatalogueModel(
        message: json["message"],
        data: json["data"] == null ? null : CatalogueModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class CatalogueModel {
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<Catalogue>? catalogues;

  CatalogueModel({
    this.totalCount,
    this.page,
    this.totalPages,
    this.catalogues,
  });

  factory CatalogueModel.fromJson(Map<String, dynamic> json) => CatalogueModel(
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        catalogues: json["catalogues"] == null ? [] : List<Catalogue>.from(json["catalogues"]!.map((x) => Catalogue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "catalogues": catalogues == null ? [] : List<dynamic>.from(catalogues!.map((x) => x.toJson())),
      };
}

class Catalogue {
  final String? id;
  String? name;
  final List<String>? inventoryIds;
  final String? createdBy;

  Catalogue({
    this.id,
    this.name,
    this.inventoryIds,
    this.createdBy,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        id: json["_id"],
        name: json["name"],
        inventoryIds: json["inventory_ids"] == null ? [] : List<String>.from(json["inventory_ids"]!.map((x) => x)),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "inventory_ids": inventoryIds == null ? [] : List<dynamic>.from(inventoryIds!.map((x) => x)),
        "created_by": createdBy,
      };
}
