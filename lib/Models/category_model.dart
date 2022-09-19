// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.title,
    required this.parentId,
    required this.categoryId,
    this.slug,
    required this.categoryModelClass,
  });

  int id;
  String title;
  String parentId;
  String categoryId;
  String? slug;
  String categoryModelClass;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        parentId: json["parent_id"],
        categoryId: json["category_id"],
        slug: json["slug"] == null ? null : json["slug"],
        categoryModelClass: json["class"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent_id": parentId,
        "category_id": categoryId,
        "slug": slug == null ? null : slug,
        "class": categoryModelClass,
      };
}
