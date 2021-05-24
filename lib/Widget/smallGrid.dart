import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';

import 'constants.dart';

void main() {
  runApp(SmallGridWIdget());
}

class SmallGridWIdget extends StatelessWidget {
  // This widget is the root of your application.
  SmallGridWIdget({Key key, this.file}) : super(key: key);

  Files file;
  @override
  Widget build(BuildContext context) {
    return SmallGridWIdgetPage(file: file,);
  }
}

class SmallGridWIdgetPage extends StatefulWidget {
  SmallGridWIdgetPage({Key key, this.title, this.file}) : super(key: key);

  final String title;
  Files file;

  @override
  _SmallGridWIdgetPageState createState() => _SmallGridWIdgetPageState();
}

class _SmallGridWIdgetPageState extends State<SmallGridWIdgetPage> {

  @override
  Widget build(BuildContext context) {

    return Container(
      //color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10,),
        child: Container(
         // height: 250,
          //color: kPrimaryLightColor,
          padding: EdgeInsets.only( bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.file.isFolder?
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                child: Container(
                    padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
                    child: Icon(Icons.folder, size: 100, color: Colors.grey[500],)
                ),
              )
              :
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                ),
                child: Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InteractiveViewer(
                            panEnabled: false, // Set it to false
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 3,
                            child: Image.network(widget.file.fileImage, fit: BoxFit.cover,)
                        )
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                        height: 25,
                        width: 20,
                        child: fileImage(widget.file.fileType)
                    ),
                    Container(
                        child: Text(widget.file.fileName, style: TextStyle(fontSize: 10),)
                    ),
                    Container(
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}


