// To parse this JSON data, do
//
//     final loginUserData = loginUserDataFromJson(jsonString);

import 'dart:convert';

LoginUserData loginUserDataFromJson(String str) => LoginUserData.fromJson(json.decode(str));

String loginUserDataToJson(LoginUserData data) => json.encode(data.toJson());

class LoginUserData {
  LoginUserData({
    this.id,
    this.email,
    this.mobile,
    this.nid,
    this.name,
    this.nameEn,
    this.motherName,
    this.motherNameEn,
    this.fatherName,
    this.fatherNameEn,
    this.spouseName,
    this.spouseNameEn,
    this.gender,
    this.dateOfBirth,
    this.photo,
    this.nidVerify,
    this.brn,
    this.brnVerify,
    this.passport,
    this.passportVerify,
    this.tin,
    this.tinVerify,
  });

  String id;
  String email;
  String mobile;
  int nid;
  String name;
  String nameEn;
  String motherName;
  String motherNameEn;
  String fatherName;
  String fatherNameEn;
  String spouseName;
  String spouseNameEn;
  String gender;
  DateTime dateOfBirth;
  String photo;
  int nidVerify;
  dynamic brn;
  int brnVerify;
  dynamic passport;
  int passportVerify;
  dynamic tin;
  int tinVerify;

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    id: json["id"],
    email: json["email"],
    mobile: json["mobile"],
    nid: json["nid"],
    name: json["name"],
    nameEn: json["name_en"],
    motherName: json["mother_name"],
    motherNameEn: json["mother_name_en"],
    fatherName: json["father_name"],
    fatherNameEn: json["father_name_en"],
    spouseName: json["spouse_name"],
    spouseNameEn: json["spouse_name_en"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    photo: json["photo"],
    nidVerify: json["nid_verify"],
    brn: json["brn"],
    brnVerify: json["brn_verify"],
    passport: json["passport"],
    passportVerify: json["passport_verify"],
    tin: json["tin"],
    tinVerify: json["tin_verify"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "mobile": mobile,
    "nid": nid,
    "name": name,
    "name_en": nameEn,
    "mother_name": motherName,
    "mother_name_en": motherNameEn,
    "father_name": fatherName,
    "father_name_en": fatherNameEn,
    "spouse_name": spouseName,
    "spouse_name_en": spouseNameEn,
    "gender": gender,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "photo": photo,
    "nid_verify": nidVerify,
    "brn": brn,
    "brn_verify": brnVerify,
    "passport": passport,
    "passport_verify": passportVerify,
    "tin": tin,
    "tin_verify": tinVerify,
  };
}
