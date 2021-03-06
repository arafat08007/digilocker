import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:googledriveclone_flutter/Models/Files.dart';

import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Widget/home_tab_menu.dart';

import 'package:googledriveclone_flutter/services/AppApi.dart';
import 'package:googledriveclone_flutter/services/baseClient.dart';


void main() {
  runApp(MyDriveScreen());
}

class MyDriveScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyDriveScreenPage();
  }
}

class MyDriveScreenPage extends StatefulWidget {
  MyDriveScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDriveScreenPageState createState() => _MyDriveScreenPageState();
}

class _MyDriveScreenPageState extends State<MyDriveScreenPage> with SingleTickerProviderStateMixin{

  var devicefile;
  final TrackingScrollController scrollController = TrackingScrollController();
  List<Files> _staticFiles = new List<Files>();
  TabController controller;
  Widget _widgetBody;

  @override
  void initState() {
    //getFiles();
    getFiles(AppApi.FAKE_BASE_API, AppApi.FAKE_FILES);
    super.initState();
    controller = new TabController(length: choices.length, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(

                  TabBar(

                    controller: controller,
                    labelColor: kPrimaryColor,
                    indicatorColor: kPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                   isScrollable: true,

                    tabs: choices.map <Widget>((Choice chioce) {
                      return Tab (
                        text: chioce.title,
                        icon: Icon(chioce.icon),
                      );
                    }

                    ).toList(),
                  ),
                ),
                pinned: true,
              //  floating: true,
              ),
            ];
          },

          body: TabBarView(
            controller: controller,
            children: choices.map((Choice choice ) {
              return ChoicePage(
                choice: choice,
                staticFiles: _staticFiles,
              );

            }).toList(),
          ),
         /*   body: TabBarView(
              controller: controller,
              children: [
                //My web locker
                Container(
                  child: files.length>0?GridView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: files.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2 ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                          child: new SmallGridWIdget(file: files[index],)
                      );
                    },
                  ):
                  Container(
                    padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/notfound.png', width: MediaQuery.of(context).size.width-100,),
                            Text('Nothing found',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 22),),
                          ]

                      )
                  ),
                ),
                //My device locker
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: _widgetBody = StorageScreen(),
                )


              ],
            )*/
        ),
      ),
    );
  }

  Future<List<Files>> getFiles(String fake_base_api, String fake_files)async {

    var response = await BaseClient().get(fake_base_api, fake_files);
    print(" File response: $response");
    // If the call to the server was successful, parse the JSON
    List<dynamic> values = new List<dynamic>();
    if(response == null) return null;
    values = json.decode(response);
    _staticFiles.addAll(filesFromJson(response));
  /*  if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          _staticFiles.add(Files.fromJson(map));
          debugPrint(
              'Files ----${map['fileName']}---${map['fileType']}');
        }
      }
    }*/
    return _staticFiles;
  }


}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}