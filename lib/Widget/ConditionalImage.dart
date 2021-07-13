import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConditionalImage {
  static ImageFile(String fname) {
    String filename = fname.toLowerCase();
    if (filename == 'doc') {
      return Icon(FontAwesomeIcons.fileWord, color: Colors.blue);
    } else if (filename == 'image') {
      return Icon(FontAwesomeIcons.fileImage, color: Colors.blue);
    } else if (filename == 'pdf') {
      return Icon(FontAwesomeIcons.filePdf, color: Colors.blue);
    } else if (filename == 'sheet') {
      return Icon(FontAwesomeIcons.fileExcel, color: Colors.blue);
    } else if (filename == 'video') {
      return Icon(FontAwesomeIcons.fileVideo, color: Colors.blue);
    }
    else if (filename == 'zip') {
      return Icon(Icons.archive, color: Colors.blue);
    }
    else if (filename == 'ppt') {
      return Icon(FontAwesomeIcons.filePowerpoint, color: Colors.blue);
    }
    else if (filename == 'note') {
      return Icon(FontAwesomeIcons.solidFile, color: Colors.blue);
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
    else if (filename == 'not') {
      return Image.asset("assets/notes.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else if (filename == 'noc') {
      return Image.asset("assets/noccertifiacate.png",width: 28, height: 28, alignment: Alignment.center);
    }
    else {
      return Image.asset("assets/unknownfile.png",width: 28, height: 28, alignment: Alignment.center);
    }
  }
}