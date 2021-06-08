import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Screen/LoginPage.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Image.asset("assets/digi_locker.png" , width: MediaQuery.of(context).size.width-50,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Text('All Documents in One Place  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor,), ),
                SizedBox(height: 1,),

                Text('Access & Share your documents anytime anywhere  ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: kPrimaryColor.withOpacity(0.7))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

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
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return LoginPage();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}