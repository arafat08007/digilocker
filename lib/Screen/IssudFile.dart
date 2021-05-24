import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Issued.dart';
import 'package:googledriveclone_flutter/Data/Recent.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Widget/issued.dart';
import 'package:googledriveclone_flutter/Widget/recent.dart';

void main() {
  runApp(MyIssuedDocScreen());
}

class MyIssuedDocScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyIssuedDocScreenPage();
  }
}

class MyIssuedDocScreenPage extends StatefulWidget {
  MyIssuedDocScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyIssuedDocScreenPageState createState() => _MyIssuedDocScreenPageState();
}

class _MyIssuedDocScreenPageState extends State<MyIssuedDocScreenPage> {

  @override
  Widget build(BuildContext context) {

    return Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Issued documents',style: TextStyle(color: Colors.black54,fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: issues.length,
                itemBuilder: (context, index){
                  return Container(
                    child: IssuedWidget(issued: issues[index],),
                  );
                }
            ),
          )]
    );
  }
}
