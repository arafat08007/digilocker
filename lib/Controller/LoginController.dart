import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CQAPI.dart';


class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";

  Future<String> login({String email, String password}) async {
    error = "";
    try {
      loginProcess(true);
      List loginResp = await CQAPI.createtoken(email: email, password: password);
      if (loginResp[0] != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("id", loginResp[0]);
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