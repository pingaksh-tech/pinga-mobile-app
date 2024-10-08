// To parse this JSON data, do
//
//     final getRetailerModel = getRetailerModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetRetailerModel getRetailerModelFromJson(String str) =>
    GetRetailerModel.fromJson(json.decode(str));

String getRetailerModelToJson(GetRetailerModel data) =>
    json.encode(data.toJson());

class GetRetailerModel {
  final String? message;
  final GetRetailerDataModel? data;

  GetRetailerModel({
    this.message,
    this.data,
  });

  factory GetRetailerModel.fromJson(Map<String, dynamic> json) =>
      GetRetailerModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : GetRetailerDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetRetailerDataModel {
  final int? filteredCount;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<RetailerModel>? retailers;

  GetRetailerDataModel({
    this.filteredCount,
    this.totalCount,
    this.page,
    this.totalPages,
    this.retailers,
  });

  factory GetRetailerDataModel.fromJson(Map<String, dynamic> json) =>
      GetRetailerDataModel(
        filteredCount: json["filteredCount"],
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        retailers: json["retailers"] == null
            ? []
            : List<RetailerModel>.from(
                json["retailers"]!.map((x) => RetailerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filteredCount": filteredCount,
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "retailers": retailers == null
            ? []
            : List<dynamic>.from(retailers!.map((x) => x.toJson())),
      };
}

class RetailerModel {
  final RxString? id;
  final String? firstName;
  final String? lastName;
  final String? businessName;
  final String? email;
  final String? phone;
  final String? landline;
  final String? address;
  final String? city;
  final String? state;
  final bool? status;
  final String? createdBy;
  final String? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  RetailerModel({
    this.id,
    this.firstName,
    this.lastName,
    this.businessName,
    this.email,
    this.phone,
    this.landline,
    this.address,
    this.city,
    this.state,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RetailerModel.fromJson(Map<String, dynamic> json) => RetailerModel(
        id: RxString(json["_id"].toString()),
        firstName: json["first_name"],
        lastName: json["last_name"],
        businessName: json["business_name"],
        email: json["email"],
        phone: json["phone"],
        landline: json["landline"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.obs,
        "first_name": firstName,
        "last_name": lastName,
        "business_name": businessName,
        "email": email,
        "phone": phone,
        "landline": landline,
        "address": address,
        "city": city,
        "state": state,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
