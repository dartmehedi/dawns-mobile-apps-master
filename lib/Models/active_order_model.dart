// To parse this JSON data, do
//
//     final activeOrderModel = activeOrderModelFromJson(jsonString);

import 'dart:convert';

ActiveOrderModel activeOrderModelFromJson(String str) =>
    ActiveOrderModel.fromJson(json.decode(str));

String activeOrderModelToJson(ActiveOrderModel data) =>
    json.encode(data.toJson());

class ActiveOrderModel {
  ActiveOrderModel({
    required this.data,
  });

  List<Datum> data;

  factory ActiveOrderModel.fromJson(Map<String, dynamic> json) =>
      ActiveOrderModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    this.userId,
    this.name,
    this.mobile,
    this.address,
    this.paymentMethod,
    this.number,
    this.payingAmount,
    this.transactionId,
    this.subtotal,
    this.shippingCharge,
    this.couponDiscount,
    this.total,
    this.notes,
    this.orderDetails,
  });

  int id;
  String? userId;
  String? name;
  String? mobile;
  String? address;
  String? paymentMethod;
  String? number;
  String? payingAmount;
  String? transactionId;
  String? subtotal;
  String? shippingCharge;
  String? couponDiscount;
  String? total;
  String? notes;
  List<OrderDetail>? orderDetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        paymentMethod: json["payment_method"],
        number: json["number"],
        payingAmount: json["paying_amount"],
        transactionId: json["transaction_id"],
        subtotal: json["subtotal"],
        shippingCharge: json["shipping_charge"],
        couponDiscount: json["coupon_discount"],
        total: json["total"],
        notes: json["notes"],
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "address": address,
        "payment_method": paymentMethod,
        "number": number,
        "paying_amount": payingAmount,
        "transaction_id": transactionId,
        "subtotal": subtotal,
        "shipping_charge": shippingCharge,
        "coupon_discount": couponDiscount,
        "total": total,
        "notes": notes,
        "order_details":
            List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.productImage,
    this.colorId,
    this.sizeId,
    this.qty,
    this.singleprice,
    this.totalprice,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? orderId;
  String? productId;
  String? productName;
  dynamic productImage;
  dynamic colorId;
  dynamic sizeId;
  String? qty;
  String? singleprice;
  String? totalprice;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        qty: json["qty"],
        singleprice: json["singleprice"],
        totalprice: json["totalprice"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "color_id": colorId,
        "size_id": sizeId,
        "qty": qty,
        "singleprice": singleprice,
        "totalprice": totalprice,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
