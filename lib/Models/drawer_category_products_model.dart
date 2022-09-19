// To parse this JSON data, do
//
//     final drawerCategoryProductsModel = drawerCategoryProductsModelFromJson(jsonString);

import 'dart:convert';

DrawerCategoryProductsModel drawerCategoryProductsModelFromJson(String str) =>
    DrawerCategoryProductsModel.fromJson(json.decode(str));

String drawerCategoryProductsModelToJson(DrawerCategoryProductsModel data) =>
    json.encode(data.toJson());

class DrawerCategoryProductsModel {
  DrawerCategoryProductsModel({
    required this.data,
  });

  Data data;

  factory DrawerCategoryProductsModel.fromJson(Map<String, dynamic> json) =>
      DrawerCategoryProductsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.currentPage,
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

  int currentPage;
  List<Datum> data;
  String? firstPageUrl;
  int? from;
  int lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
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
  String? brandId;
  String? productName;
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
  dynamic hotDeal;
  dynamic trendProduct;
  dynamic hotNew;
  String? defaultImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        shortDescription: json["short_description"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        hotDeal: json["hot_deal"],
        trendProduct: json["trend_product"],
        hotNew: json["hot_new"],
        defaultImage:
            json["default_image"] == null ? null : json["default_image"],
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
        "short_description": shortDescription,
        "product_description":
            productDescription == null ? null : productDescription,
        "hot_deal": hotDeal,
        "trend_product": trendProduct,
        "hot_new": hotNew,
        "default_image": defaultImage == null ? null : defaultImage,
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
