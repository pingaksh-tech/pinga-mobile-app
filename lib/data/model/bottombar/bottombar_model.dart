import 'dart:convert';

import 'package:flutter/material.dart';

BottomBarData bottomBarModelFromJson(String str) => BottomBarData.fromJson(json.decode(str));

String bottomBarModelToJson(BottomBarData data) => json.encode(data.toJson());

class BottomBarData {
  BottomBarData({
    this.children,
  });

  final List<BottomBarModel>? children;

  factory BottomBarData.fromJson(Map<String, dynamic> json) => BottomBarData(
        children: json["children"] == null ? [] : List<BottomBarModel>.from(json["children"]!.map((x) => BottomBarModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}

class BottomBarModel {
  BottomBarModel({
    this.screenName,
    this.screenId,
    this.bottomItem,
    this.screen,
    this.screenWidget,
  });

  final String? screenName;
  final String? screenId;
  final BottomItem? bottomItem;
  final dynamic screen;
  final Widget? screenWidget;

  factory BottomBarModel.fromJson(Map<String, dynamic> json) => BottomBarModel(
        screenName: json["screenName"],
        screenId: json["screenId"],
        bottomItem: json["bottomItem"] == null ? null : BottomItem.fromJson(json["bottomItem"]),
        screen: json["screen"],
        screenWidget: json["screenWidget"],
      );

  Map<String, dynamic> toJson() => {
        "screenName": screenName,
        "screenId": screenId,
        "bottomItem": bottomItem?.toJson(),
        "screen": screen?.toJson(),
        "screenWidget": screenWidget,
      };
}

class BottomItem {
  BottomItem({
    this.selectedIcon,
    this.unselectIcon,
    this.selectedImage,
    this.unselectImage,
    this.selectedSize,
    this.unselectSize,
  });

  final IconData? selectedIcon;
  final IconData? unselectIcon;
  final String? selectedImage;
  final String? unselectImage;
  final double? selectedSize;
  final double? unselectSize;

  factory BottomItem.fromJson(Map<String, dynamic> json) => BottomItem(
        selectedIcon: json["selectedIcon"],
        unselectIcon: json["unselectIcon"] ?? json["selectedIcon"],
        selectedImage: json["selectedImage"],
        unselectImage: json["unselectImage"] ?? json["selectedImage"],
        selectedSize: json["selectedSize"] != null ? double.parse("${json["selectedSize"]}") : null,
        unselectSize: json["unselectSize"] != null ? double.parse("${json["unselectSize"]}") : (json["selectedSize"] != null ? double.parse("${json["selectedSize"]}") : null),
      );

  Map<String, dynamic> toJson() => {
        "selectedIcon": selectedIcon,
        "unselectIcon": unselectIcon ?? selectedIcon,
        "selectedImage": selectedImage,
        "unselectImage": unselectImage,
        "selectedSize": selectedSize,
        "unselectSize": unselectSize,
      };
}
