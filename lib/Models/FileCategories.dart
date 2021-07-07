// To parse this JSON data, do
//
//     final fileCategories = fileCategoriesFromJson(jsonString);

import 'dart:convert';

List<FileCategories> fileCategoriesFromJson(String str) => List<FileCategories>.from(json.decode(str).map((x) => FileCategories.fromJson(x)));

String fileCategoriesToJson(List<FileCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileCategories {
  FileCategories({
    this.userid,
    this.catid,
    this.catname,
    this.fileNum,
    this.isIssued,
  });

  String userid;
  String catid;
  String catname;
  String fileNum;
  bool isIssued;

  factory FileCategories.fromJson(Map<String, dynamic> json) => FileCategories(
    userid: json["userid"],
    catid: json["catid"],
    catname: json["catname"],
    fileNum: json["file_num"],
    isIssued: json["isIssued"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "catid": catid,
    "catname": catname,
    "file_num": fileNum,
    "isIssued": isIssued,
  };
}
