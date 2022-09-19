// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.discount,
    this.success,
  });

  String? discount;
  String? success;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        discount: json["discount"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "discount": discount,
        "success": success,
      };
}
