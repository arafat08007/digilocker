import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/BaseErrorController.dart';
import 'package:googledriveclone_flutter/Models/CardInfo.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
import 'package:googledriveclone_flutter/Models/LoginTokenCreate.dart';
import 'package:googledriveclone_flutter/Models/LoginUserData.dart';

import 'package:googledriveclone_flutter/Models/LoginapiModel.dart';
import 'package:googledriveclone_flutter/Models/mlUserModel.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/services/AppApi.dart';
import 'package:googledriveclone_flutter/services/baseClient.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appcontroller extends GetxController with BaseErrorController {
  static List<CardInfo> cardListMain = new List<CardInfo>();
  static List<UserData> userdata = new List<UserData>();
  var userfiles = List<Files>().obs;

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

          /* 'mobile': mobile,
          'password': password*/
        };
        var loginResp = await BaseClient().Loginpost(
            AppApi.CDAP_API, AppApi.CDAP_USER_LOGIN_END_POINT, nextobj);
        if (loginResp == null) return null;
        var loginJsonResp = loginResp.toString();
        var loginResponse = loginUserFromJson(loginResp);

        if (loginResponse != null) {
          MyLockerLogin(
              loginResponse.udata.id,
              loginResponse.udata.email,
              loginResponse.udata.mobile,
              loginResponse.udata.nid,
              loginResponse.udata.name,
              loginResponse.udata.nameEn,
              loginResponse.udata.motherName,
              loginResponse.udata.motherNameEn,
              loginResponse.udata.fatherName,
              loginResponse.udata.fatherNameEn,
              loginResponse.udata.spouseName,
              loginResponse.udata.spouseNameEn,
              loginResponse.udata.gender,
              loginResponse.udata.dateOfBirth,
              loginResponse.udata.nidVerify,
              loginResponse.udata.brn,
              loginResponse.udata.brnVerify,
              loginResponse.udata.passport,
              loginResponse.udata.passportVerify,
              loginResponse.udata.tin,
              loginResponse.udata.tinVerify);

        }

        prefs.setString("id", loginResponse.udata.id);
        print(loginResponse.udata.id);

        final jsonResponse = json.decode(loginResp);
        LoginUser loginuserdata = new LoginUser.fromJson(jsonResponse);
        print('Userdata 1: ${loginuserdata.udata.id}');

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

  Future<String> MyLockerLogin(
      String mid,
      String memail,
      String mmobile,
      double mnid,
      String mname,
      String mname_en,
      String mmother_name,
      String mmother_name_en,
      String mfather_name,
      String mfather_name_en,
      String mspouse_name,
      String mspouse_name_en,
      String mgender,
      DateTime mdate_of_birth,
      int mnid_verify,
      String mbrn,
      int mbrn_verify,
      String mpassport,
      int mpassport_verify,
      String mtin,
      int mtin_verify) async {
    final prefs = await SharedPreferences.getInstance();
    error = "";
    try {
      loginProcess(true);

      var baseUrl = AppApi.MY_LOCKER_BASE_API;
      var api = AppApi.MY_LOCKER_LOGIN_END_POINT;

      var nextobj = {
        'id': mid,
        'email': memail,
        'mobile': mmobile,
        'nid': mnid,
        'name': mname,
        'name_en': mname_en,
        'mother_name': mmother_name,
        'mother_name_en': mmother_name_en,
        'father_name': mfather_name,
        'father_name_en': mfather_name_en,
        'spouse_name': mspouse_name,
        'spouse_name_en': mspouse_name_en,
        'gender': mgender,
        'date_of_birth': formatter.format(mdate_of_birth),
        'nid_verify': mnid_verify,
        'brn': mbrn,
        'brn_verify': mbrn_verify,
        'passport': mpassport,
        'passport_verify': mpassport_verify,
        'tin': mtin,
        'tin_verify': mtin_verify
      };
      var loginResp = await BaseClient().post(baseUrl, api, nextobj);
      if (loginResp == null) return null;
      //  var loginJsonResp = loginResp.toString();
      var loginResponse = mlUserModelFromJson(loginResp);
      print('mylockertoken ${loginResponse.token}');
      prefs.setString("mylockertoken", loginResponse.token.toString());
      prefs.setString("mylokcerid", loginResponse.user.id.toString());

      //    userdata.assign(login_user);

      // I want to get value for 'data' only from the json response like ' {"status":"success","data":{"id":"606bc8e9863d1 ... }}

    } finally {
      loginProcess(false);
    }
    return error;
  }
}
