import 'package:flutter/cupertino.dart';
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
       padding: EdgeInsets.only(left: 10, right: 5,),
     //padding: EdgeInsets.all(5),
        child: Container(

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          padding: EdgeInsets.only( bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.file.isFolder) Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: Container(
                    padding: EdgeInsets.only(top: 5, left: 25, right: 15, bottom: 20),
                    child: Icon(Icons.folder, size: 80, color: Colors.grey[500],)
                ),
              ) else Container(
                margin: EdgeInsets.only(top: 10),
                height: 55,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.grey[200]
                ),
                child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Align(
                        alignment: Alignment.center,
                        child: InteractiveViewer(
                            panEnabled: false, // Set it to false
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 3,
                            child: Image.network(widget.file.fileImage, fit: BoxFit.contain)
                        )
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                        height: 22,
                        width: 18,
                        padding: EdgeInsets.only(right: 5),
                        child: fileImage(widget.file.fileType)
                    ),
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Text(widget.file.fileName, style: TextStyle(fontSize: 10),  maxLines: 3,
                            overflow: TextOverflow.ellipsis,)
                      ),
                    ),
                    Container(
                      child: Icon(Icons.more_vert, color: Colors.grey,),
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


