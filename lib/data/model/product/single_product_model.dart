import 'dart:convert';

import 'package:get/get.dart';

import 'products_model.dart';

GetSingleProductModel getSignleProductModelFromJson(String str) => GetSingleProductModel.fromJson(json.decode(str));

String getSignleProductModelToJson(GetSingleProductModel data) => json.encode(data.toJson());

class GetSingleProductModel {
  final String? message;
  final SingleProductModel? data;

  GetSingleProductModel({
    this.message,
    this.data,
  });

  factory GetSingleProductModel.fromJson(Map<String, dynamic> json) => GetSingleProductModel(
        message: json["message"],
        data: json["data"] == null ? null : SingleProductModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class SingleProductModel {
  final String? subCategoryId;
  final String? sizeId;
  final String? metalId;
  final int? cartQuantity;
  final num? extraMetalWeight;
  final bool? isWishList;
  final bool? isDiamondMultiple;
  final List<String>? inventoryImages;
  final PriceBreaking? priceBreaking;
  final ProductInfo? productInfo;
  final List<DiamondListModel>? diamonds;
  final List<InventoryModel>? familyProducts;

  SingleProductModel({
    this.subCategoryId,
    this.inventoryImages,
    this.priceBreaking,
    this.productInfo,
    this.diamonds,
    this.familyProducts,
    this.sizeId,
    this.metalId,
    this.cartQuantity,
    this.extraMetalWeight,
    this.isWishList,
    this.isDiamondMultiple,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        cartQuantity: json["cartQty"],
        extraMetalWeight: json["extra_metal_weight"],
        isWishList: json["isWishList"],
        isDiamondMultiple: json["isDiamondMultiple"],
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]!.map((x) => x)),
        priceBreaking: json["price_breaking"] == null ? null : PriceBreaking.fromJson(json["price_breaking"]),
        productInfo: json["product_info"] == null ? null : ProductInfo.fromJson(json["product_info"]),
        diamonds: json["diamonds"] == null ? [] : List<DiamondListModel>.from(json["diamonds"]!.map((x) => DiamondListModel.fromJson(x))),
        familyProducts: json["family_products"] == null ? [] : List<InventoryModel>.from(json["family_products"]!.map((x) => InventoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_category_id": subCategoryId,
        "size_id": sizeId,
        "metal_id": metalId,
        "cartQty": cartQuantity,
        "isWishList": isWishList,
        "isDiamondMultiple": isDiamondMultiple,
        "extra_metal_weight": extraMetalWeight,
        "inventory_images": inventoryImages == null ? [] : List<dynamic>.from(inventoryImages!.map((x) => x)),
        "price_breaking": priceBreaking?.toJson(),
        "product_info": productInfo?.toJson(),
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "family_products": familyProducts == null ? [] : List<dynamic>.from(familyProducts!.map((x) => x)),
      };
}

class PriceBreaking {
  final Metal? metal;
  final PriceBreakingDiamond? diamond;
  final Other? other;
  RxNum? total;

  PriceBreaking({
    this.metal,
    this.diamond,
    this.other,
    this.total,
  });

  factory PriceBreaking.fromJson(Map<String, dynamic> json) => PriceBreaking(
        metal: json["metal"] == null ? null : Metal.fromJson(json["metal"]),
        diamond: json["diamond"] == null ? null : PriceBreakingDiamond.fromJson(json["diamond"]),
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        total: json["total"] == null ? null : RxNum(num.tryParse(json["total"].toString()) ?? 0),
      );

  Map<String, dynamic> toJson() => {
        "metal": metal?.toJson(),
        "diamond": diamond?.toJson(),
        "other": other?.toJson(),
        "total": total?.value,
      };
}

class PriceBreakingDiamond {
  double? diamondWeight;
  num? diamondPrice;

  PriceBreakingDiamond({
    this.diamondWeight,
    this.diamondPrice,
  });

  factory PriceBreakingDiamond.fromJson(Map<String, dynamic> json) => PriceBreakingDiamond(
        diamondWeight: json["diamond_weight"]?.toDouble(),
        diamondPrice: json["diamond_price"],
      );

  Map<String, dynamic> toJson() => {
        "diamond_weight": diamondWeight,
        "diamond_price": diamondPrice,
      };
}

class Metal {
  num? metalWeight;
  num? pricePerGram;
  num? metalPrice;

  Metal({
    this.metalWeight,
    this.pricePerGram,
    this.metalPrice,
  });

  factory Metal.fromJson(Map<String, dynamic> json) => Metal(
        metalWeight: json["metal_weight"],
        pricePerGram: json["price_per_gram"],
        metalPrice: json["metal_price"],
      );

  Map<String, dynamic> toJson() => {
        "metal_weight": metalWeight,
        "price_per_gram": pricePerGram,
        "metal_price": metalPrice,
      };
}

class Other {
  num? manufacturingPrice;

  Other({
    this.manufacturingPrice,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        manufacturingPrice: json["manufacturing_price"],
      );

  Map<String, dynamic> toJson() => {
        "manufacturing_price": manufacturingPrice,
      };
}

class ProductInfo {
  final String? metal;
  final String? karatage;
  final num? metalWt;
  final String? category;
  final List<dynamic>? collection;
  final String? approxDelivery;

  ProductInfo({
    this.metal,
    this.karatage,
    this.metalWt,
    this.category,
    this.collection,
    this.approxDelivery,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        metal: json["Metal"],
        karatage: json["Karatage"],
        metalWt: json["Metal Wt"],
        category: json["Category"],
        collection: json["Collection"] == null ? [] : List<dynamic>.from(json["Collection"]!.map((x) => x)),
        approxDelivery: json["approx_delivery"],
      );

  Map<String, dynamic> toJson() => {
        "Metal": metal,
        "Karatage": karatage,
        "Metal Wt": metalWt,
        "Category": category,
        "Collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x)),
        "approx_delivery": approxDelivery,
      };
}
