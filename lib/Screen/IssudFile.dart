
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Data/Issued.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Widget/issued.dart';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
void main() {
  runApp(MyIssuedDocScreenPage());
}



class MyIssuedDocScreenPage extends StatefulWidget {
  MyIssuedDocScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyIssuedDocScreenPageState createState() => _MyIssuedDocScreenPageState();
}

class _MyIssuedDocScreenPageState extends State<MyIssuedDocScreenPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  _SupportState _supportState = _SupportState.unknown;
  var isAuth;
  @override
  void initState() {

    auth.isDeviceSupported().then(
          (isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),

    );
    // ignore: unnecessary_statements
    isAuth =_authenticateWithBiometrics;
    print("Authorized:\t"+isAuth.toString());
    super.initState();
  }


  //Finger print authorization

  Future<void> _checkBiometrics() async {
     bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
     List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }



  @override
  Widget build(BuildContext context) {

    return Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          if (_supportState == _SupportState.unknown)
              CircularProgressIndicator( color: kPrimaryLightColor, ),
          //else if (_supportState == _SupportState.supported)
          //  Text("This device is supported")
        //  else
          //  Text("This device is not supported"),

          Text('Issued documents',style: TextStyle(color: Colors.black54,fontSize: 18, fontWeight: FontWeight.bold),),

          Divider(height: 20),

          Expanded(
            child: ListView.builder(
                itemCount: issues.length,
                itemBuilder: (context, index){
                  return Container(

                    // ignore: unrelated_type_equality_checks
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    //child: (_authorized==true)? IssuedWidget(issued: issues[index],):Text('Need to authorized first'),
                    child:  IssuedWidget(issued: issues[index],)
                  );
                }
            ),
          )]
    );
  }
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}