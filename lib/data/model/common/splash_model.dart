import 'dart:convert';
import 'dart:io';

GetSplashDataModel getSplashDataModelFromJson(String str) => GetSplashDataModel.fromJson(json.decode(str));

String getSplashDataModelToJson(GetSplashDataModel data) => json.encode(data.toJson());

class GetSplashDataModel {
  bool? success;
  String? message;
  Data? data;

  GetSplashDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetSplashDataModel.fromJson(Map<String, dynamic> json) => GetSplashDataModel(
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
  MaintenanceModel? maintenance;
  List<AppConfigModel>? appConfigs;
  List<VersionModel>? versions;

  Data({
    this.maintenance,
    this.appConfigs,
    this.versions,
  });

  static String platformSlug = Platform.isAndroid ? "android" : "ios";

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        maintenance: json["app-maintenance"] == null ? null : MaintenanceModel.fromJson(json["app-maintenance"]),
        appConfigs: json["app_config"] == null ? [] : List<AppConfigModel>.from(json["app_config"]!.map((x) => AppConfigModel.fromJson(x))),
        versions: json[platformSlug] == null ? [] : List<VersionModel>.from(json[platformSlug]!.map((x) => VersionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "app-maintenance": maintenance?.toJson(),
        "app_config": appConfigs == null ? [] : List<dynamic>.from(appConfigs!.map((x) => x.toJson())),
        platformSlug: versions == null ? [] : List<dynamic>.from(versions!.map((x) => x.toJson())),
      };
}

class MaintenanceModel {
  bool? underMaintenance;
  String? title;
  String? message;

  MaintenanceModel({
    this.underMaintenance,
    this.title,
    this.message,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) => MaintenanceModel(
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
  String? id;
  String? version;
  bool? forceUpdate;
  bool? softUpdate;
  bool? maintenance;
  String? maintenanceMessage;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  VersionModel({
    this.id,
    this.version,
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
        "force_update": forceUpdate,
        "soft_update": softUpdate,
        "maintenance": maintenance,
        "maintenance_msg": maintenanceMessage,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AppConfigModel {
  String? id;
  bool? defaultConfig;
  AppConfigDetails? appConfig;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppConfigModel({
    this.id,
    this.defaultConfig,
    this.appConfig,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => AppConfigModel(
        id: json["_id"],
        defaultConfig: json["default_config"],
        appConfig: json["app_config"] == null ? null : AppConfigDetails.fromJson(json["app_config"]),
        type: json["type"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "default_config": defaultConfig,
        "app_config": appConfig?.toJson(),
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AppConfigDetails {
  String? primary;
  String? themeMode;
  String? privacy;
  String? terms;
  String? contactUs;
  String? aboutUs;
  String? contactMobileNumber;
  String? contactEmailID;

  String? playStoreLink;
  String? appStoreLink;

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
    this.contactEmailID,
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
        contactEmailID: json["contact_email_id"],
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
        "contact_email_id": contactEmailID,
      };
}
