// To parse this JSON data, do
//
//     final emailTakenModel = emailTakenModelFromJson(jsonString);

import 'dart:convert';

EmailTakenModel emailTakenModelFromJson(String str) =>
    EmailTakenModel.fromJson(json.decode(str));

String emailTakenModelToJson(EmailTakenModel data) =>
    json.encode(data.toJson());

class EmailTakenModel {
  EmailTakenModel({
    required this.message,
    required this.errors,
  });

  String message;
  Errors errors;

  factory EmailTakenModel.fromJson(Map<String, dynamic> json) =>
      EmailTakenModel(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    required this.email,
  });

  List<String> email;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
      };
}
