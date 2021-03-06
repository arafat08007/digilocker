import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('id');
  print("UserID\t"+userid.toString());
 //runApp(GetMaterialApp( home: MyLoginApp()));
  runApp(( (userid == null))? MyLoginApp():HomePage());

  //runApp(GetMaterialApp(home: ( (userid == null))? MyLoginApp() : HomePage()));
}

class MyLoginApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myLocker',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLoginPage (title: 'myLocker'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

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

}
