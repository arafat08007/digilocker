import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

class profilePage extends StatefulWidget {
  profilePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
            child: Icon(Icons.arrow_back_outlined,color:kPrimaryColor)),
        backgroundColor: Colors.white,
        title: Text('Profile', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14),)
      ),
      body: SafeArea(
        child: Container(

          width: size.width,
          height: size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text('Profile page', ),
          ]
          ),

        ),
      ),
    );
  }
}
