
// dart
import 'dart:io';

// framework
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googledriveclone_flutter/Screen/MyDriveScreen.dart';
import 'package:googledriveclone_flutter/Screen/HomeScreen.dart';
import 'package:googledriveclone_flutter/Screen/IssudFile.dart';
import 'package:googledriveclone_flutter/Screen/Profile.dart';
import 'package:googledriveclone_flutter/Screen/SharedFile.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

// packages
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as pathlib;

// app files
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_popup_menu.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/search.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/preferences.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/create_dialog.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/file.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/folder.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart' as filesystem;
import 'package:googledriveclone_flutter/deviceexplorer//ui/widgets/context_dialog.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/io_extensions.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_path_widget.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';




class MyDeviceFile extends StatefulWidget {

  final String path;
  //MyDeviceFile({Key key, this.path}) : super(key: key);
  const MyDeviceFile({@required this.path}) : assert(path != null);
  @override
  _MyDeviceFileState createState() => _MyDeviceFileState();
}

class _MyDeviceFileState extends State<MyDeviceFile> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  Widget _widgetBody ;
  int _currrentIndex = 0;
  Animation<double> _animation;
  AnimationController _animationController;
  TextEditingController _foldername = TextEditingController();
  String permissionstatus ="Ok";
  ScrollController _scrollController;
  String _fileName;

  var sscaffoldKey = GlobalKey<ScaffoldState>();
  bool isFolder;
  double _diskSpace = 0;
  String _freespace ="0" ;
  String _freespacemb ="0" ;
  String _occupiedSpace ="0";
  String _totalSpace="0";
  @override
  void initState() {
    // TODO: implement initState
    print('Home page loading');
    //  _controller.addListener(() => _extension = _controller.text);
    _scrollController = ScrollController(keepScrollOffset: true);

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300),);
    //_getStorgeInfo();
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    //  initDiskSpace();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  void _onItemTapped(int index) async{
    setState(() {
      if(index == 0){
        _currrentIndex = index;
        _widgetBody = HomeScreen();
      }
      else if(index == 1){
        _currrentIndex = index;
        _widgetBody = MyIssuedDocScreenPage();
      }
      else if(index == 2){
        _currrentIndex = index;
        _widgetBody = MySharedDocScreenPage();
      }
      else if(index == 3){
        _currrentIndex = index;
        _widgetBody = MyDriveScreen();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final preferences = Provider.of<PreferencesNotifier>(context);
    var coreNotifier = Provider.of<CoreNotifier>(context);
    return Scaffold(
      key: sscaffoldKey,
      endDrawerEnableOpenDragGesture: false, // This way it will not open
      // endDrawer: Drawer(),

      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Theme.of(context).brightness,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    color: Colors.grey.shade50,

                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search in locker",
                      border: InputBorder.none,
                      prefixIcon: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(Icons.search, color: kPrimaryColor,)
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.mic),
                      ),


                    ),

                  ),
                ),
              ),
            ]
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
        actions: <Widget>[

          IconButton(
            icon: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.all(5),

              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage("https://qph.fs.quoracdn.net/main-qimg-11ef692748351829b4629683eff21100.webp"),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profilePage()
                  )
              );
              // do something
            },
          ),
          AppBarPopupMenu(path: coreNotifier.currentPath.absolute.path)
        ],
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(10),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15,),
              Icon(Icons.sd_storage_rounded, size: 14, color: Colors.grey,),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.only(left:10,bottom: 5),
                  child: AppBarPathWidget(

                    onDirectorySelected: (dir) {
                      coreNotifier.navigateToDirectory(dir.absolute.path);
                    },
                    path: coreNotifier.currentPath.absolute.path,
                  )),
              ),
            ]
          ),
        ),

      ),

      body: SafeArea(

        child:  Container(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder(

              builder: (context, snapshot){

                return  Consumer<CoreNotifier>(
                  builder: (context, model, child) =>
                      StreamBuilder<List<FileSystemEntity>>(
                        // This function Invoked every time user go back to the previous directory
                        stream: filesystem.fileStream(model.currentPath.absolute.path,
                            keepHidden: preferences.hidden),

                        builder: (BuildContext context,
                            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(child: Text('Press button to start.'));
                            case ConnectionState.active:
                              return Container(width: 0.0, height: 0.0);
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                if (snapshot.error is FileSystemException) {
                                  return Center(child: Text("Permission Denied"));
                                }
                              } else if (snapshot.data.length != 0) {
                                debugPrint(
                                    "FolderListScreen -> Folder Grid: data length = ${snapshot.data.length} ");
                                return GridView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    controller: _scrollController,
                                    key: PageStorageKey(widget.path),
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 0),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      // folder
                                      if (snapshot.data[index] is Directory) {
                                        return FolderWidget(
                                            path: snapshot.data[index].path,
                                            name: snapshot.data[index].basename());
                                        // file
                                      } else if (snapshot.data[index] is File) {
                                        return FileWidget(
                                          name: snapshot.data[index].basename(),
                                          onTap: () {
                                            _printFuture(OpenFile.open(
                                                snapshot.data[index].path));
                                          },
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => FileContextDialog(
                                                  path: snapshot.data[index].path,
                                                  name: snapshot.data[index]
                                                      .basename(),
                                                ));
                                          },
                                        );
                                      }
                                      return Container();
                                    });
                              } else {
                                return Center(
                                  child: Text("Empty Directory!"),
                                );
                              }
                          }
                          return null; // unreachable
                        },
                      ),
                );

              },
            )
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title:"Upload",

            iconColor :kPrimaryColor,
            bubbleColor : Colors.white.withOpacity(0.9),
            titleStyle:TextStyle(fontSize: 16 , color: kPrimaryColor),
            icon:Icons.cloud_upload,

            onPress: () {
              //  OpenFilePicker();
              _animationController.reverse();
              //checkpermission(context);
              _openFileType(context);
            },
          ),
          // Floating action menu item
          Bubble(
            title:"Folder",
            icon:Icons.create_new_folder,
            iconColor :kPrimaryColor,
            bubbleColor : Colors.white.withOpacity(0.9),
            titleStyle:TextStyle(fontSize: 16 , color: kPrimaryColor),
            onPress: ()  {
              _animationController.reverse();

              //checkpermission(context);
              _showMyDialog(coreNotifier.currentPath.absolute.path);                //_showErrorDialog();

            },
          ),
          //Floating action menu item

        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: _animationController.isCompleted
            ? _animationController.reverse
            : _animationController.forward,

        // Floating Action button Icon color
        iconColor: kPrimaryColor,


        // Flaoting Action button Icon
        icon: AnimatedIcons.menu_close,

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currrentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: _currrentIndex==0?Icon(Icons.home,size: 25,):Icon(Icons.home_outlined,size: 25),
              title: Text("Home")
          ),

          BottomNavigationBarItem(
              icon: _currrentIndex==1?Icon(Icons.file_download_done,size: 25,):Icon(Icons.file_download_done_outlined,size: 25),
              title: Text("Issued")
          ),
          BottomNavigationBarItem(
              icon: _currrentIndex==2?Icon(Icons.supervised_user_circle,size: 25,):Icon(Icons.supervised_user_circle,size: 25),
              title: Text("Shared")
          ),
          BottomNavigationBarItem(
              icon: _currrentIndex==3?Icon(Icons.folder,size: 25,):Icon(Icons.folder_open,size: 25),
              title: Text("My locker")
          ),
        ],
      ),    );



  }
  @override
  bool get wantKeepAlive => true;

  Future<void> _showMyDialog(String path) async {
    print('Current path \t $path');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Colors.white,
          elevation: 13,
          title: Text('Create folder'),
          content: TextField(
            onChanged: (value) { },
            controller: _foldername,
            decoration: InputDecoration(hintText: "your folder/directory name",
              suffixIcon: IconButton(
                onPressed: () => _foldername.clear(),
                icon: Icon(Icons.clear),
              ),
            ),

          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red),),
              onPressed: () {
                //Navigator.pop(_);
                Navigator.of(context).pop();
                // _animationController.reverse();
              },
            ),
            TextButton(
              child: Text('Create', style: TextStyle(color: kPrimaryColor),),
              onPressed: () {


                filesystem.createFolderByPath(path,folderName: _foldername.text.toString().trim());

                Navigator.of(context).pop();

                //Navigator.of(context).pop();
                _animationController.reverse();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Colors.white,
          elevation: 13,
          title: Text('Error!' ,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 28),),
          content: Text('Permission denied, You can set permission manually', maxLines: 3,
              overflow: TextOverflow.ellipsis),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),),
              onPressed: () {
                //Navigator.pop(_);
                Navigator.of(context).pop();
                // _animationController.reverse();
              },
            ),

          ],
        );
      },
    );
  }
  void _openFileType(BuildContext context) {

    SKAlertDialog.show(
      context: context,
      type: SKAlertType.radiobutton,
      radioButtonAry: {'Certificate': 1, 'Signature': 2, 'NID': 3, 'Passport': 4, 'Driving licence': 5},
      title: 'Choose File category',
      onCancelBtnTap: (value) {
        print('Cancel Button Tapped');
        Navigator.of(context).pop(false);
      },
      onRadioButtonSelection: (value) {
        print('onRadioButtonSelection $value');
      },
    );
  }



  _printFuture(Future<String> open) async {
    print("Opening: " + await open);
  }




}







