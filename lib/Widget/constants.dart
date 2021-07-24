
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/widgets.dart';
const kPrimaryColor = Color(0xFF1EA6C6);
//const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFe7f3f7);

const loginPagebgColor = Color (0xFFE7E6E7);


Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color navigationColor = Color(0xFF6751B5);
Color gradientStartColor = Color(0xFF0050AC);
Color gradientEndColor = Color(0xFF9354B9);


void showSnackMessage(BuildContext context, String s, GlobalKey<ScaffoldState> scaffoldKey,String type) {

  final snackBar = SnackBar(

      backgroundColor: type.isEmpty?kPrimaryColor:Colors.red,
      content: Text(s.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight:FontWeight.normal, fontSize: 12),)
  );
  scaffoldKey.currentState.showSnackBar(snackBar);   // edited line
}
Future<void> createFolder(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, String s) async {
  try {
//  print('creating folder'+scaffoldKey.toString()+"\t context\t"+context.toString());
    final _appExtrernalDir = await getExternalStorageDirectory();
    print(_appExtrernalDir);

    //final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //print('app doc dir'+ _appDocDir.toString());

    final Directory _appDocDirFolder = Directory(
        '${_appExtrernalDir.path}/digilocker/$s/');
    print('created dir \t $_appDocDirFolder');
    if (await _appDocDirFolder
        .exists()) { //if folder already exists return path
      print('Folder already exist');
      showSnackMessage(context, "Folder already exist.", scaffoldKey, 'red');
      return _appDocDirFolder.path;
    } else { //if folder not exists create folder and then return its path

      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(
          recursive: true);
      showSnackMessage(context, "Folder Created.", scaffoldKey, '');
      return _appDocDirNewFolder.path;
    }
  }
  catch(e){
    print ('Error Folder create'+ e.toString());
  }

}

bool showhide = true;
// Toggles the password show status
void _toggle(BuildContext context, bool s) {
  s = !s;
}

fileImage(String filename){
  if(filename.toLowerCase() == 'docs'){
    return Image.asset("assets/google-docs.png");
  }else if(filename.toLowerCase() == 'image'){
    return Image.asset("assets/photo.png");
  }else if(filename.toLowerCase() == 'pdf'){
    return Image.asset("assets/pdf.png");
  }else if(filename.toLowerCase() == 'sheets'){
    return Image.asset("assets/google-sheets.png");
  }else if(filename.toLowerCase() == 'video'){
    return Image.asset("assets/photographic-flim.png");
  }else if(filename.toLowerCase() == 'zip'){
    return Icon(Icons.archive, color: Colors.blue);
  }
  else if(filename.toString().toLowerCase() == 'Certificate'.toLowerCase()){
    return Icon(Icons.new_releases_sharp, color: Colors.black54.withOpacity(0.3));
  }
  else if(filename.toLowerCase() == 'folder'){
    print(filename);
    return Icon(Icons.folder_open_outlined, color: Colors.black54, size: 12,);
  }
  else{
    return Icon(Icons.wysiwyg_rounded, color: Colors.red,);
  }
}

createDir() async {
  try {
    print("Creating directory");


    // Directory baseDir = await getExternalStorageDirectory(); //only for Android

    final  _appExtrernalDir = await getExternalStorageDirectory();
    print (_appExtrernalDir);

    //final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //print('app doc dir'+ _appDocDir.toString());

    final Directory _appDocDirFolder = Directory('${_appExtrernalDir.path}/digilocker/');

    print('created dir \t $_appDocDirFolder');
    if(await _appDocDirFolder.exists()){ //if folder already exists return path
      print('Folder already exist');
      //showSnackMessage(BuildContext, "Folder already exist.", scaffoldKey,'red');
      return _appDocDirFolder.path;

    }else{//if folder not exists create folder and then return its path
      //showSnackMessage(context, "Folder Created.", scaffoldKey,'');
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }

  }
  catch(e){
    print ("Directory error"+e.toString());
  }
  //Now you can use this directory for saving file, etc.
  //In case you are using external storage, make sure you have storage permissions.
}
//Base64 image
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Future<bool> _checkStoragePermission() async {
  bool isStorgage = false;
  var storgestatus = await Permission.storage.status;

  if (storgestatus.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    print ('Permission denied');
    return isStorgage;
  }
  else{
    print ('Permission Accepted');

    isStorgage = true;
    return isStorgage;
  }
}