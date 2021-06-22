



import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/Files.dart';
import 'package:googledriveclone_flutter/Screen/HomeScreen.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'package:googledriveclone_flutter/Screen/Profile.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/components/DocumentPicker.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_popup_menu.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';
import 'package:storage_capacity/storage_capacity.dart';

import 'IssudFile.dart';
import 'SharedFile.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart' as filesystem;



class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    try {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digilocker',
        theme: ThemeData(
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Digilocker'),
      );
    }
    catch(e){
      print('Loading expception of page'+e.toString());
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  SharedPreferences prefs ;
  Widget _widgetBody = HomeScreen();
  int _currrentIndex = 0;
  Animation<double> _animation;
  AnimationController _animationController;
  TextEditingController _foldername = TextEditingController();
String permissionstatus ="Ok";

  String _fileName;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFolder;
  double _diskSpace = 0;
  String _freespace ="0" ;
  String  _occupiedSpace ="0";
  String _totalSpace="0";

  String fileName;
  String fpath;
  Map<String, String> fpaths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;


  @override
  void initState() {
    // TODO: implement initState
    print('Home page loading');
  //  _controller.addListener(() => _extension = _controller.text);
    createDir();
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
    var coreNotifier = Provider.of<CoreNotifier>(context);

    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false, // This way it will not open
     // endDrawer: Drawer(),
      drawer: new Drawer(
        elevation: 10,
        child: new ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Image.asset('assets/digi_locker.png', width: 300,),
                   SizedBox(height: 10,),
                    Text('Available space: '+_freespace.toString()+'\t (MB)'),

                  ]
              ),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
              ),

            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('My profile'),
              onTap: () {
                // Get.back();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profilePage()
                    )
                );

              },
            ),
            Divider(),


            ListTile(
              leading: Icon(Icons.create_new_folder),
              title: Text('Create folder'),
              onTap: () {
                // Get.back();
               // checkpermission;
                checkpermission(context);
                _showMyDialog(coreNotifier.currentPath.absolute.path);
              },
            ),

            ListTile(
              leading: Icon(Icons.cloud_upload_rounded),
              title: Text('File upload'),
              onTap: () {
                // Get.back();
                checkpermission(context);

                _openFileType(context);

              },
            ),

            ListTile(
              leading: Icon(Icons.six_ft_apart_outlined),
              title: Text('Issued documents'),
              onTap: () {
                // Get.back();

              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                // Get.back();
                _showMyDialog(coreNotifier.currentPath.absolute.path);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.translate_rounded),
              title: Text('Change lagnuage'),
              onTap: () {
                // Get.back();
                //Get.offAll(LoginPage());
                //Do some stuff here
                //Closing programmatically - very less practical use
                scaffoldKey.currentState.openEndDrawer();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
               // Get.back();
                //SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs= await SharedPreferences.getInstance();
                prefs.remove('userid');
               // Get.offAll(LoginPage());
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                      return LoginPage();
                    }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation, Widget child) {
                      return new SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }),
                        (Route route) => false);
                //Do some stuff here
                //Closing programmatically - very less practical use
                scaffoldKey.currentState.openEndDrawer();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
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

      ),

      body: SafeArea(

       child:  Container(
            padding: EdgeInsets.all(15.0),
              child: FutureBuilder(
                future: _getStorgeInfo(),
                builder: (context, snapshot){
                  if(snapshot.connectionState!=ConnectionState.done) return CircularProgressIndicator();
                    return _widgetBody;

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
              checkpermission(context);
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

              checkpermission(context);
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

  Future<void> _showMyDialog(String path) async {
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
                createFolder(context, scaffoldKey, _foldername.text.toString()) ;

                filesystem.createFolderByPath(path, folderName: _foldername.text.toString());

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
      onRadioButtonSelection: (value) async {
        print('onRadioButtonSelection $value');
       // filesystem.uploadFile();
        //With parameters:
        FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
          invalidFileNameSymbols: ['/'],
        );
        final path = await FlutterDocumentPicker.openDocument(params: params);
        print ('selected file \t $path');

      },
    );
  }

 Future<void> _getStorgeInfo()  async{
   _freespace = await StorageCapacity.getFreeSpace;
   //_freespacemb = await  StorageCapacity.toMegaBytes(double.parse(_freespace.toString()));
   _occupiedSpace = await StorageCapacity.getOccupiedSpace;
   _totalSpace = await StorageCapacity.getTotalSpace;
 }



}

Future<String> checkpermission(BuildContext context) async{
  String permission="OK";
  var cameraStatus = await Permission.camera.status;
  var microphoneStatus = await Permission.storage.status;

  print(cameraStatus);
  print(microphoneStatus);
  //cameraStatus.isGranted == has access to application
  //cameraStatus.isDenied == does not have access to application, you can request again for the permission.
  //cameraStatus.isPermanentlyDenied == does not have access to application, you cannot request again for the permission.
  //cameraStatus.isRestricted == because of security/parental control you cannot use this permission.
  //cameraStatus.isUndetermined == permission has not asked before.

  if (!cameraStatus.isGranted)
    await Permission.camera.request();

  if (!microphoneStatus.isGranted)
    await Permission.storage.request();

  if(await Permission.storage.isGranted){
    if(await Permission.camera.isGranted){
    //  openCamera();
      return permission;
    }else{
      print('Camera needs to access your microphone, please provide permission');
      permission ="NO";
    //  showToast("Camera needs to access your microphone, please provide permission", position: ToastPosition.bottom);
    }
  }else{
    permission ="NO";
    print('Provide storage permission to use camera');
   // showToast("Provide Camera permission to use camera.", position: ToastPosition.bottom);
  }
 // return  permission ;
}

 _checkStoragePermission() async {
  bool isStorgage = false;
  var storgestatus = await Permission.storage.status;
  var camerastatus = await Permission.camera.status;
  print ('Storage'+storgestatus.toString()+'Camera'+camerastatus.toString());
  if (storgestatus.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    print ('Permission denied');
    await Permission.storage.request();

  }
  else{
    print ('Permission Accepted');

    isStorgage = true;

  }

  if (camerastatus.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    print ('Permission denied');
    await Permission.camera.request();

  }
  else{
    print ('Permission Accepted');



  }
}





