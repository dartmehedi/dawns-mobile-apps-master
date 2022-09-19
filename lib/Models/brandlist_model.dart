// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

List<List<BrandListModel>> brandListModelFromJson(String str) =>
    List<List<BrandListModel>>.from(json.decode(str).map((x) =>
        List<BrandListModel>.from(x.map((x) => BrandListModel.fromJson(x)))));

String brandListModelToJson(List<List<BrandListModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class BrandListModel {
  BrandListModel({
    required this.id,
    this.brandName,
    this.homeBanner1,
    this.homeBanner2,
    this.homeBanner3,
  });

  int id;
  String? brandName;
  String? homeBanner1;
  String? homeBanner2;
  String? homeBanner3;

  factory BrandListModel.fromJson(Map<String, dynamic> json) => BrandListModel(
        id: json["id"],
        brandName: json["brand_name"],
        homeBanner1:
            json["home_banner_1"] == null ? null : json["home_banner_1"],
        homeBanner2:
            json["home_banner_2"] == null ? null : json["home_banner_2"],
        homeBanner3:
            json["home_banner_3"] == null ? null : json["home_banner_3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name": brandName,
        "home_banner_1": homeBanner1 == null ? null : homeBanner1,
        "home_banner_2": homeBanner2 == null ? null : homeBanner2,
        "home_banner_3": homeBanner3 == null ? null : homeBanner3,
      };
}
