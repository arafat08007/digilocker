// To parse this JSON data, do
//
//     final cardInfo = cardInfoFromJson(jsonString);

import 'dart:convert';

List<CardInfo> cardInfoFromJson(String str) => List<CardInfo>.from(json.decode(str).map((x) => CardInfo.fromJson(x)));

String cardInfoToJson(List<CardInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardInfo {
  CardInfo({
    this.name,
    this.iconImage,
    this.description,
    this.images,
    this.personImage,
    this.orgImage,
    this.cardType,
    this.signature,
    this.userinfo,
  });

  String name;
  String iconImage;
  String description;
  List<String> images;
  String personImage;
  String orgImage;
  String cardType;
  String signature;
  List<String> userinfo;

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
    name: json["name"],
    iconImage: json["iconImage"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    personImage: json["personImage"],
    orgImage: json["orgImage"],
    cardType: json["cardType"],
    signature: json["signature"],
    userinfo: List<String>.from(json["userinfo"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "iconImage": iconImage,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "personImage": personImage,
    "orgImage": orgImage,
    "cardType": cardType,
    "signature": signature,
    "userinfo": List<dynamic>.from(userinfo.map((x) => x)),
  };
}
