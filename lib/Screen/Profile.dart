import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Controller/CQAPI.dart';

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
            Navigator.popUntil(context,
                ModalRoute.withName(Navigator.defaultRouteName));
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //virtual nid card
                VNID(),
            Divider(height: 15,),
            Text('Profile page', ),
                Divider(),
                Text('${CQAPI.getLoginData().reactive}'),
          ]
          ),

        ),
      ),
    );
  }
}

 class VNID extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height*0.23,
       margin: const EdgeInsets.all(15.0),
       padding: const EdgeInsets.all(5.0),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
         boxShadow: [
           BoxShadow(
             color: Colors.grey,
             offset: Offset(0.0, 1.0), //(x,y)
             blurRadius: 6.0,
           ),
         ],

       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           //header
            Row(
              mainAxisSize:  MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                Image.asset('assets/bd_gov_logo.png' , width: 30, fit: BoxFit.fill,),
                SizedBox(width: 20,),
              // RichText(text: 'গণপ্রজাতন্ত্রী বাংলাদেশ সরকার '),
               Expanded(child: Text('গণপ্রজাতন্ত্রী বাংলাদেশ সরকার \n Govt of the People\'s Republic of Bangladesh ', maxLines: 3, overflow: TextOverflow.visible, textAlign: TextAlign.center,   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                SizedBox(width: 20,),
              ],


            ),
           //body
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               SizedBox(width: 20,),
               Image.asset('assets/user_img.png' , width: 70, fit: BoxFit.fill,),
               SizedBox(width: 20,),
             ],
           ),

         ],
       ),


     );
   }
 }
