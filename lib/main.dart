import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(GetMaterialApp( home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digilocker',
      theme: ThemeData(
        primarySwatch: Colors.green,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Digilocker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  initState(){
    createDir(); //call your method here
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: LoginPage(),//HomePage(),
    );
  }
  createDir() async {
    try {
      print("Creating directory");
      // Directory baseDir = await getExternalStorageDirectory(); //only for Android
      Directory baseDir = await getApplicationDocumentsDirectory(); //works for both iOS and Android
      String dirToBeCreated = "Digilocker";
      String finalDir = join(baseDir.toString(), dirToBeCreated);
      var dir = Directory(finalDir);
      bool dirExists = await dir.exists();
      if (!dirExists) {
        dir
            .create(/*recursive=true*/); //pass recursive as true if directory is recursive
      }
    }
    catch(e){
      print ("Directory error"+e.toString());
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissions.
  }
}
