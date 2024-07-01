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
enum AuthScreenType { login, otpVerification }

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

///* PRODUCT LIST TYPE
enum ProductsListType { normal, watchlist }

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
  range(
    id: 1,
    label: "Range",
    slug: "range",
    icon: AppAssets.rangeSVG,
  ),
  mrp(
    id: 2,
    label: "MRP",
    slug: "mrp",
    icon: AppAssets.mrpSVG,
  ),
  available(
    id: 3,
    label: "Available",
    slug: "available",
    icon: AppAssets.availableSVG,
  ),
  gender(
    id: 4,
    label: "Gender",
    slug: "gender",
    icon: AppAssets.genderSVG,
  ),
  diamond(
    id: 5,
    label: "Diamond",
    slug: "diamond",
    icon: AppAssets.diamondSVg,
  ),
  kt(
    id: 6,
    label: "KT",
    slug: "kt",
    icon: AppAssets.ktSVG,
  ),
  delivery(
    id: 7,
    label: "Delivery",
    slug: "delivery",
    icon: AppAssets.deliveryIcon,
  ),
  production(
    id: 8,
    label: "Production Name",
    slug: "production name",
    icon: AppAssets.productNameSVG,
  ),
  /*  setting(
    id: 9,
    label: "Setting",
    slug: "setting",
    icon: '',
  ), */
  collection(
    id: 10,
    label: "Collection",
    slug: "collection",
    icon: AppAssets.collectionSVG,
  );

  final int id;
  final String label;
  final String slug;
  final String icon;

  const FilterItemType({
    required this.id,
    required this.label,
    required this.slug,
    required this.icon,
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

enum FeedbackType {
  newDesign(
    id: 1,
    slug: "new_design",
    label: "New Design Feedback",
  ),
  appImprovement(
    id: 2,
    slug: "app_improvement",
    label: "App Improvement",
  ),
  orderProcessing(
    id: 3,
    slug: "order_processing",
    label: "Order Processing",
  ),
  areaImprovement(
    id: 4,
    slug: "area_improvement",
    label: "Area Of Improvement",
  );

  final int id;
  final String label;
  final String slug;

  const FeedbackType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static FeedbackType fromId(int id) {
    return FeedbackType.values.firstWhere((e) => e.id == id);
  }

  static FeedbackType fromSlug(String slug) {
    return FeedbackType.values.firstWhere((e) => e.slug == slug);
  }
}
