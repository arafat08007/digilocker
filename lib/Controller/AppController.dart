import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/BaseErrorController.dart';
import 'package:googledriveclone_flutter/Models/CardInfo.dart';
import 'package:googledriveclone_flutter/Models/LoginTokenCreate.dart';
import 'package:googledriveclone_flutter/Models/LoginUserData.dart';

import 'package:googledriveclone_flutter/Models/LoginapiModel.dart';
import 'package:googledriveclone_flutter/services/AppApi.dart';
import 'package:googledriveclone_flutter/services/baseClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appcontroller extends GetxController with BaseErrorController {
  static List<CardInfo> cardListMain = new List<CardInfo>();
  static List<UserData> userdata = new List<UserData>();
  var loginProcess = false.obs;
  var isLoading = true.obs;
  var error = "";

  Future<String> login({String mobile, String password}) async {
    error = "";
    final prefs = await SharedPreferences.getInstance();
    var token;
    // var request = {'message': 'CodeX sucks!!!'};
    try {
      loginProcess(true);
      //Map loginResp = await AppCon.createtoken(mobile: mobile, password: password);
      var baseUrl = AppApi.CDAP_API;
      var api = AppApi.CDAP_END_POINT;
      var obj = {'client_id': AppApi.client_id, 'api_key': AppApi.api_key};

      var tokenResp = await BaseClient().Loginpost(baseUrl, api, obj);
      print('Login api response: ' + tokenResp.toString());

      if (tokenResp != null) {
        var jsonString = tokenResp.toString();
        var tokenRes = loginTokenFromJson(jsonString);

        token = tokenRes.token;
        print("The token\t" + token);

        var nextobj = {
          'token': token,
          'mobile': '01717466686',
          'password': 'TSleVnZb'
        };
        var loginResp = await BaseClient().Loginpost(
            AppApi.CDAP_API, AppApi.CDAP_USER_LOGIN_END_POINT, nextobj);
        if (loginResp == null) return null;
        var loginJsonResp = loginResp.toString();
        var loginResponse = loginUserFromJson(loginResp);
        prefs.setString("id", loginResponse.udata.id);
        print(loginResponse.udata.id);

        final jsonResponse = json.decode(loginResp);
        LoginUser loginuserdata = new LoginUser.fromJson(jsonResponse);
        print('Userdata 1: ${loginuserdata.udata.id}');

        List<dynamic> values = new List<dynamic>();
        values = json.decode(loginResp);
        if (values.length > 0) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
          //    userdata.add(UserData.fromJson(map));
              debugPrint('user details details---${map['id']}---${map['email']}');
            }
          }
        }

    //    userdata.assign(login_user);

        // I want to get value for 'data' only from the json response like ' {"status":"success","data":{"id":"606bc8e9863d1 ... }}



      } else {
        error = tokenResp.toString();
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

  static List<LoginUserData> parsUserData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<LoginUserData>((json) => LoginUserData.fromJson(json))
        .toList();
  }

  Future<List<CardInfo>> getVirtualCardData() async {
    // showLoading('Fetching data');
    var apiresponse = await BaseClient()
        .get(AppApi.FAKE_BASE_API, AppApi.FAKE_BASE_CARD_INFO);
    // if (apiresponse == null)
    //  return json.decode(apiresponse);

    List<dynamic> values = new List<dynamic>();
    values = json.decode(apiresponse);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          cardListMain.add(CardInfo.fromJson(map));
          debugPrint('Card details---${map['name']}---${map['description']}');
        }
      }
    }
    print(cardListMain[0].description);
    return cardListMain;

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
        .Loginpost('https://jsonplaceholder.typicode.com', '/posts', request);
    // .catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }
}
