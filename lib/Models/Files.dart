// To parse this JSON data, do
//
//     final files = filesFromJson(jsonString);

import 'dart:convert';

List<Files> filesFromJson(String str) => List<Files>.from(json.decode(str).map((x) => Files.fromJson(x)));

String filesToJson(List<Files> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Files {
  Files({
    this.fileImage,
    this.fileName,
    this.fileType,
    this.numofrecord,
    this.isFolder,
    this.size,
  });

  String fileImage;
  String fileName;
  String fileType;
  int numofrecord;
  bool isFolder;
  String size;

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    fileImage: json["fileImage"],
    fileName: json["fileName"],
    fileType: json["fileType"],
    numofrecord: json["numofrecord"],
    isFolder: json["isFolder"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "fileImage": fileImage,
    "fileName": fileName,
    "fileType": fileType,
    "numofrecord": numofrecord,
    "isFolder": isFolder,
    "size": size,
  };
}
