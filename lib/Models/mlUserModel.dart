// To parse this JSON data, do
//
//     final mlUserModel = mlUserModelFromJson(jsonString);

import 'dart:convert';

MlUserModel mlUserModelFromJson(String str) => MlUserModel.fromJson(json.decode(str));

String mlUserModelToJson(MlUserModel data) => json.encode(data.toJson());

class MlUserModel {
  MlUserModel({
    this.user,
    this.token,
  });

  User user;
  String token;

  factory MlUserModel.fromJson(Map<String, dynamic> json) => MlUserModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.id,
    this.citizenId,
    this.name,
    this.email,
    this.phone,
    this.nid,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String citizenId;
  String name;
  String email;
  String phone;
  int nid;
  DateTime dateOfBirth;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    citizenId: json["citizen_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    nid: json["nid"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "citizen_id": citizenId,
    "name": name,
    "email": email,
    "phone": phone,
    "nid": nid,
    "date_of_birth": dateOfBirth,//"${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
