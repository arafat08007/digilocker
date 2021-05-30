import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Recent.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Widget/recent.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomeScreenPage();
  }
}

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  @override
  Widget build(BuildContext context) {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Recent',style: TextStyle(color: Colors.black54,fontSize: 18, fontWeight: FontWeight.bold),),
        Divider(height: 20,),

        Expanded(
        child: ListView.builder(
            itemCount: recents.length,
            itemBuilder: (context, index){
              return Container(
                child: RecentWidget(recent: recents[index],),
              );
            }
        ),
      )]
    );
  }
}
