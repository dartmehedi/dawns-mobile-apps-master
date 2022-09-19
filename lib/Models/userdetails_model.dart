// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    required this.id,
    this.role,
    this.name,
    required this.email,
    this.providerId,
    this.provider,
    this.emailVerifiedAt,
    this.mobile,
    this.address,
    this.image,
  });

  int id;
  String? role;
  String? name;
  String email;
  dynamic providerId;
  dynamic provider;
  dynamic emailVerifiedAt;
  String? mobile;
  dynamic address;
  dynamic image;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        id: json["id"],
        role: json["role"],
        name: json["name"],
        email: json["email"],
        providerId: json["provider_id"],
        provider: json["provider"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        address: json["address"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "name": name,
        "email": email,
        "provider_id": providerId,
        "provider": provider,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "address": address,
        "image": image,
      };
}
