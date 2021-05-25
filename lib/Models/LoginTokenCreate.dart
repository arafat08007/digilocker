// To parse this JSON data, do
//
//     final loginTokenCreate = loginTokenCreateFromJson(jsonString);

import 'dart:convert';

LoginTokenCreate loginTokenCreateFromJson(String str) => LoginTokenCreate.fromJson(json.decode(str));

String loginTokenCreateToJson(LoginTokenCreate data) => json.encode(data.toJson());

class LoginTokenCreate {
  LoginTokenCreate({
    this.status,
    this.token,
    this.expireTime,
  });

  String status;
  String token;
  int expireTime;

  factory LoginTokenCreate.fromJson(Map<String, dynamic> json) => LoginTokenCreate(
    status: json["status"],
    token: json["token"],
    expireTime: json["expire_time"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "expire_time": expireTime,
  };
}
