
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Controller/AppController.dart';

import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Screen/signup_screen.dart';
import 'package:googledriveclone_flutter/Widget/CustomDialog.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/components/RoundedButton.dart';
import 'package:googledriveclone_flutter/components/already_have_an_account_acheck.dart';
import 'package:googledriveclone_flutter/components/rounded_input_field.dart';
import 'package:googledriveclone_flutter/components/rounded_password_field.dart';

void main() {

  runApp(MaterialApp(home: LoginPage()));
}

class LoginPage extends StatelessWidget {
  TextEditingController _userIdCntrl = TextEditingController();
  TextEditingController _userPassCntrl = TextEditingController();
  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
 // final LoginController _login_controller = Get.put(LoginController());

  final Appcontroller _myLockerController = Get.put(Appcontroller());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _globalscaffoldKey,

      body: SafeArea(
          child: SingleChildScrollView(
            reverse: false,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 15,),
                  Image.asset("assets/logo.png" , width: MediaQuery.of(context).size.width-200,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Text('All Documents in One Place  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor,), ),
                  SizedBox(height: 1,),

                  Text('Access & Share your documents anytime anywhere  ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: kPrimaryColor.withOpacity(0.7))),

                  Divider(height: 20, color: kPrimaryLightColor,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  RoundedInputField(
                    icon: Icons.person,
                    isEnable: !_myLockerController.loginProcess.value,
                    simpleinputctrl:_userIdCntrl,
                    hintText: "email / mobile phone / NID",
                    onChanged: (value) {
                      print(_userIdCntrl.text.toString());
                    },
                  ),
                  RoundedPasswordField(
                    isEnable: !_myLockerController.loginProcess.value,
                    simplepassctrl:_userPassCntrl,
                    showhide: true,
                    showhideChanged: (value){
                      return false;
                    },
                    onChanged: (value) {
                      print(_userPassCntrl.text.toString());
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {
                      try {
                        if (_userIdCntrl.text
                            .toString()
                            .isEmpty) {
                          showSnackMessage(
                              context, "email/NID/phone field is empty.",
                              _globalscaffoldKey, 'red');
                          return;
                        }
                        else if (_userPassCntrl.text
                            .toString()
                            .isEmpty) {
                          showSnackMessage(
                              context, "Password field is empty",
                              _globalscaffoldKey, 'red');
                          return;
                        }
                        else {
                          showSnackMessage(context,
                              "Login in , please wait...",
                              _globalscaffoldKey, '');

                          String error = await _myLockerController.login(
                              mobile: _userIdCntrl.text.toString(),
                              password: _userPassCntrl.text.toString());
                          print("Login button pressed" + error.toString());

                          if (error != "") {
                            showSnackMessage(
                                context,
                                "Login credential mismatch! Try again.",
                                _globalscaffoldKey, 'red');
                            //Get.defaultDialog(
                            //  title: "Oop!", middleText: error);
                          } else {

                           // Get.offAll(HomePage());
                          //  CustomDialogBox(title: 'API response', descriptions: error.toString(),);

                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                HomePage()), (Route<dynamic> route) => false);
                          }
                        }
                      }
                      catch(e){
                        print("Login button pressed Error" + e.toString());
                        showSnackMessage(
                            context, "Login credential mismatch! Try again.",
                            _globalscaffoldKey, 'red');
                      }
                    }
                    ,

                     /* print(_userIdCntrl.text+"<>"+_userPassCntrl.text);
                      var userid= _userIdCntrl.text.toString().trim();
                      var uesrpass = _userPassCntrl.text.toString().trim();
                      if(userid.toLowerCase()=='admin'.toLowerCase() && uesrpass.toLowerCase()=='admin'.toLowerCase()) {
                        showSnackMessage(context, "Login in , please wait...", _globalscaffoldKey,'');
                     //   Get.to(HomePage());
                        Get.to(() => HomePage());
                      }
                      else showSnackMessage(context, "Login credential mismatch! Try again.", _globalscaffoldKey,'red');
                    },*/
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                              Animation secondaryAnimation) {
                            return SignUpScreen();
                          }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                              Animation<double> secondaryAnimation, Widget child) {
                            return new SlideTransition(
                              position: new Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          }),
                              (Route route) => false);

                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Expanded(child: Image.asset('assets/govt_logo.png')),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  //Image.asset('assets/orange_logo.png'),


                ],
              ),

              ),
          ),


      ),
    );

  }
}
