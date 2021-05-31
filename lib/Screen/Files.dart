import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Files.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
import 'package:googledriveclone_flutter/Screen/DeviceFiles.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/deviceexplorer/screens/storage_screen.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:googledriveclone_flutter/Widget/smallGrid.dart';

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
  TabController controller;
  Widget _widgetBody;

  @override
  void initState() {
    //getFiles();
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: controller,
                    labelColor: Color(0xFF1777F2),
                    indicatorColor: kPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "My Web Locker",),
                      Tab(text: "Device",),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
            body: TabBarView(
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
            )
        ),
      ),
    );
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