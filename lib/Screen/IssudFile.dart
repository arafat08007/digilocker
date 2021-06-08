
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Issued.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Widget/issued.dart';

import 'package:flutter/services.dart';

import 'dart:async';
void main() {
  runApp(MyIssuedDocScreenPage());
}



class MyIssuedDocScreenPage extends StatefulWidget {
  MyIssuedDocScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyIssuedDocScreenPageState createState() => _MyIssuedDocScreenPageState();
}

class _MyIssuedDocScreenPageState extends State<MyIssuedDocScreenPage> {

  bool _canCheckBiometrics;

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  _SupportState _supportState = _SupportState.unknown;
  var isAuth;
  @override
  void initState() {


    // ignore: unnecessary_statements

    print("Authorized:\t"+isAuth.toString());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          //if (_supportState == _SupportState.unknown)
          //    CircularProgressIndicator( color: kPrimaryLightColor, ),
          //else if (_supportState == _SupportState.supported)
          //  Text("This device is supported")
        //  else
          //  Text("This device is not supported"),

          Text('Issued documents',style: TextStyle(color: Colors.black54,fontSize: 18, fontWeight: FontWeight.bold),),

          Divider(height: 20),

          Expanded(
            child: ListView.builder(
                itemCount: issues.length,
                itemBuilder: (context, index){
                  return Container(

                    // ignore: unrelated_type_equality_checks
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    //child: (_authorized==true)? IssuedWidget(issued: issues[index],):Text('Need to authorized first'),
                    child:  IssuedWidget(issued: issues[index],)
                  );
                }
            ),
          )]
    );
  }
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}