import 'dart:convert';

GetWatchlistModel getWatchlistModelFromJson(String str) => GetWatchlistModel.fromJson(json.decode(str));

String getWatchlistModelToJson(GetWatchlistModel data) => json.encode(data.toJson());

class GetWatchlistModel {
  final bool? success;
  final String? message;
  final List<WatchlistModel>? data;

  GetWatchlistModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetWatchlistModel.fromJson(Map<String, dynamic> json) => GetWatchlistModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<WatchlistModel>.from(json["data"]!.map((x) => WatchlistModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WatchlistModel {
  final String? id;
  final String? name;
  final int? noOfItem;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WatchlistModel({
    this.id,
    this.name,
    this.noOfItem,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) => WatchlistModel(
        id: json["id"],
        name: json["name"],
        noOfItem: json["no_of_item"],
        createdBy: json["created_by"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "no_of_item": noOfItem,
        "created_by": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
