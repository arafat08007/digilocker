import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Files.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
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


  @override
  void initState() {
    getFiles();
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: controller,
                  labelColor: Color(0xFF1777F2),
                  indicatorColor: Colors.blue.shade700,
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
                  padding: EdgeInsets.all(20),
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
                child: devicefile?.length.toString()=="0"?GridView.builder(
                  //print(devicefile?.length.toString());
                  padding: EdgeInsets.all(20),
                  itemCount: devicefile?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2 ),
                  itemBuilder: (BuildContext context, int index) {
                    return  Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                        child: SmallGridWIdget(file: devicefile[index],)
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
              )
            ],
          )
      ),
    );
  }

  void getFiles() async { //asyn function to get list of files

    try {
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
      var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
      var fm = FileManager(root: Directory(root)); //
      print("Device file calculating" + root.toString());
      devicefile = await fm.filesTree(
        //set fm.dirsTree() for directory/folder tree list
        excludedPaths: ["/storage/emulated/0/Android"],
        // extensions: ["png", "pdf","docx","xlsx","jpg"] //optional, to filter files, remove to list all,
        //remove this if your are grabbing folder list
      );
    }
    catch(e){
      print("Error getting device files"+e.toString());
    }
    print('Device files'+devicefile?.length.toString());
    setState(() {}); //update the UI
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