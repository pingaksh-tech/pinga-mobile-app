// To parse this JSON data, do
//
//     final getOrderModel = getOrderModelFromJson(jsonString);

import 'dart:convert';

GetOrderModel getOrderModelFromJson(String str) => GetOrderModel.fromJson(json.decode(str));

String getOrderModelToJson(GetOrderModel data) => json.encode(data.toJson());

class GetOrderModel {
  final String? message;
  final GetOrderDataModel? data;

  GetOrderModel({
    this.message,
    this.data,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
        message: json["message"],
        data: json["data"] == null ? null : GetOrderDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class GetOrderDataModel {
  final OrderCounts? orderCounts;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<OrderModel>? orders;

  GetOrderDataModel({
    this.orderCounts,
    this.totalCount,
    this.page,
    this.totalPages,
    this.orders,
  });

  factory GetOrderDataModel.fromJson(Map<String, dynamic> json) => GetOrderDataModel(
        orderCounts: json["orderCounts"] == null ? null : OrderCounts.fromJson(json["orderCounts"]),
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        orders: json["orders"] == null ? [] : List<OrderModel>.from(json["orders"]!.map((x) => OrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderCounts": orderCounts?.toJson(),
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class OrderCounts {
  final String? id;
  final num? totalCount;
  final num? totalAmount;

  OrderCounts({
    this.id,
    this.totalCount,
    this.totalAmount,
  });

  factory OrderCounts.fromJson(Map<String, dynamic> json) => OrderCounts(
        id: json["_id"],
        totalCount: json["totalCount"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalCount": totalCount,
        "totalAmount": totalAmount,
      };
}

class OrderModel {
  final String? id;
  final String? orderNo;
  final String? orderType;
  final String? retailerId;
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
  final Retailer? retailer;

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
    this.retailer,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        orderNo: json["order_no"],
        orderType: json["order_type"],
        retailerId: json["retailer_id"],
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
        retailer: json["retailer"] == null ? null : Retailer.fromJson(json["retailer"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_no": orderNo,
        "order_type": orderType,
        "retailer_id": retailerId,
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
        "retailer": retailer?.toJson(),
      };
}

class Retailer {
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
  final String? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Retailer({
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

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
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
