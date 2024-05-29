import 'dart:convert';

GetOrderListModel getOrderListModelFromJson(String str) => GetOrderListModel.fromJson(json.decode(str));

String getOrderListModelToJson(GetOrderListModel data) => json.encode(data.toJson());

class GetOrderListModel {
  final bool? success;
  final String? message;
  final OrderListData? data;

  GetOrderListModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetOrderListModel.fromJson(Map<String, dynamic> json) => GetOrderListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : OrderListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class OrderListData {
  final List<OrderListResult>? results;

  final int? totalResults;
  final int? page;
  final int? limit;
  final int? totalPages;

  OrderListData({
    this.results,
    this.totalResults,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory OrderListData.fromJson(Map<String, dynamic> json) => OrderListData(
        results: json["results"] == null ? [] : List<OrderListResult>.from(json["results"]!.map((x) => OrderListResult.fromJson(x))),
        totalResults: json["totalResults"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "totalResults": totalResults,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}

class OrderListResult {
  final String? id;
  final List<ProductElement>? products;
  final int? totalAmount;
  final String? user;
  final String? status;
  final DateTime? createdAt;

  OrderListResult({
    this.id,
    this.products,
    this.totalAmount,
    this.user,
    this.status,
    this.createdAt,
  });

  factory OrderListResult.fromJson(Map<String, dynamic> json) => OrderListResult(
        id: json["_id"],
        products: json["products"] == null ? [] : List<ProductElement>.from(json["products"]!.map((x) => ProductElement.fromJson(x))),
        totalAmount: json["total_amount"],
        user: json["user"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total_amount": totalAmount,
        "user": user,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class ProductElement {
  final ProductProduct? product;
  final int? quantity;
  final int? price;
  final String? id;

  ProductElement({
    this.product,
    this.quantity,
    this.price,
    this.id,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}

class ProductProduct {
  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final String? color;
  final String? category;
  final String? rate;
  final int? weight;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Productimage>? productImages;

  ProductProduct({
    this.id,
    this.title,
    this.description,
    this.price,
    this.color,
    this.category,
    this.rate,
    this.weight,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productImages,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        color: json["color"],
        category: json["category"],
        rate: json["rate"],
        weight: json["weight"],
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        productImages: json["productimages"] == null ? [] : List<Productimage>.from(json["productimages"]!.map((x) => Productimage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "color": color,
        "category": category,
        "rate": rate,
        "weight": weight,
        "deleted_at": deletedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "productimages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x.toJson())),
      };
}

class Productimage {
  final String? id;
  final String? image;

  Productimage({
    this.id,
    this.image,
  });

  factory Productimage.fromJson(Map<String, dynamic> json) => Productimage(
        id: json["_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
      };
}
