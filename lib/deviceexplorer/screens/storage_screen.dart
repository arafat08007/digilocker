// dart
import 'dart:io';

// framework
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:flutter/material.dart';

// packages
import 'package:path_provider/path_provider.dart';

// app
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart';
import 'package:googledriveclone_flutter/deviceexplorer/screens/folder_list_screen.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_popup_menu.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart' as filesystem;
import 'package:provider/provider.dart';

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    var coreNotifier = Provider.of<CoreNotifier>(context, listen: false);

    return Scaffold(

      body: FutureBuilder<List<FileSystemEntity>>(
        future:
            getStorageList(), // a previously-obtained Future<String> or null
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                value: 10,
              ));
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, int position) {
                  return Card(
                    elevation: 1,
                    shadowColor: kPrimaryLightColor,
                    child: ListTile(
                      leading: Icon(Icons.sd_storage_rounded),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: Text(snapshot.data[position].absolute.path),
                      subtitle: Text("Size: ${snapshot.data[position].statSync().size}"),
                      dense: true,
                      onTap: () {
                        coreNotifier.currentPath =
                            Directory(snapshot.data[position].absolute.path);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FolderListScreen(
                                    path: snapshot
                                        .data[position].absolute.path)));
                      },
                    ),
                  );
                },
              );
          }
          return null; //unreachable
        },
      ),
    );
  }
}
