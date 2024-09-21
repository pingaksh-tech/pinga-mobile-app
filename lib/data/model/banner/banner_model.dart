// To parse this JSON data, do
//
//     final getBannersModel = getBannersModelFromJson(jsonString);

import 'dart:convert';

GetBannersModel getBannersModelFromJson(String str) => GetBannersModel.fromJson(json.decode(str));

String getBannersModelToJson(GetBannersModel data) => json.encode(data.toJson());

class GetBannersModel {
  final String? message;
  final List<BannerModel>? banners;

  GetBannersModel({
    this.message,
    this.banners,
  });

  factory GetBannersModel.fromJson(Map<String, dynamic> json) => GetBannersModel(
        message: json["message"],
        banners: json["data"] == null ? [] : List<BannerModel>.from(json["data"]!.map((x) => BannerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class BannerModel {
  final String? id;
  final String? bannerImage;

  BannerModel({
    this.id,
    this.bannerImage,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["_id"],
        bannerImage: json["banner_image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "banner_image": bannerImage,
      };
}
