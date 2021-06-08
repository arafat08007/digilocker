import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/create_dialog.dart';
import 'package:provider/provider.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart' as filesystem;
class createFolder extends StatelessWidget {
  final bool enabled;
  final String path;
  const createFolder({Key key, this.enabled, this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coreNotifier = Provider.of<CoreNotifier>(context);

    if (enabled == true) {
      return FloatingActionButton(
        tooltip: "Create Folder",
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => CreateDialog(
              path: coreNotifier.currentPath.absolute.path,
              onCreate: (path) {
                filesystem.createFolderByPath(path);
                coreNotifier.reload();
              },
            )),
      );
    } else
      return Container(
        width: 0.0,
        height: 0.0,
      );
  }
}