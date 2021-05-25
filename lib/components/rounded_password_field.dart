import 'package:flutter/material.dart';


import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController simplepassctrl;
  bool showhide ;
  final ValueChanged<bool> showhideChanged;
  bool isEnable;

   RoundedPasswordField({
    Key key,
    this.onChanged,
    this.showhide,
    this.simplepassctrl,
     this.showhideChanged,
     this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: isEnable,
        controller: simplepassctrl,
        obscureText: showhide,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
              
            ),
            onPressed: (){
              showhideChanged;
              print("status"+showhide.toString());
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}