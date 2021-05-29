import 'dart:convert';

//import 'package:LoginGetX/Model/ErrorResp.dart';
//import 'package:LoginGetX/Model/LoginResp.dart';
import 'package:googledriveclone_flutter/Models/ErrorResp.dart';
import 'package:googledriveclone_flutter/Models/LoginTokenCreate.dart';
import 'package:googledriveclone_flutter/Models/Loginapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CQAPI {
  static var client = http.Client();
  static var _baseURL = "https://idp-api.eksheba.gov.bd";

  static Future<List> refreshToken({String token}) async {
    try {
      print(_baseURL);
      var response =
      await client.post('$_baseURL/auth/refresh', headers: <String, String>{
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var json = response.body;
        //status is success but not excepted result
        if (json.contains("access_token") == false) {
          return ["", "Unknown Error"];
        }
        var loginRes = loginTokenFromJson(json);
        if (loginRes != null) {
          return [loginRes.token, ""];
        } else {
          return ["", "Unknown Error"];
        }
      } else {
        var json = response.body;
        var errorResp = errorRespFromJson(json);
        if (errorResp == null) {
          return ["", "Unknown Error"];
        } else {
          return ["", errorResp.error];
        }
      }
    }
    catch(e){
      print("Token Refres error"+e.toString());
    }

  }

  static Future<List> createtoken( {String mobile, String password}) async {
    var token;
    print(_baseURL);
    try {
      var response = await client.post('$_baseURL/token/create',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
          jsonEncode(<String, String>{
            "client_id": "ZcwzbhUZgS3hgUKJpiPI",
            "api_key": "33hUO6ZCt3.BTjmjwtuZA"
          }));

      if (response.statusCode == 200) {
        var json = response.body;
        print("Token response: "+json.toString());
        var loginRes = loginTokenFromJson(json);
        if (loginRes != null) {
          token = loginRes.token;
          print("The token\t"+token);
          // return [loginRes.token, ""];
          return loginRequest(token: token, mobile: mobile, password: password);
        } else {
          return ["Error creating token", "Unknown Error"];
        }
      } else {
        var json = response.body;
        var errorResp = errorRespFromJson(json);
        if (errorResp == null) {
          return ["", "Unknown Error"];
        } else {
          return ["", errorResp.error];
        }
      }
    }
    catch(e){
      print("Token create error"+e.toString());
    }
  }

  static Future<List> loginRequest({token, String mobile, String password}) async {
    var userid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print("Token\t $token \t mobile \t $mobile \t pass\t $password");
      var response = await client.post('$_baseURL/user/login',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
          jsonEncode(<String, String>
          {
            "token": "$token",
            "mobile": "$mobile",
            "password": "$password"
          }));

      if (response.statusCode == 200) {
        var json = response.body;
        var loginRes = loginUserFromJson(json);
        if (loginRes != null) {
          userid = loginRes.data.id;
          print(loginRes.toString());
          prefs.setString("userid", ""+loginRes.data.id);
          return [
            loginRes.data.id,
            loginRes.data.email,
            loginRes.data.name,
            loginRes.data.mobile,
            loginRes.data.nid,

          ];
        //  prefs.setString("id", ""+loginRes.data.id);
        } else {
          return ["", "Unknown Error"];
        }
      } else {
        var json = response.body;
        var errorResp = errorRespFromJson(json);
        if (errorResp == null) {
          return ["", "Unknown Error"];
        } else {
          return ["", errorResp.error];
        }
      }
    }
    catch(e){
      print("Login request error"+e.toString());
    }
  }

}