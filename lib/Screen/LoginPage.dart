
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Screen/signup_screen.dart';
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
                  Image.asset("assets/digi_locker.png" , width: MediaQuery.of(context).size.width-50,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Text('All Documents in One Place  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor,), ),
                  SizedBox(height: 1,),

                  Text('Access & Share your documents anytime anywhere  ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: kPrimaryColor.withOpacity(0.7))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  RoundedInputField(
                    icon: Icons.person,
                    simpleinputctrl:_userIdCntrl,
                    hintText: "email / mobile phone / NID",
                    onChanged: (value) {
                      print(_userIdCntrl.text.toString());
                    },
                  ),
                  RoundedPasswordField(
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
                    press: () {

                      print(_userIdCntrl.text+"<>"+_userPassCntrl.text);
                      var userid= _userIdCntrl.text.toString().trim();
                      var uesrpass = _userPassCntrl.text.toString().trim();
                      if(userid.toLowerCase()=='admin'.toLowerCase() && uesrpass.toLowerCase()=='admin'.toLowerCase()) {
                        showSnackMessage(context, "Login in , please wait...", _globalscaffoldKey,'');
                     //   Get.to(HomePage());
                        Get.to(() => HomePage());
                      }
                      else showSnackMessage(context, "Login credential mismatch! Try again.", _globalscaffoldKey,'red');
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Get.to(SignUpScreen());

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
