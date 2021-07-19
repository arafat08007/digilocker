import 'package:get/state_manager.dart';
import 'package:googledriveclone_flutter/Models/Loginapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CQAPI.dart';


class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";


  Future<String> login({String mobile, String password}) async {
    error = "";
    try {
      loginProcess(true);
      List loginResp = await CQAPI.createtoken(mobile: mobile, password: password);
      print('Login api response: '+loginResp.toString());
      if (loginResp.length>0) {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("id", loginResp[0]);
      //  prefs.setString("photo", loginResp[14]);
      //  print('image response'+loginResp[5]);




      } else {
        error = loginResp[1];
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

  Future<bool> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (token == null) {
      return false;
    }

    bool success = false;
    try {
      loginProcess(true);
      List loginResp = await CQAPI.refreshToken(token: token);
      if (loginResp[0] != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginResp[0]);
        success = true;
      }
    } finally {
      loginProcess(false);
    }
    return success;
  }
}