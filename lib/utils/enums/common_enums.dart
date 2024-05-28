library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../exports.dart';

///! WARNINGS:
///* =>> Don't change any enum INDEX (Positions)

/// ***********************************************************************************
/// *                                  LOCAL ENUMS                                    *
/// ***********************************************************************************

///* APPLICATION ENVIRONMENT TYPES - USE IN API STATES
enum EnvironmentType { local, development, staging, production, custom }

///* APPLICATION NOTIFICATION STATES
enum NotificationState { open, background, kill }

///* APP BUTTON VARIANTS
enum ButtonType { elevated, gradient, outline }

///* IMAGE OR ICON ALIGNS IN APP BUTTON
enum ImageAlign { start, startTitle, endTitle, end }

///* APP TEXT-FORM-FIELD VARIANTS
enum TextFieldType { normal, date, time, search }

///* CUSTOM SNACK-BAR TYPE
enum SnackbarType { complete, wrong, warning }

enum MyDeviceType {
  android(label: 'Android'),
  fuchsia(label: 'Fuchsia'),
  ios(label: 'iOS'),
  linux(label: 'Linux'),
  macos(label: 'Macos'),
  windows(label: 'Windows');

  final String label;

  const MyDeviceType({required this.label});

  static MyDeviceType fromString(String value) {
    return MyDeviceType.values.firstWhereOrNull((e) => e.name == value) ?? MyDeviceType.android;
  }
}

/// ***********************************************************************************
/// *                                THIS PROJECT ENUMS                               *
/// ***********************************************************************************

///* LOGIN TYPES
enum LoginType { apple, google, facebook }

///* USE IN AUTH FLOW API
enum APIPlatform { app, web }

///* NAVBAR SCREEN TYPE
enum NavBarScreenType { register, transactions, inventory, reports, settings }

///* BORDER RADIUS SIDE
enum BorderRadiusSide { topRight, bottomRight, bottomLeft, topLeft }

///* LOGIN SCREEN TYPES
enum LoginScreenType { login, forgotPassword, sendLink }

///* RADIO BUTTON TYPES
enum RadioButtonType { outline, filled, done }

///* TRANSACTION STATUS TYPE
enum TransactionStatusType { allStatus, completed, hold, returned }

/* enum TransactionStatusType {
  completed(id: 0, slug: 'completed', label: 'Completed', color: Color(0xFF08AC53)),
  hold(id: 1, slug: 'hold', label: 'Hold', color: Color(0xFFF8961E)),
  returned(id: 2, slug: 'returned', label: 'Returned', color: Color(0xFFE73B4C));

  final int id;
  final String label;
  final Color color;
  final String slug;

  const TransactionStatusType({
    required this.id,
    required this.label,
    required this.color,
    required this.slug,
  });

  static TransactionStatusType fromId(int id) {
    return TransactionStatusType.values.firstWhere((e) => e.id == id);
  }

  static TransactionStatusType fromSlug(String slug) {
    return TransactionStatusType.values.firstWhere((e) => e.slug == slug);
  }
} */

///* Transaction Source TYPES
enum TransactionSourceType {
  eStore(id: 0, slug: 'eStore', label: 'E-Store', color: Color(0xFF08AC53)),
  onlineStore(id: 1, slug: 'onlineStore', label: 'Online Store', color: Color(0xFF08AC53)),
  store(id: 2, slug: 'store', label: 'Store', color: Color(0xFFE73B4C));

  final int id;
  final String label;
  final Color color;
  final String slug;

  const TransactionSourceType({
    required this.id,
    required this.label,
    required this.color,
    required this.slug,
  });

  static TransactionSourceType fromId(int id) {
    return TransactionSourceType.values.firstWhere((e) => e.id == id);
  }

  static TransactionSourceType fromSlug(String slug) {
    return TransactionSourceType.values.firstWhere((e) => e.slug == slug);
  }
}

///* User Role
enum UserRole {
  allRole(id: 0, slug: 'all', label: 'All Role', color: Color(0xFFFFFFFF)),
  clerk(id: 1, slug: 'clerk', label: 'Clerk', color: Color(0xFFCC822B)),
  manager(id: 2, slug: 'manager', label: 'Manager', color: Color(0xFF4B2BCC));

  final int id;
  final String label;
  final Color color;
  final String slug;

  const UserRole({
    required this.id,
    required this.label,
    required this.color,
    required this.slug,
  });

  static UserRole fromId(int id) {
    return UserRole.values.firstWhere((e) => e.id == id);
  }

  static UserRole fromSlug(String slug) {
    return UserRole.values.firstWhere((e) => e.slug == slug);
  }
}

///* DATE RANGE TYPES
enum DateRangeType { custom, today, yesterday, thisWeek, thisMonth, thisYear, lastWeek, lastMonth, last6Month, lastYear, more }

enum SettingTabs {
  users(id: 0, label: "Users", slug: "users", icon: AppAssets.usersTabIcon),
  location(id: 1, label: "Location", slug: "location", icon: AppAssets.locationTabIcon),
  allDevice(id: 2, label: "All Device", slug: "allDevice", icon: AppAssets.allDeviceTabIcon),
  thisDevice(id: 3, label: "This Device", slug: "thisDevice", icon: AppAssets.thisDeviceTabIcon),
  integration(id: 4, label: "Integration", slug: "integration", icon: AppAssets.integrationTabIcon);

  final int id;
  final String label;
  final String slug;
  final String icon;

  const SettingTabs({
    required this.id,
    required this.label,
    required this.slug,
    required this.icon,
  });

  static SettingTabs fromId(int id) {
    return SettingTabs.values.firstWhere((e) => e.id == id);
  }

  static SettingTabs fromSlug(String slug) {
    return SettingTabs.values.firstWhere((e) => e.slug == slug);
  }

  static bool isValidSlug(String slug) {
    return SettingTabs.values.any((e) => e.slug == slug);
  }
}
