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
  final String? inventoryId;
  final String? sizeId;
  final String? metalId;
  int? cartQuantity;
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
    this.inventoryId,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
        inventoryId: json["_id"],
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        cartQuantity: json["cartQty"].runtimeType == int ? json["cartQty"] : 0,
        extraMetalWeight: num.tryParse(json["extra_metal_weight"].toString()) ?? 0,
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
        "_id": inventoryId,
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
  final ManufacturingPrice? manufacturingPrice;
  final ColourStone? colourStone;
  final Pearl? pearl;
  final Mino? mino;
  final Other? other;
  RxNum? total;

  PriceBreaking({
    this.metal,
    this.diamond,
    this.manufacturingPrice,
    this.colourStone,
    this.pearl,
    this.mino,
    this.other,
    this.total,
  });

  factory PriceBreaking.fromJson(Map<String, dynamic> json) => PriceBreaking(
        metal: json["metal"] == null ? null : Metal.fromJson(json["metal"]),
        diamond: json["diamond"] == null ? null : PriceBreakingDiamond.fromJson(json["diamond"]),
        manufacturingPrice: json["manufacturing_price"] == null ? null : ManufacturingPrice.fromJson(json["manufacturing_price"]),
        colourStone: json["colour_stone"] == null ? null : ColourStone.fromJson(json["colour_stone"]),
        pearl: json["pearl"] == null ? null : Pearl.fromJson(json["pearl"]),
        mino: json["mino"] == null ? null : Mino.fromJson(json["mino"]),
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        total: json["total"] == null ? null : RxNum(num.tryParse(json["total"].toString()) ?? 0),
      );

  Map<String, dynamic> toJson() => {
        "metal": metal?.toJson(),
        "diamond": diamond?.toJson(),
        "manufacturing_price": manufacturingPrice?.toJson(),
        "colour_stone": colourStone?.toJson(),
        "pearl": pearl?.toJson(),
        "mino": mino?.toJson(),
        "other": other?.toJson(),
        "total": total?.value,
      };
}

class ManufacturingPrice {
  final double? metalWeight;
  final double? perGramLabour;
  final double? manufacturingPrice;

  ManufacturingPrice({
    this.metalWeight,
    this.perGramLabour,
    this.manufacturingPrice,
  });

  factory ManufacturingPrice.fromJson(Map<String, dynamic> json) => ManufacturingPrice(
        metalWeight: json["metal_weight"]?.toDouble(),
        perGramLabour: json["per_gram_labour"]?.toDouble(),
        manufacturingPrice: json["manufacturing_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "metal_weight": metalWeight,
        "per_gram_labour": perGramLabour,
        "manufacturing_price": manufacturingPrice,
      };
}

class ColourStone {
  final num? colourStoneWeight;
  final num? colourStonePrice;
  final num? colourStoneCount;

  ColourStone({
    this.colourStoneWeight,
    this.colourStonePrice,
    this.colourStoneCount,
  });

  factory ColourStone.fromJson(Map<String, dynamic> json) => ColourStone(
        colourStoneWeight: json["colour_stone_weight"]?.toDouble(),
        colourStonePrice: json["colour_stone_price"],
        colourStoneCount: json["colour_stone_count"],
      );

  Map<String, dynamic> toJson() => {
        "colour_stone_weight": colourStoneWeight,
        "colour_stone_price": colourStonePrice,
        "colour_stone_count": colourStoneCount,
      };
}

class Mino {
  final num? minoPrice;

  Mino({
    this.minoPrice,
  });

  factory Mino.fromJson(Map<String, dynamic> json) => Mino(
        minoPrice: json["mino_price"],
      );

  Map<String, dynamic> toJson() => {
        "mino_price": minoPrice,
      };
}

class Pearl {
  final num? pearlWeight;
  final num? pearlPrice;
  final num? pearlCount;

  Pearl({
    this.pearlWeight,
    this.pearlPrice,
    this.pearlCount,
  });

  factory Pearl.fromJson(Map<String, dynamic> json) => Pearl(
        pearlWeight: json["pearl_weight"],
        pearlPrice: json["pearl_price"],
        pearlCount: json["pearl_count"],
      );

  Map<String, dynamic> toJson() => {
        "pearl_weight": pearlWeight,
        "pearl_price": pearlPrice,
        "pearl_count": pearlCount,
      };
}

class PriceBreakingDiamond {
  num? diamondWeight;
  num? diamondCartPrice;
  num? diamondSleeveSize;
  num? diamondPrice;

  PriceBreakingDiamond({
    this.diamondWeight,
    this.diamondCartPrice,
    this.diamondSleeveSize,
    this.diamondPrice,
  });

  factory PriceBreakingDiamond.fromJson(Map<String, dynamic> json) => PriceBreakingDiamond(
        diamondWeight: num.tryParse(json["diamond_weight"].toString()) ?? 0,
        diamondCartPrice: num.tryParse(json["per_carat_price"].toString()) ?? 0,
        diamondSleeveSize: num.tryParse(json["sleeve_size_wise_price"].toString()) ?? 0,
        diamondPrice: num.tryParse(json["diamond_price"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "diamond_weight": diamondWeight,
        "per_carat_price": diamondCartPrice,
        "sleeve_size_wise_price": diamondSleeveSize,
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
        metalWeight: num.tryParse(json["metal_weight"].toString()) ?? 0,
        pricePerGram: num.tryParse(json["price_per_gram"].toString()) ?? 0,
        metalPrice: num.tryParse(json["metal_price"].toString()) ?? 0,
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
        manufacturingPrice: num.tryParse(json["manufacturing_price"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "manufacturing_price": manufacturingPrice,
      };
}

class ProductInfo {
  final String? metal;
  final String? karatage;
  final num? metalWt;
  final double? totalDiamondWeight;
  final num? totalDiamonds;
  final String? diamondClarity;
  final String? category;
  final List<dynamic>? collection;
  final String? approxDelivery;

  ProductInfo({
    this.metal,
    this.karatage,
    this.metalWt,
    this.totalDiamondWeight,
    this.totalDiamonds,
    this.diamondClarity,
    this.category,
    this.collection,
    this.approxDelivery,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        metal: json["Metal"],
        karatage: json["Karatage"],
        metalWt: num.tryParse(json["Metal Wt"].toString()) ?? 0,
        category: json["Category"],
        collection: json["Collection"] == null ? [] : List<dynamic>.from(json["Collection"]!.map((x) => x)),
        approxDelivery: json["approx_delivery"],
        totalDiamondWeight: json["total_diamond_weight"]?.toDouble(),
        totalDiamonds: json["total_diamonds"] ?? 0,
        diamondClarity: json["diamond_clarity"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "Metal": metal,
        "Karatage": karatage,
        "Metal Wt": metalWt,
        "total_diamond_weight": totalDiamondWeight,
        "total_diamonds": totalDiamonds,
        "diamond_clarity": diamondClarity,
        "Category": category,
        "Collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x)),
        "approx_delivery": approxDelivery,
      };
}
