import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/components/text_field_container.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController simpleinputctrl ;
  final ValueChanged<String> onChanged;
  bool isEnable;
   RoundedInputField({
    Key key,
    this.hintText,
    this.icon ,
    this.onChanged,
    this.simpleinputctrl ,
     this.isEnable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: isEnable,
        controller: simpleinputctrl,
        onChanged: onChanged,

        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}