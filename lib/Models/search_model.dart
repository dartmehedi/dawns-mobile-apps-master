// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.data,
  });

  List<ProductList> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        data: List<ProductList>.from(
            json["data"].map((x) => ProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductList {
  ProductList({
    required this.id,
    this.categoryId,
    this.brandId,
    this.productName,
    this.productSlug,
    this.productCode,
    this.productQuantity,
    this.sellingPrice,
    this.discountType,
    this.discount,
    required this.discountPrice,
    this.unit,
    this.priceActive,
    this.shortDescription,
    this.productDescription,
    this.hotDeal,
    this.trendProduct,
    this.hotNew,
    this.defaultImage,
  });

  int id;
  String? categoryId;
  String? brandId;
  String? productName;
  String? productSlug;
  String? productCode;
  String? productQuantity;
  String? sellingPrice;
  dynamic discountType;
  String? discount;
  String discountPrice;
  Unit? unit;
  String? priceActive;
  String? shortDescription;
  String? productDescription;
  String? hotDeal;
  String? trendProduct;
  String? hotNew;
  String? defaultImage;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["id"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        productCode: json["product_code"],
        productQuantity:
            json["product_quantity"] == null ? null : json["product_quantity"],
        sellingPrice: json["selling_price"],
        discountType: json["discount_type"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        unit: json["unit"] == null ? null : unitValues.map[json["unit"]],
        priceActive: json["price_active"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        hotDeal: json["hot_deal"] == null ? null : json["hot_deal"],
        trendProduct:
            json["trend_product"] == null ? null : json["trend_product"],
        hotNew: json["hot_new"] == null ? null : json["hot_new"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "brand_id": brandId,
        "product_name": productName,
        "product_slug": productSlug,
        "product_code": productCode,
        "product_quantity": productQuantity == null ? null : productQuantity,
        "selling_price": sellingPrice,
        "discount_type": discountType,
        "discount": discount,
        "discount_price": discountPrice,
        "unit": unit == null ? null : unitValues.reverse![unit],
        "price_active": priceActive,
        "short_description": shortDescription == null ? null : shortDescription,
        "product_description":
            productDescription == null ? null : productDescription,
        "hot_deal": hotDeal == null ? null : hotDeal,
        "trend_product": trendProduct == null ? null : trendProduct,
        "hot_new": hotNew == null ? null : hotNew,
        "default_image": defaultImage,
      };
}

enum Unit { PC, BOX, SET, JAR }

final unitValues = EnumValues(
    {"BOX": Unit.BOX, "JAR": Unit.JAR, "PC": Unit.PC, "SET": Unit.SET});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
