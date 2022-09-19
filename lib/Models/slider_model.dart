// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    required this.data,
  });

  List<Datum> data;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.slider1,
    this.slider2,
    this.slider3,
  });

  int? id;
  String? slider1;
  String? slider2;
  String? slider3;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        slider1: json["slider1"],
        slider2: json["slider2"],
        slider3: json["slider3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slider1": slider1,
        "slider2": slider2,
        "slider3": slider3,
      };
}
