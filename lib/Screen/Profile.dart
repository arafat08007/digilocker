import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Data/vidcardData.dart';
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
         height: size.height/4,
       //   color: kPrimaryColor,
          child: Swiper(
              itemCount: Cards.length,
               itemWidth: MediaQuery.of(context).size.width - 2 * 30,
               itemHeight: 200,
               layout: SwiperLayout.STACK,
               pagination: SwiperPagination(
                 builder:
                 DotSwiperPaginationBuilder(activeSize: 10, space: 8, activeColor: kPrimaryColor, ),
               ),
               itemBuilder: (BuildContext context, int index) {
                 return VNID(cardtype:'NID',api:'sampleapi', cardinfo: Cards,);
               },

             ),
        ),
      ),
    );
  }
}

 class VNID  extends StatelessWidget {
  final String cardtype;
  final String api;
  final List cardinfo;

  const VNID({Key key, this.cardtype, this.api, this.cardinfo}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     return Container(
       width: MediaQuery.of(context).size.width,
     //  height: MediaQuery.of(context).size.height*0.23,
       margin: const EdgeInsets.all(5.0),
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
       child: Stack(
         children:[
           Column(
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
           //Watermark--------------------------------------
           Positioned(
             bottom: 5,
             left: 5,
             child: new RotatedBox(
                 quarterTurns: -1,
                 child: new Text("NID card", maxLines: 2,  style: TextStyle(color: Colors.grey.withOpacity(0.5), fontStyle: FontStyle.italic),)
             ),
           )
       ]
       ),


     );
   }
 }
