library;

import 'package:get/get.dart';

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

///* AUTH SCREEN TYPES
enum AuthScreenType { login, forgotPassword }

///* USE IN AUTH FLOW API
enum APIPlatform { app, web }

///* BORDER RADIUS SIDE
enum BorderRadiusSide { topRight, bottomRight, bottomLeft, topLeft }

///* RADIO BUTTON TYPES
enum RadioButtonType { outline, filled, done }

///* User Role
/*enum UserRole {
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
}*/

///* DATE RANGE TYPES
enum DateRangeType { custom, today, yesterday, thisWeek, thisMonth, thisYear, lastWeek, lastMonth, last6Month, lastYear, more }

/// Order Status
enum OrderStatus { all, pending, accepted, rejected, completed }

///* FILTER TYPES
enum FilterType { range, available, gender, brand, kt, delivery, tag, collection, complexity, subComplexity, bestSeller, latestDesign }
