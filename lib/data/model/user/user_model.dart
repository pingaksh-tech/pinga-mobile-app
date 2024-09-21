// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  final bool? success;
  final String? message;
  final Data? data;

  UserDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
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
  final UserModel? user;
  final Tokens? tokens;

  Data({
    this.user,
    this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class UserModel {
  final dynamic userImage;
  final dynamic address;
  final dynamic gstNo;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final int? otp;
  final RoleId? roleId;
  final bool? status;
  final String? refreshToken;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserModel({
    this.userImage,
    this.address,
    this.gstNo,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.otp,
    this.roleId,
    this.status,
    this.refreshToken,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userImage: json["user_image"],
        address: json["address"],
        gstNo: json["gst_no"],
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        otp: json["otp"],
        roleId: json["role_id"] == null ? null : RoleId.fromJson(json["role_id"]),
        status: json["status"],
        refreshToken: json["refresh_token"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_image": userImage,
        "address": address,
        "gst_no": gstNo,
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "otp": otp,
        "role_id": roleId?.toJson(),
        "status": status,
        "refresh_token": refreshToken,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class RoleId {
  final String? id;
  final String? name;
  final int? v;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final bool? status;
  final DateTime? updatedAt;

  RoleId({
    this.id,
    this.name,
    this.v,
    this.createdAt,
    this.deletedAt,
    this.status,
    this.updatedAt,
  });

  factory RoleId.fromJson(Map<String, dynamic> json) => RoleId(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Tokens {
  final String? accessToken;
  final String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
