import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

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
            'Notifications',
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
          color: gradientEndColor ,
          child: Text('Notification Page')

        ),
      ),
    );
  }
}
