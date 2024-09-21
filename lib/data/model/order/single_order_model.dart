// To parse this JSON data, do
//
//     final getOrderDetailModel = getOrderDetailModelFromJson(jsonString);

import 'dart:convert';

GetSingleOrderDetailModel getOrderDetailModelFromJson(String str) => GetSingleOrderDetailModel.fromJson(json.decode(str));

String getOrderDetailModelToJson(GetSingleOrderDetailModel data) => json.encode(data.toJson());

class GetSingleOrderDetailModel {
  final String? message;
  final GetOrderDetailDataModel? data;

  GetSingleOrderDetailModel({
    this.message,
    this.data,
  });

  factory GetSingleOrderDetailModel.fromJson(Map<String, dynamic> json) => GetSingleOrderDetailModel(
        message: json["message"],
        data: json["data"] == null ? null : GetOrderDetailDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetOrderDetailDataModel {
  final OrderModel? order;
  final List<OrderListModel>? orderItems;
  final List<ProductListModel>? productItems;

  GetOrderDetailDataModel({
    this.order,
    this.orderItems,
    this.productItems,
  });

  factory GetOrderDetailDataModel.fromJson(Map<String, dynamic> json) => GetOrderDetailDataModel(
        order: json["order"] == null ? null : OrderModel.fromJson(json["order"]),
        orderItems: json["orderItems"] == null ? [] : List<OrderListModel>.from(json["orderItems"]!.map((x) => OrderListModel.fromJson(x))),
        productItems: json["productItems"] == null ? [] : List<ProductListModel>.from(json["productItems"]!.map((x) => ProductListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "orderItems": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "productItems": productItems == null ? [] : List<dynamic>.from(productItems!.map((x) => x.toJson())),
      };
}

class OrderModel {
  final String? id;
  final String? orderNo;
  final String? orderType;
  final RetailerId? retailerId;
  final num? qty;
  final num? subTotal;
  final num? discount;
  final num? grandTotal;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  OrderModel({
    this.id,
    this.orderNo,
    this.orderType,
    this.retailerId,
    this.qty,
    this.subTotal,
    this.discount,
    this.grandTotal,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        orderNo: json["order_no"],
        orderType: json["order_type"],
        retailerId: json["retailer_id"] == null ? null : RetailerId.fromJson(json["retailer_id"]),
        qty: json["qty"],
        subTotal: json["sub_total"],
        discount: json["discount"],
        grandTotal: json["grand_total"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_no": orderNo,
        "order_type": orderType,
        "retailer_id": retailerId?.toJson(),
        "qty": qty,
        "sub_total": subTotal,
        "discount": discount,
        "grand_total": grandTotal,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class RetailerId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? businessName;
  final String? email;
  final String? phone;
  final String? landline;
  final String? address;
  final String? city;
  final String? state;
  final bool? status;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  RetailerId({
    this.id,
    this.firstName,
    this.lastName,
    this.businessName,
    this.email,
    this.phone,
    this.landline,
    this.address,
    this.city,
    this.state,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RetailerId.fromJson(Map<String, dynamic> json) => RetailerId(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        businessName: json["business_name"],
        email: json["email"],
        phone: json["phone"],
        landline: json["landline"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "business_name": businessName,
        "email": email,
        "phone": phone,
        "landline": landline,
        "address": address,
        "city": city,
        "state": state,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderListModel {
  final String? id;
  final String? orderId;
  final ProductId? productId;
  final num? qty;
  final num? itemTotal;
  final num? discount;
  final num? grandTotal;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  OrderListModel({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.itemTotal,
    this.discount,
    this.grandTotal,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        id: json["_id"],
        orderId: json["order_id"],
        productId: json["product_id"] == null ? null : ProductId.fromJson(json["product_id"]),
        qty: json["qty"],
        itemTotal: json["item_total"],
        discount: json["discount"],
        grandTotal: json["grand_total"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_id": orderId,
        "product_id": productId?.toJson(),
        "qty": qty,
        "item_total": itemTotal,
        "discount": discount,
        "grand_total": grandTotal,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class ProductId {
  final String? id;
  final String? name;
  final String? slug;
  final String? sku;
  final List<String>? inventoryImages;
  final String? categoryId;
  final String? subCategoryId;
  final String? sizeId;
  final String? metalId;
  final num? metalWeight;
  final dynamic remark;
  final bool? status;
  final List<DiamondElement>? diamonds;
  final num? diamondTotalPrice;
  final num? manufacturingPrice;
  final String? gender;
  final List<String>? productTags;
  final String? createdBy;
  final dynamic updatedBy;
  final bool? inStock;
  final bool? wearItItem;
  final String? delivery;
  final String? productionName;
  final dynamic deletedAt;
  final List<dynamic>? familyProducts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ProductId({
    this.id,
    this.name,
    this.slug,
    this.sku,
    this.inventoryImages,
    this.categoryId,
    this.subCategoryId,
    this.sizeId,
    this.metalId,
    this.metalWeight,
    this.remark,
    this.status,
    this.diamonds,
    this.diamondTotalPrice,
    this.manufacturingPrice,
    this.gender,
    this.productTags,
    this.createdBy,
    this.updatedBy,
    this.inStock,
    this.wearItItem,
    this.delivery,
    this.productionName,
    this.deletedAt,
    this.familyProducts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]!.map((x) => x)),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        metalWeight: json["metal_weight"],
        remark: json["remark"],
        status: json["status"],
        diamonds: json["diamonds"] == null ? [] : List<DiamondElement>.from(json["diamonds"]!.map((x) => DiamondElement.fromJson(x))),
        diamondTotalPrice: json["diamond_total_price"],
        manufacturingPrice: json["manufacturing_price"],
        gender: json["gender"],
        productTags: json["product_tags"] == null ? [] : List<String>.from(json["product_tags"]!.map((x) => x)),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        inStock: json["in_stock"],
        wearItItem: json["wear_it_item"],
        delivery: json["delivery"],
        productionName: json["production_name"],
        deletedAt: json["deleted_at"],
        familyProducts: json["family_products"] == null ? [] : List<dynamic>.from(json["family_products"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "inventory_images": inventoryImages == null ? [] : List<dynamic>.from(inventoryImages!.map((x) => x)),
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "size_id": sizeId,
        "metal_id": metalId,
        "metal_weight": metalWeight,
        "remark": remark,
        "status": status,
        "diamonds": diamonds == null ? [] : List<dynamic>.from(diamonds!.map((x) => x.toJson())),
        "diamond_total_price": diamondTotalPrice,
        "manufacturing_price": manufacturingPrice,
        "gender": gender,
        "product_tags": productTags == null ? [] : List<dynamic>.from(productTags!.map((x) => x)),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "in_stock": inStock,
        "wear_it_item": wearItItem,
        "delivery": delivery,
        "production_name": productionName,
        "deleted_at": deletedAt,
        "family_products": familyProducts == null ? [] : List<dynamic>.from(familyProducts!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class DiamondElement {
  final String? diamondClarity;
  final String? diamondShape;
  final String? diamondSize;
  final int? diamondCount;
  final double? totalPrice;
  final String? id;

  DiamondElement({
    this.diamondClarity,
    this.diamondShape,
    this.diamondSize,
    this.diamondCount,
    this.totalPrice,
    this.id,
  });

  factory DiamondElement.fromJson(Map<String, dynamic> json) => DiamondElement(
        diamondClarity: json["diamond_clarity"],
        diamondShape: json["diamond_shape"],
        diamondSize: json["diamond_size"],
        diamondCount: json["diamond_count"],
        totalPrice: json["total_price"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "diamond_clarity": diamondClarity,
        "diamond_shape": diamondShape,
        "diamond_size": diamondSize,
        "diamond_count": diamondCount,
        "total_price": totalPrice,
        "_id": id,
      };
}

class ProductListModel {
  final String? id;
  final String? sizeId;
  final String? metalId;
  final List<String>? inventoryImages;
  final PriceBreaking? priceBreaking;
  final ProductInfo? productInfo;
  final List<DiamondElement>? diamonds;
  final List<dynamic>? familyProducts;

  ProductListModel({
    this.id,
    this.sizeId,
    this.metalId,
    this.inventoryImages,
    this.priceBreaking,
    this.productInfo,
    this.diamonds,
    this.familyProducts,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        id: json["_id"],
        sizeId: json["size_id"],
        metalId: json["metal_id"],
        inventoryImages: json["inventory_images"] == null ? [] : List<String>.from(json["inventory_images"]!.map((x) => x)),
        priceBreaking: json["price_breaking"] == null ? null : PriceBreaking.fromJson(json["price_breaking"]),
        productInfo: json["product_info"] == null ? null : ProductInfo.fromJson(json["product_info"]),
        diamonds: json["diamonds"] == null ? [] : List<DiamondElement>.from(json["diamonds"]!.map((x) => DiamondElement.fromJson(x))),
        familyProducts: json["family_products"] == null ? [] : List<dynamic>.from(json["family_products"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size_id": sizeId,
        "metal_id": metalId,
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
  final num? total;

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
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "metal": metal?.toJson(),
        "diamond": diamond?.toJson(),
        "other": other?.toJson(),
        "total": total,
      };
}

class PriceBreakingDiamond {
  final num? diamondWeight;
  final num? diamondPrice;

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
  final num? metalWeight;
  final num? pricePerGram;
  final num? metalPrice;

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
  final num? manufacturingPrice;

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
