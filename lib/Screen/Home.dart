
import 'package:fab_circular_menu/fab_circular_menu.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/Files.dart';
import 'package:googledriveclone_flutter/Screen/HomeScreen.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'package:googledriveclone_flutter/Screen/Profile.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';
import 'package:storage_capacity/storage_capacity.dart';

import 'IssudFile.dart';

void main() {
  runApp(HomePage());
}

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  Widget _widgetBody = HomeScreen();
  int _currrentIndex = 0;
  Animation<double> _animation;
  AnimationController _animationController;
  TextEditingController _foldername = TextEditingController();

  //TextEditingController _controller = TextEditingController();
 // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _fileName;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFolder;
  double _diskSpace = 0;
  var _freespace ;
  var _freespacemb;
  var _occupiedSpace ;
  var _totalSpace;
  @override
  void initState() {
    // TODO: implement initState
  //  _controller.addListener(() => _extension = _controller.text);
    _getStorgeInfo();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

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
        _widgetBody = MyIssuedDocScreen();
      }
      else if(index == 2){
        _currrentIndex = index;
        _widgetBody = Center(child: Text('Shared documents'),);
      }
      else if(index == 3){
        _currrentIndex = index;
        _widgetBody = MyDriveScreen();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

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
                    Image.asset('assets/digi_locker.png', width: MediaQuery.of(context).size.width*0.30,),
                   SizedBox(height: 10,),
                    Text('Available space: '+_freespace+'\t (MB)'),

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
                Get.to(profilePage());

              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.create_new_folder),
              title: Text('Create folder'),
              onTap: () {
                // Get.back();
                _showMyDialog();
              },
            ),

            ListTile(
              leading: Icon(Icons.cloud_upload_rounded),
              title: Text('File upload'),
              onTap: () {
                // Get.back();

              },
            ),

            ListTile(
              leading: Icon(Icons.six_ft_apart_outlined),
              title: Text('Issued documents'),
              onTap: () {
                // Get.back();

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
              onTap: () {
               // Get.back();
                Get.offAll(LoginPage());
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
                      icon: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(Icons.search, color: kPrimaryColor,)
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
            onPressed: (){
              print("Sync started");
              showSnackMessage(context,"Sync Started please wait...", scaffoldKey,'');
            },
            icon: Icon(
            Icons.sync,
            color:kPrimaryColor,
          ),
          ),
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
                // do something
                },
              )
        ],

      ),

      body: SafeArea(

       child:  Container(
            padding: EdgeInsets.all(15.0),
              child: _widgetBody
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
              print('creating folder');
              _showMyDialog();


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

  Future<void> _showMyDialog() async {
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
                Get.back();
                //Navigator.of(context).pop();
               // _animationController.reverse();
              },
            ),
            TextButton(
              child: Text('Create', style: TextStyle(color: kPrimaryColor),),
              onPressed: () {
                createFolder(context, scaffoldKey, _foldername.text.toString()) ;
                Get.back();

                //Navigator.of(context).pop();
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
        Get.back();
      },
      onRadioButtonSelection: (value) {
        print('onRadioButtonSelection $value');
      },
    );
  }

 /* Future<void> initDiskSpace() async {
    double diskSpace = 0;

    diskSpace = await DiskSpace.getFreeDiskSpace;

    if (!mounted) return;

    setState(() {
      _diskSpace = diskSpace;
    });
  }
*/
 Future<void> _getStorgeInfo()  async{
   _freespace = await StorageCapacity.getFreeSpace;
   //_freespacemb = await  StorageCapacity.toMegaBytes(double.parse(_freespace.toString()));
   _occupiedSpace = await StorageCapacity.getOccupiedSpace;
   _totalSpace = await StorageCapacity.getTotalSpace;
 }



}





