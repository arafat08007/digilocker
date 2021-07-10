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
    else if (filename == 'pp') {
      return Image.asset("assets/passport.png", width: 28, height: 28, alignment: Alignment.center,);
    }
    else if (filename == 'drl') {
      return Image.asset("assets/drivingl.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else if (filename == 'cic') {
      return Image.asset("assets/nid.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else if (filename == 'edc') {
      return Image.asset("assets/educert.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else if (filename == 'mec') {
      return Image.asset("assets/medcert.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else if (filename == 'odo') {
      return Image.asset("assets/otherdocs.png",width: 28, height: 28, alignment: Alignment.center);
    }


    else {
      return Icon(FontAwesomeIcons.file, color: Colors.grey,);
    }
  }
}