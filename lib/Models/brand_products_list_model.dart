// To parse this JSON data, do
//
//     final brandProductListModel = brandProductListModelFromJson(jsonString);

import 'dart:convert';

BrandProductListModel brandProductListModelFromJson(String str) =>
    BrandProductListModel.fromJson(json.decode(str));

String brandProductListModelToJson(BrandProductListModel data) =>
    json.encode(data.toJson());

class BrandProductListModel {
  BrandProductListModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    required this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  int? currentPage;
  List<BrandProductList>? data;
  String? firstPageUrl;
  int? from;
  int lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int total;

  factory BrandProductListModel.fromJson(Map<String, dynamic> json) =>
      BrandProductListModel(
        currentPage: json["current_page"],
        data: List<BrandProductList>.from(
            json["data"].map((x) => BrandProductList.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        if (data != null) "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class BrandProductList {
  BrandProductList({
    required this.id,
    this.categoryId,
    required this.brandId,
    required this.productName,
    this.productSlug,
    this.productCode,
    this.productQuantity,
    this.sellingPrice,
    this.discountType,
    this.discount,
    this.discountPrice,
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
  String brandId;
  String productName;
  String? productSlug;
  String? productCode;
  String? productQuantity;
  String? sellingPrice;
  dynamic discountType;
  String? discount;
  String? discountPrice;
  String? unit;
  String? priceActive;
  String? shortDescription;
  String? productDescription;
  String? hotDeal;
  String? trendProduct;
  String? hotNew;
  String? defaultImage;

  factory BrandProductList.fromJson(Map<String, dynamic> json) =>
      BrandProductList(
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
        unit: json["unit"] == null ? null : json["unit"],
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
        "unit": unit == null ? null : unit,
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

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
