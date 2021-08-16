

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/AppController.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
import 'package:googledriveclone_flutter/Screen/HomeScreen.dart';
import 'package:googledriveclone_flutter/Widget/FileFolder.dart';
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
   ChoicePage({Key key, this.choice, this.staticFiles}) : super(key: key);
  final Choice choice;
  final List<Files> staticFiles;

   final Appcontroller _appcontroller = Get.put(Appcontroller());

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    print('legnth ${staticFiles.length}');
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),


      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 5),
        child: staticFiles.length>0 ?

             StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: staticFiles.length,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              itemBuilder: (context, index) {
                return FileFolderTile(staticFiles[index]);
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            )
         : Text(choice.title),
      ),
    );
  }
}