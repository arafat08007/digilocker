import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Models/Issued.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

void main() {
  runApp(IssuedWidget());
}

class IssuedWidget extends StatelessWidget {
  IssuedWidget({Key key, this.issued}) : super(key: key);

  Issued issued;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return IssuedWidgetPage(issued: issued,);
  }
}

class IssuedWidgetPage extends StatefulWidget {
  IssuedWidgetPage({Key key, this.title, this.issued}) : super(key: key);

  final String title;
  Issued issued;
  @override
  _IssuedWidgetPageState createState() => _IssuedWidgetPageState();
}

class _IssuedWidgetPageState extends State<IssuedWidgetPage> {

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 290,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                            height: 25,
                            width: 20,
                            child: fileImage(widget.issued.fileType),
                        ),
                        SizedBox(width: 30,),
                        Container(
                            width: MediaQuery.of(context).size.width-250,
                            child: Text(widget.issued.fileName, style: TextStyle(fontSize: 14), maxLines: 2,
                              overflow: TextOverflow.ellipsis,)
                        ),
                        SizedBox(width: 30,),
                        fileImage(widget.issued.docmenttype),
                        //Text(widget.issued.docmenttype, style: TextStyle(fontSize: 10, color: Colors.grey),),
                      ],
                    ),
                  ),
                  Container(
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
               // height: 170,
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
                            boundaryMargin: EdgeInsets.all(80),
                            minScale: 0.5,
                            maxScale: 3,
                            child: Image.network(widget.issued.fileImage, fit: BoxFit.cover, width: 340,height: 130,)
                        )
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text('Issued on:'+widget.issued.issued_date+"\t\t\tBy:\t"+widget.issued.issued_from, style: TextStyle(fontSize: 12),),
              ),
              SizedBox(height: 3,),

              SizedBox(height: 3,),

              Divider(color: Colors.grey,height: 2,)
            ],
          ),
        )
    );
  }
}


fileImage(String filename){
  if(filename == 'docs'){
    return Image.asset("assets/google-docs.png");
  }else if(filename == 'image'){
    return Image.asset("assets/photo.png");
  }else if(filename == 'pdf'){
    return Image.asset("assets/pdf.png");
  }else if(filename == 'sheets'){
    return Image.asset("assets/google-sheets.png");
  }else if(filename == 'video'){
    return Image.asset("assets/photographic-flim.png");
  }
  else if(filename == 'zip'){
    return Icon(Icons.archive, color: Colors.blue);
  }
  else if(filename == 'Certificate'){
    return Icon(Icons.new_releases_sharp, color: Colors.black54.withOpacity(0.3));
  }
  else{
    return Icon(Icons.wysiwyg_rounded, color: Colors.red,);
  }

}