// To parse this JSON data, do
//
//     final homeProductlistModel = homeProductlistModelFromJson(jsonString);

import 'dart:convert';

HomeProductlistModel homeProductlistModelFromJson(String str) =>
    HomeProductlistModel.fromJson(json.decode(str));

String homeProductlistModelToJson(HomeProductlistModel data) =>
    json.encode(data.toJson());

class HomeProductlistModel {
  HomeProductlistModel({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    required this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<HomeProductList> data;
  String? firstPageUrl;
  int? from;
  int lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory HomeProductlistModel.fromJson(Map<String, dynamic> json) =>
      HomeProductlistModel(
        currentPage: json["current_page"],
        data: List<HomeProductList>.from(
            json["data"].map((x) => HomeProductList.fromJson(x))),
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
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class HomeProductList {
  HomeProductList({
    required this.id,
    required this.categoryId,
    this.subcategoryId,
    this.brandId,
    this.genericId,
    this.productName,
    this.productSlug,
    this.productCode,
    this.productQuantity,
    this.sellingPrice,
    this.discountType,
    this.discount,
    this.discountPrice,
    this.unit,
    this.priceActive,
    this.videoLink,
    this.shortDescription,
    this.productDescription,
    this.mainSlider,
    this.hotDeal,
    this.bestRated,
    this.midSlider,
    this.hotNew,
    this.trendProduct,
    this.defaultImage,
    this.subImageOne,
    this.subImageTwo,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String categoryId;
  dynamic subcategoryId;
  String? brandId;
  String? genericId;
  String? productName;
  String? productSlug;
  String? productCode;
  String? productQuantity;
  String? sellingPrice;
  String? discountType;
  String? discount;
  String? discountPrice;
  String? unit;
  String? priceActive;
  dynamic videoLink;
  String? shortDescription;
  String? productDescription;
  dynamic mainSlider;
  String? hotDeal;
  dynamic bestRated;
  dynamic midSlider;
  String? hotNew;
  String? trendProduct;
  String? defaultImage;
  String? subImageOne;
  dynamic subImageTwo;
  String? status;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HomeProductList.fromJson(Map<String, dynamic> json) =>
      HomeProductList(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        brandId: json["brand_id"],
        genericId: json["generic_id"] == null ? null : json["generic_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        productCode: json["product_code"],
        productQuantity:
            json["product_quantity"] == null ? null : json["product_quantity"],
        sellingPrice: json["selling_price"],
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        unit: json["unit"] == null ? null : json["unit"],
        priceActive: json["price_active"],
        videoLink: json["video_link"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        mainSlider: json["main_slider"],
        hotDeal: json["hot_deal"] == null ? null : json["hot_deal"],
        bestRated: json["best_rated"],
        midSlider: json["mid_slider"],
        hotNew: json["hot_new"] == null ? null : json["hot_new"],
        trendProduct:
            json["trend_product"] == null ? null : json["trend_product"],
        defaultImage: json["default_image"],
        subImageOne:
            json["sub_image_one"] == null ? null : json["sub_image_one"],
        subImageTwo: json["sub_image_two"],
        status: json["status"],
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "brand_id": brandId,
        "generic_id": genericId == null ? null : genericId,
        "product_name": productName,
        "product_slug": productSlug,
        "product_code": productCode,
        "product_quantity": productQuantity == null ? null : productQuantity,
        "selling_price": sellingPrice,
        "discount_type": discountType == null ? null : discountType,
        "discount": discount,
        "discount_price": discountPrice,
        "unit": unit == null ? null : unit,
        "price_active": priceActive,
        "video_link": videoLink,
        "short_description": shortDescription == null ? null : shortDescription,
        "product_description":
            productDescription == null ? null : productDescription,
        "main_slider": mainSlider,
        "hot_deal": hotDeal == null ? null : hotDeal,
        "best_rated": bestRated,
        "mid_slider": midSlider,
        "hot_new": hotNew == null ? null : hotNew,
        "trend_product": trendProduct == null ? null : trendProduct,
        "default_image": defaultImage,
        "sub_image_one": subImageOne == null ? null : subImageOne,
        "sub_image_two": subImageTwo,
        "status": status,
        "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
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
