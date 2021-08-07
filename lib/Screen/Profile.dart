import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/AppController.dart';
import 'package:googledriveclone_flutter/Data/vidcardData.dart';
import 'package:googledriveclone_flutter/Models/CardInfo.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Controller/CQAPI.dart';

class profilePage extends StatefulWidget {
  profilePage({Key key, this.title, this.items}) : super(key: key);
  final String title;
  final Future<List<CardInfo>> items;

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var appController = Appcontroller();



  @override
  void initState() {
    // TODO: implement initState
   // appController.getVirtualCardData() ;
   // _cardList = Appcontroller.cardListMain;
    //print('Profile card list size ${_cardList.length}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              child: Icon(Icons.arrow_back_outlined, color: kPrimaryColor)),
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: 14),
          )),
      body: SafeArea(

        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
              future: appController.getVirtualCardData(),
              // ignore: missing_return
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  Container(
                    height: size.height / 4,
                    //   color: kPrimaryColor,
                    child: Swiper(
                      itemCount: snapshot.data.length,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 30,
                      itemHeight: 200,
                      layout: SwiperLayout.STACK,
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeSize: 10,
                          space: 8,
                          activeColor: kPrimaryColor,
                        ),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return VNID(
                          cardtype: snapshot.data[index].cardType,
                          api: 'sampleapi',
                          userimage: snapshot.data[index].personImage,
                          orgimage: snapshot.data[index].orgImage,
                          name: snapshot.data[index].name,
                          desc: snapshot.data[index].description,
                          userinfo: snapshot.data[index].userinfo,
                          signature: snapshot.data[index].signature,
                        );
                      },
                    ),
                  );

                }
              }),
        )



      ),
    );
  }
}

class VNID extends StatelessWidget {
  final String cardtype;
  final String api;

  final String userimage;
  final String orgimage;
  final String name;
  final String desc;
  final List userinfo;
  final String signature;

  const VNID(
      {Key key,
      this.cardtype,
      this.api,
      this.userimage,
      this.orgimage,
      this.name,
      this.desc,
      this.userinfo,
      this.signature})
      : super(key: key);
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
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //header
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/bd_gov_logo.png',
                  width: 30,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 20,
                ),
                // RichText(text: 'গণপ্রজাতন্ত্রী বাংলাদেশ সরকার '),
                Expanded(
                    child: Text(
                  'গণপ্রজাতন্ত্রী বাংলাদেশ সরকার \n Govt of the People\'s Republic of Bangladesh ',
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            //body
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  userimage,
                  width: 70,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      for (var userinformation in userinfo)
                        Text(
                          userinformation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ])),
              ],
            ),
          ],
        ),
        //Watermark--------------------------------------
        Positioned(
          bottom: 0,
          right: 0,
          child: new RotatedBox(
              quarterTurns: -1,
              child: Container(
                  color: Colors.black54.withOpacity(0.9),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    cardtype.toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 8),
                  ))),
        )
      ]),
    );
  }
}
