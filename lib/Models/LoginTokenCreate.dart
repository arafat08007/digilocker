// To parse this JSON data, do
//
//     final loginToken = loginTokenFromJson(jsonString);

import 'dart:convert';

LoginToken loginTokenFromJson(String str) => LoginToken.fromJson(json.decode(str));

String loginTokenToJson(LoginToken data) => json.encode(data.toJson());

class LoginToken {
  LoginToken({
    this.status,
    this.token,
    this.expireTime,
  });

  String status;
  String token;
  int expireTime;

  factory LoginToken.fromJson(Map<String, dynamic> json) => LoginToken(
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
