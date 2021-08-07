import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/BaseErrorController.dart';
import 'package:googledriveclone_flutter/Models/CardInfo.dart';
import 'package:googledriveclone_flutter/services/AppApi.dart';
import 'package:googledriveclone_flutter/services/baseClient.dart';

class Appcontroller  extends GetxController  with BaseErrorController{
  static List<CardInfo> cardListMain = new List<CardInfo>();

  Future<List<CardInfo>> getVirtualCardData() async{
    // showLoading('Fetching data');
    var apiresponse = await BaseClient().get(AppApi.FAKE_BASE_API, AppApi.FAKE_BASE_CARD_INFO);
   // if (apiresponse == null)
    //  return json.decode(apiresponse);

   List<dynamic> values = new List<dynamic>();
    values = json.decode(apiresponse);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          cardListMain.add(CardInfo.fromJson(map));
          debugPrint(
              'Card details---${map['name']}---${map['description']}');
        }
      }
    }
    print(cardListMain[0].description);
    return cardListMain;

/*
    //.catchError(handleError);
     if (apiresponse == null)  {

       hideLoading();
       return;
     }
     else {
    //   hideLoading();
       print(apiresponse);
       return apiresponse;
     }*/

  }

   void postData() async {
     var request = {'message': 'CodeX sucks!!!'};
     showLoading('Posting data...');
     var response = await BaseClient()
         .post('https://jsonplaceholder.typicode.com', '/posts', request);
       //  .catchError(handleError);
     if (response == null) return;
     hideLoading();
     print(response);
   }
   void postRequest() async {
     var request = {'message': 'CodeX sucks!!!'};
     showLoading('Posting data...');
     var response = await BaseClient()
         .post('https://jsonplaceholder.typicode.com', '/posts', request);
        // .catchError(handleError);
     if (response == null) return;
     hideLoading();
     print(response);
   }
}