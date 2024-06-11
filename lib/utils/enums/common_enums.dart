library;

import 'dart:ui';

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
// enum FilterType { range, available, gender, diamond, kt, delivery, production, collection, complexity, subComplexity, bestSeller, latestDesign }

///* SIZE-COLOR SELECTOR BUTTON SIZE TYPE
enum SizeColorSelectorButtonType { small, medium, large }

///* PRODUCT TILE TYPE
enum ProductTileType { grid, list, variant, cartTile }

///* SELECTABLE ITEM TYPE
enum SelectableItemType {
  size(
    id: 0,
    colors: Color(0xFF221361),
    label: "Size",
    slug: "size",
    icon: AppAssets.ringSizeIcon,
    selectedIcon: AppAssets.ringSizeIcon,
  ),
  color(
    id: 1,
    colors: Color(0xFF221361),
    label: "Color",
    slug: "colors",
    icon: AppAssets.colorIcon,
    selectedIcon: AppAssets.colorIcon,
  ),
  diamond(
    id: 2,
    colors: Color(0xFF221361),
    label: "Ruby",
    slug: "diamond",
    icon: AppAssets.diamondIcon,
    selectedIcon: AppAssets.diamondIcon,
  ),
  remarks(
    id: 3,
    colors: Color(0xFF221361),
    label: "Remark",
    slug: "remark",
    icon: AppAssets.remarkOutlineIcon,
    selectedIcon: AppAssets.remarkFilledIcon,
  ),
  stock(
    id: 4,
    colors: Color(0xFF221361),
    label: "Stock",
    slug: "stock",
    icon: AppAssets.stockIcon,
    selectedIcon: AppAssets.stockIcon,
  );

  final int id;
  final String label;
  final Color colors;
  final String slug;
  final String icon;
  final String? selectedIcon;

  const SelectableItemType({
    required this.id,
    required this.label,
    required this.colors,
    required this.slug,
    required this.icon,
    this.selectedIcon,
  });

  static SelectableItemType fromId(int id) {
    return SelectableItemType.values.firstWhere((e) => e.id == id);
  }

  static SelectableItemType fromSlug(String slug) {
    return SelectableItemType.values.firstWhere((e) => e.slug == slug);
  }
}

///* FILTER ITEM TYPE
enum FilterItemType {
  rang(
    id: 1,
    label: "Range",
    slug: "range",
  ),
  available(
    id: 2,
    label: "Available",
    slug: "available",
  ),
  gender(
    id: 3,
    label: "Gender",
    slug: "gender",
  ),
  diamond(
    id: 4,
    label: "Diamond",
    slug: "diamond",
  ),
  kt(
    id: 5,
    label: "KT",
    slug: "kt",
  ),
  delivery(
    id: 6,
    label: "Delivery",
    slug: "delivery",
  ),
  production(
    id: 7,
    label: "Production Name",
    slug: "production name",
  ),
  /*  setting(
    id: 8,
    label: "Setting",
    slug: "setting",
  ), */
  collection(
    id: 9,
    label: "Collection",
    slug: "collection",
  );

  final int id;
  final String label;
  final String slug;

  const FilterItemType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static FilterItemType fromId(int id) {
    return FilterItemType.values.firstWhere((e) => e.id == id);
  }

  static FilterItemType fromSlug(String slug) {
    return FilterItemType.values.firstWhere((e) => e.slug == slug);
  }
}

///* ORDER FILTER ITEM TYPE
enum OrderFilterType {
  type(id: 1, label: "Type", slug: "type"),
  date(id: 1, label: "Date", slug: "date");

  final int id;
  final String label;
  final String slug;

  const OrderFilterType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static OrderFilterType fromId(int id) {
    return OrderFilterType.values.firstWhere((e) => e.id == id);
  }

  static OrderFilterType fromSlug(String slug) {
    return OrderFilterType.values.firstWhere((e) => e.slug == slug);
  }
}
