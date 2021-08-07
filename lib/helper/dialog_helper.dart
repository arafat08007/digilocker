import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:path/path.dart';

class DialogHelper {
 static void ShowErrDialog(
      {String title = 'Error !', String description = 'Error description'})
  {
    Get.dialog(
        Dialog(
          child: Container(
           padding: EdgeInsets.all(15),
            child: Column (
              children: [
                Text(title, style: Get.textTheme.headline3, textAlign: TextAlign.center ,),
                Divider(height: 15, thickness: 1, color: gradientEndColor,),
                Text(description, style: Get.textTheme.bodyText1,),
                ElevatedButton.icon(onPressed: (){
                  if(Get.isDialogOpen) Get.back();
                }, icon: Icon(FontAwesomeIcons.tiktok), label: Text('OK'))
              ],
            ),
          ),
        )
    );
  }
 static void showLoading([String message]) {
   Get.dialog(
     Dialog(
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             CircularProgressIndicator(),
             SizedBox(height: 8),
             Text(message ?? 'Loading...'),
           ],
         ),
       ),
     ),
   );
 }

 //hide loading
 static void hideLoading() {
   if (Get.isDialogOpen) Get.back();
 }
}
