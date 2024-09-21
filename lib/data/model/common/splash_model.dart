// To parse this JSON data, do
//
//     final getSplashModel = getSplashModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

GetSplashModel getSplashModelFromJson(String str) => GetSplashModel.fromJson(json.decode(str));

String getSplashModelToJson(GetSplashModel data) => json.encode(data.toJson());

class GetSplashModel {
  final bool? success;
  final String? message;
  final SplashDataModel? data;

  GetSplashModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetSplashModel.fromJson(Map<String, dynamic> json) => GetSplashModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : SplashDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class SplashDataModel {
  final String? profileBanner;
  final AppConfigData? appConfigData;
  final List<String>? gender;
  final List<CollectionModel>? collections;
  final List<String>? productionNames;
  final List<String>? deliveries;
  final List<CategoryWiseSize>? categoryWiseSizes;
  final List<MetalModel>? metals;
  final List<DiamondModel>? diamonds;
  final List<String>? orderType;

  SplashDataModel({
    this.appConfigData,
    this.collections,
    this.gender,
    this.productionNames,
    this.deliveries,
    this.categoryWiseSizes,
    this.metals,
    this.diamonds,
    this.orderType,
    this.profileBanner,
  });

  factory SplashDataModel.fromJson(Map<String, dynamic> json) => SplashDataModel(
        profileBanner: json["profileBanner"],
        appConfigData: json["appMaintenance"] == null ? null : AppConfigData.fromJson(json["appMaintenance"]),
        collections: json["collections"] == null ? [] : List<CollectionModel>.from(json["collections"]!.map((x) => CollectionModel.fromJson(x))),
        gender: json["gender"] == null ? [] : List<String>.from(json["gender"]!.map((x) => x)),
        productionNames: json["production_names"] == null ? [] : List<String>.from(json["production_names"]!.map((x) => x)),
        deliveries: json["deliveries"] == null ? [] : List<String>.from(json["deliveries"]!.map((x) => x)),
        categoryWiseSizes: json["categoryWiseSize"] == null ? [] : List<CategoryWiseSize>.from(json["categoryWiseSize"]!.map((x) => CategoryWiseSize.fromJson(x))),
        metals: json["metals"] == null ? [] : List<MetalModel>.from(json["metals"]!.map((x) => MetalModel.fromJson(x))),
        diamonds: json["diamonds"] == null ? [] : List<DiamondModel>.from(json["diamonds"]!.map((x) => DiamondModel.fromJson(x))),
        orderType: json["orderType"] == null ? [] : List<String>.from(json["orderType"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "profileBanner": profileBanner,
        "appMaintenance": appConfigData?.toJson(),
        "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x.toJson())),
        "gender": gender == null ? [] : List<dynamic>.from(gender!.map((x) => x)),
        "production_names": productionNames == null ? [] : List<dynamic>.from(productionNames!.map((x) => x)),
        "deliveries": deliveries == null ? [] : List<dynamic>.from(deliveries!.map((x) => x)),
        "categoryWiseSize": categoryWiseSizes == null ? [] : List<dynamic>.from(categoryWiseSizes!.map((x) => x.toJson())),
        "metals": metals == null ? [] : List<dynamic>.from(metals!.map((x) => x.toJson())),
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "orderType": orderType == null ? [] : List<dynamic>.from(orderType!.map((x) => x)),
      };
}

class AppConfigData {
  final String? id;
  final AppMaintenanceModel? appMaintenance;
  final List<AppConfig>? appConfigs;
  final List<VersionModel>? versions;

  AppConfigData({
    this.id,
    this.appMaintenance,
    this.appConfigs,
    this.versions,
  });

  factory AppConfigData.fromJson(Map<String, dynamic> json) => AppConfigData(
        id: json["_id"],
        appMaintenance: json["app-maintenance"] == null ? null : AppMaintenanceModel.fromJson(json["app-maintenance"]),
        appConfigs: json["app_config"] == null ? [] : List<AppConfig>.from(json["app_config"]!.map((x) => AppConfig.fromJson(x))),
        versions: json["versions"] == null ? [] : List<VersionModel>.from(json["versions"]!.map((x) => VersionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "app-maintenance": appMaintenance?.toJson(),
        "app_config": appConfigs == null ? [] : List<dynamic>.from(appConfigs!.map((x) => x.toJson())),
        "versions": versions == null ? [] : List<dynamic>.from(versions!.map((x) => x.toJson())),
      };
}

class AppConfig {
  final String? id;
  final bool? defaultConfig;
  final AppConfigDetails? appConfigDetails;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppConfig({
    this.id,
    this.defaultConfig,
    this.appConfigDetails,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        id: json["_id"],
        defaultConfig: json["default_config"],
        appConfigDetails: json["app_config"] == null ? null : AppConfigDetails.fromJson(json["app_config"]),
        type: json["type"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "default_config": defaultConfig,
        "app_config": appConfigDetails?.toJson(),
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AppConfigDetails {
  final String? primary;
  final String? themeMode;
  final String? privacy;
  final String? terms;
  final String? aboutUs;
  final String? playStoreLink;
  final String? appStoreLink;
  final String? contactUs;
  final String? contactMobileNumber;
  final String? contactEmailId;

  AppConfigDetails({
    this.primary,
    this.themeMode,
    this.privacy,
    this.terms,
    this.aboutUs,
    this.playStoreLink,
    this.appStoreLink,
    this.contactUs,
    this.contactMobileNumber,
    this.contactEmailId,
  });

  factory AppConfigDetails.fromJson(Map<String, dynamic> json) => AppConfigDetails(
        primary: json["primary"],
        themeMode: json["theme_mode"],
        privacy: json["privacy"],
        terms: json["terms"],
        aboutUs: json["about_us"],
        playStoreLink: json["play_store_link"],
        appStoreLink: json["app_store_link"],
        contactUs: json["contact_us"],
        contactMobileNumber: json["contact_mobile_number"],
        contactEmailId: json["contact_email_id"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "theme_mode": themeMode,
        "privacy": privacy,
        "terms": terms,
        "about_us": aboutUs,
        "play_store_link": playStoreLink,
        "app_store_link": appStoreLink,
        "contact_us": contactUs,
        "contact_mobile_number": contactMobileNumber,
        "contact_email_id": contactEmailId,
      };
}

class AppMaintenanceModel {
  final bool? underMaintenance;
  final String? title;
  final String? message;

  AppMaintenanceModel({
    this.underMaintenance,
    this.title,
    this.message,
  });

  factory AppMaintenanceModel.fromJson(Map<String, dynamic> json) => AppMaintenanceModel(
        underMaintenance: json["under_maintenance"],
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "under_maintenance": underMaintenance,
        "title": title,
        "message": message,
      };
}

class VersionModel {
  final String? id;
  final String? version;
  final int? versionNum;
  final bool? forceUpdate;
  final bool? softUpdate;
  final bool? maintenance;
  final String? maintenanceMessage;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VersionModel({
    this.id,
    this.version,
    this.versionNum,
    this.forceUpdate,
    this.softUpdate,
    this.maintenance,
    this.maintenanceMessage,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        id: json["_id"],
        version: json["version"],
        versionNum: json["versionNum"],
        forceUpdate: json["force_update"],
        softUpdate: json["soft_update"],
        maintenance: json["maintenance"],
        maintenanceMessage: json["maintenance_msg"],
        type: json["type"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "version": version,
        "versionNum": versionNum,
        "force_update": forceUpdate,
        "soft_update": softUpdate,
        "maintenance": maintenance,
        "maintenance_msg": maintenanceMessage,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class CategoryWiseSize {
  final RxString? id;
  final String? name;
  final List<DiamondModel>? data;

  CategoryWiseSize({
    this.id,
    this.name,
    this.data,
  });

  factory CategoryWiseSize.fromJson(Map<String, dynamic> json) => CategoryWiseSize(
        id: RxString(json["_id"].toString()),
        name: json["name"],
        data: json["data"] == null ? [] : List<DiamondModel>.from(json["data"]!.map((x) => DiamondModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id?.value,
        "name": name,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DiamondModel {
  RxString? id;
  final String? name;
  final String? shortName;

  DiamondModel({
    this.id,
    this.name,
    this.shortName,
  });

  factory DiamondModel.fromJson(Map<String, dynamic> json) => DiamondModel(
        id: RxString(json["_id"].toString()),
        name: json["name"],
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.obs,
        "name": name,
        "short_name": shortName,
      };
}

class MetalModel {
  final RxString? id;
  final String? name;
  final String? metalCarat;
  final String? metalColor;
  final String? shortName;

  MetalModel({
    this.id,
    this.name,
    this.metalCarat,
    this.metalColor,
    this.shortName,
  });

  factory MetalModel.fromJson(Map<String, dynamic> json) => MetalModel(
        id: RxString(json["_id"].toString()),
        name: json["name"],
        metalCarat: json["metal_carat"],
        metalColor: json["metal_color"],
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.obs,
        "name": name,
        "metal_carat": metalCarat,
        "metal_color": metalColor,
        "short_name": shortName,
      };
}

class GenderModel {
  final String? male;
  final String? female;
  final String? unisex;

  GenderModel({
    this.male,
    this.female,
    this.unisex,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        male: json["MALE"],
        female: json["FEMALE"],
        unisex: json["UNISEX"],
      );

  Map<String, dynamic> toJson() => {
        "MALE": male,
        "FEMALE": female,
        "UNISEX": unisex,
      };
}

class CollectionModel {
  final String? id;
  final String? name;
  final int? count;

  CollectionModel({
    this.id,
    this.name,
    this.count,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
        id: json["_id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "count": count,
      };
}
