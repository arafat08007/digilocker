// framework
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

// app
import 'package:googledriveclone_flutter/deviceexplorer/screens/folder_list_screen.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/context_dialog.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:provider/provider.dart';

class FolderWidget extends StatelessWidget {
  final String path;
  final String name;
  final String colorname;

  const FolderWidget({@required this.path, @required this.name, this.colorname});
  @override
  Widget build(BuildContext context) {
    var coreNotifier = Provider.of<CoreNotifier>(context, listen: false);
    return Container(
        child: InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => FolderListScreen(path: path)));
        coreNotifier.navigateToDirectory(path);
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => FolderContextDialog(
                  path: path,
                  name: name,

                ));
      },
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(
          Icons.folder,
          size: 50.0,
          color: kPrimaryColor,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 11.5),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ]),
    ));
  }
}
