import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/model/user/user_model.dart';
import '../exports.dart';

class LocalStorage {
  static String defaultStorageKey = "GetStorage";
  static String deviceStorageKey = "DeviceStorageKey";

  /// Init all GetStorages
  static Future<void> init() async {
    await GetStorage.init(defaultStorageKey);
    await GetStorage.init(deviceStorageKey);
  }

  //* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-> Default Storage <=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= *//
  static GetStorage prefs = GetStorage(defaultStorageKey);

  static const String _userModel = "USER-MODEL";
  static const String _baseUrl = "base_url";
  static const String _accessToken = "access_token";
  static const String _refreshToken = "refreshToken";
  static const String _primaryColor = "primary_color";
  static const String _secondaryColor = "secondary_color";
  static const String _localeLanguage = "locale_language";
  static const String _localeLanguageCode = "locale_language_code";
  static const String _currencyType = "CURRENCY-TYPE";
  static const String _currencySymbol = "CURRENCY-SYMBOL";

  /// User login token
  static set accessToken(String? value) => prefs.write(_accessToken, value);
  static String get accessToken => prefs.read(_accessToken) ?? "";

  static set refreshToken(String? value) => prefs.write(_refreshToken, value);
  static String get refreshToken => prefs.read(_refreshToken) ?? "";

  /// API base local URL
  static set baseUrl(String? value) => prefs.write(_baseUrl, value);
  static String get baseUrl => prefs.read(_baseUrl) ?? "";

  /// Primary color
  static set primaryColor(Color? value) => prefs.write(_primaryColor, value != null ? AppColors.fromColor(value) : AppColors.primary);
  static Color get primaryColor => prefs.read(_primaryColor) != null ? AppColors.fromHex(prefs.read(_primaryColor)) : AppColors.primary;

  /// Secondary color
  static set secondaryColor(Color? value) => prefs.write(_secondaryColor, value != null ? AppColors.fromColor(value) : AppColors.secondary);
  static Color get secondaryColor => prefs.read(_secondaryColor) != null ? AppColors.fromHex(prefs.read(_secondaryColor)) : AppColors.secondary;

  /// User locale language
  static set localeLanguage(String? value) => prefs.write(_localeLanguage, value);
  static String get localeLanguage => prefs.read(_localeLanguage) ?? "";

  /// User locale language code
  static set localeLanguageCode(String? value) => prefs.write(_localeLanguageCode, value);
  static String get localeLanguageCode => prefs.read(_localeLanguageCode) ?? "";

  /// UserModelData
  /*static set userModelData(UserModelData value) {
    final String encodedValue = jsonEncode(value);
    prefs.write(_userModelData, encodedValue);
  }

  static UserModelData get userModelData {
    final dynamic result = prefs.read(_userModelData);
    return UserModelData.fromJson(json.decode(result));
  }*/

  /// UserModel
  static set userModel(UserModel? userModel) {
    if(userModel!=null) {
      final String encodedValue = jsonEncode(userModel);
      prefs.write(_userModel, encodedValue);
    }
  }

  static UserModel get userModel {
    final dynamic result = prefs.read(_userModel);
    return UserModel.fromJson(json.decode(result));
  }

  /// PermissionModel
  /*  static set permissionModel(PermissionModel value) {
    final String encodedValue = jsonEncode(value);
    prefs.write(_permissionsModel, encodedValue);
  }

  static PermissionModel get permissionModel {
    final dynamic result = prefs.read(_permissionsModel);
    return PermissionModel.fromJson(json.decode(result));
  }*/

  /// ***********************************************************************************
  ///                                      CURRENCY
  /// ***********************************************************************************

  static const String _defaultCurrencyType = "INR", _defaultCurrencySymbol = "₹";
  static RxString currencyType = "".obs, currencySymbol = "".obs;

  static Future setCurrency({String? currencyTYPE, String? currencySYMBOL}) async {
    if (!isValEmpty(currencyTYPE)) {
      await prefs.write(_currencyType, currencyTYPE);
      currencyType.value = prefs.read(_currencyType) ?? _defaultCurrencyType;
    } else {
      currencyType.value = prefs.read(_currencyType) ?? _defaultCurrencyType;
    }
    if (!isValEmpty(currencySYMBOL)) {
      await prefs.write(_currencySymbol, currencySYMBOL);
      currencySymbol.value = prefs.read(_currencySymbol) ?? _defaultCurrencySymbol;
    } else {
      currencySymbol.value = prefs.read(_currencySymbol) ?? _defaultCurrencySymbol;
    }

    printData(key: "currencyType", value: currencyType.value);
    printData(key: "currencySymbol", value: currencySymbol.value);
  }

  /// ***********************************************************************************
  ///                                   Device Storage
  /// ***********************************************************************************

  static GetStorage devicePrefs = GetStorage(deviceStorageKey);

  static const String _deviceID = "device_id";
  static const String _deviceTOKEN = "device_token";
  static const String _deviceTYPE = "device_type";
  static const String _deviceNAME = "device_name";

  /// Device identity
  static String get deviceId => devicePrefs.read(_deviceID) ?? "";

  /// Device FCM token
  static String get deviceToken => devicePrefs.read(_deviceTOKEN) ?? "";

  /// Device type
  static String get deviceType => devicePrefs.read(_deviceTYPE) ?? "";

  /// Device name
  static String get deviceName => devicePrefs.read(_deviceNAME) ?? "";

  //* -=-=-=-=-=-=-=-> Store Device Information <-=-=-=-=-=-=-=- //
  static Future storeDeviceInfo({
    required String deviceID,
    required String deviceTOKEN,
    required String deviceTYPE,
    required String deviceNAME,
  }) async {
    /// Store device identity
    await devicePrefs.write(_deviceID, deviceID);

    /// Store device FCM token
    await devicePrefs.write(_deviceTOKEN, deviceTOKEN);

    /// Store device type
    await devicePrefs.write(_deviceTYPE, deviceTYPE);

    /// Store device name
    await devicePrefs.write(_deviceNAME, deviceNAME);
  }

  //* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-> Common Functions <=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= *//

  //* -=-=-=-=-=-=-=-> Read Local Storage <-=-=-=-=-=-=-=- //
  static Future<void> readDataInfo() async {
    /// SET DEFAULT CURRENCY
    setCurrency();
  }

  //! -=-=-=-=-=-=-=> Clear Local Storage  <-=-=-=-=-=-=-= //
  static Future<void> clearLocalStorage() async {
    await prefs.erase(); //? Prefs Storage Erase
    await devicePrefs.erase(); //? Device Prefs Storage Erase
  }

  static Future<void> printLocalStorageData() async {
    printDate("User Data");

    printData(key: "Access Token", value: accessToken);
    printData(key: "Refresh Token", value: accessToken);

    printDate("Device Permanent Data");

    printData(key: "Device Id", value: deviceId);
    printData(key: "Device Type", value: deviceType);
    printData(key: "Device Name", value: deviceName);
    printData(key: "Device Token", value: deviceToken);
  }
}
