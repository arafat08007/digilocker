import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConditionalImage {
  static ImageFile(String fname) {
    String filename = fname.toLowerCase();
    if (filename == 'docs') {
      return Image.asset("assets/google-docs.png", );
    } else if (filename == 'image') {
      return Image.asset("assets/photo.png");
    } else if (filename == 'pdf') {
      return Image.asset("assets/pdf.png");
    } else if (filename == 'sheets') {
      return Image.asset("assets/google-sheets.png");
    } else if (filename == 'video') {
      return Image.asset("assets/photographic-flim.png");
    }
    else if (filename == 'zip') {
      return Icon(Icons.archive, color: Colors.blue);
    }
    else if (filename == 'passport') {
      return Image.asset("assets/passport.png");
    }
    else if (filename == 'driving licence') {
      return Image.asset("assets/drivingl.png");
    }
    else if (filename == 'citizen chartered') {
      return Image.asset("assets/nid.png");
    }
    else if (filename == 'educational certificate') {
      return Image.asset("assets/educert.png");
    }
    else if (filename == 'medical certificate') {
      return Image.asset("assets/medcert.png");
    }

    else {
      return Icon(FontAwesomeIcons.file, color: Colors.grey,);
    }
  }
}