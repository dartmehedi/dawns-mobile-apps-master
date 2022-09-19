// To parse this JSON data, do
//
//     final divisionModel = divisionModelFromJson(jsonString);

import 'dart:convert';

DivisionModel divisionModelFromJson(String str) =>
    DivisionModel.fromJson(json.decode(str));

String divisionModelToJson(DivisionModel data) => json.encode(data.toJson());

class DivisionModel {
  DivisionModel({
    required this.data,
  });

  List<Datum> data;

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.divisionName,
  });

  int id;
  String divisionName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        divisionName: json["division_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "division_name": divisionName,
      };
}
