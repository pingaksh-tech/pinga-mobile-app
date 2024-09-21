// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  final String? message;
  final UserModel? data;

  GetUserModel({
    this.message,
    this.data,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}
