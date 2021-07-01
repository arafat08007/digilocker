

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googledriveclone_flutter/Screen/HomeScreen.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:image/image.dart';

class Choice {
  final String title;
  final IconData icon;


 const Choice({this.title, this.icon});


}
const List<Choice> choices = <Choice> [
  Choice(title: 'All', icon: Icons.all_inclusive ),
  Choice(title: 'pdf', icon: Icons.picture_as_pdf ),
  Choice(title: 'word', icon: FontAwesomeIcons.fileWord ),
  Choice(title: 'sheet', icon: FontAwesomeIcons.fileExcel ),
  Choice(title: 'images', icon: FontAwesomeIcons.fileImage ),
  Choice(title: 'notes', icon: FontAwesomeIcons.fileInvoice ),
  Choice(title: 'medical', icon: FontAwesomeIcons.fileMedical ),
  Choice(title: 'certificate', icon: FontAwesomeIcons.fileContract ),


];


class ChoicePage extends StatelessWidget {
   ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;
  Widget _widgetBody = HomeScreen();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),

      child: Column(
      //  mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[
               Text(choice.title, style: textStyle,)

        ],
      ),
    );
  }
}