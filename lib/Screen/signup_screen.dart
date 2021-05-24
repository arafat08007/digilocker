import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'package:googledriveclone_flutter/components/RoundedButton.dart';
import 'package:googledriveclone_flutter/components/already_have_an_account_acheck.dart';
import 'package:googledriveclone_flutter/components/rounded_input_field.dart';


class SignUpScreen extends StatelessWidget {
  TextEditingController _userphoneCntrl = TextEditingController();
  TextEditingController _useremailCntrl = TextEditingController();
  TextEditingController _usernameCntrl = TextEditingController();
  final _globalscaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalscaffoldKey,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/digi_locker.png" , width: MediaQuery.of(context).size.width-50,),

                Text(
                  "Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: size.height * 0.02),
                RoundedInputField(
                  icon: Icons.phone,
                  simpleinputctrl: _userphoneCntrl,
                  hintText: "Your mobile number",
                  onChanged: (value) {
                    print(_userphoneCntrl.text.toString());
                  },
                ),
                SizedBox(height: size.height * 0.01),
                RoundedInputField(
                  icon: Icons.email_outlined,
                  simpleinputctrl: _useremailCntrl,
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.01),
                RoundedInputField(
                  icon: Icons.short_text,
                  simpleinputctrl: _usernameCntrl,
                  hintText: "Your Full Name",
                  onChanged: (value) {},
                ),

                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    print(_useremailCntrl.text+""+_usernameCntrl.text+""+_userphoneCntrl.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Get.to(LoginPage());
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Image.asset('assets/govt_logo.png'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}