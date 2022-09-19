// To parse this JSON data, do
//
//     final subCategoryDrawerModel = subCategoryDrawerModelFromJson(jsonString);

import 'dart:convert';

SubCategoryDrawerModel subCategoryDrawerModelFromJson(String str) =>
    SubCategoryDrawerModel.fromJson(json.decode(str));

String subCategoryDrawerModelToJson(SubCategoryDrawerModel data) =>
    json.encode(data.toJson());

class SubCategoryDrawerModel {
  SubCategoryDrawerModel({
    required this.data,
  });

  List<Datum> data;

  factory SubCategoryDrawerModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryDrawerModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.parentId,
    this.categoryId,
    this.title,
    required this.child,
  });

  int id;
  String parentId;
  String? categoryId;
  String? title;
  List<Child> child;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        parentId: json["parent_id"],
        categoryId: json["category_id"],
        title: json["title"],
        child: List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "category_id": categoryId,
        "title": title,
        "child": List<dynamic>.from(child.map((x) => x.toJson())),
      };
}

class Child {
  Child({
    required this.id,
    this.title,
    required this.parentId,
    this.categoryId,
    this.slug,
    this.childClass,
    this.defaultImage,
  });

  int id;
  String? title;
  String parentId;
  String? categoryId;
  String? slug;
  dynamic childClass;
  dynamic defaultImage;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        title: json["title"],
        parentId: json["parent_id"],
        categoryId: json["category_id"],
        slug: json["slug"] == null ? null : json["slug"],
        childClass: json["class"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent_id": parentId,
        "category_id": categoryId,
        "slug": slug == null ? null : slug,
        "class": childClass,
        "default_image": defaultImage,
      };
}
