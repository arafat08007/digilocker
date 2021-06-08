// dart
import 'dart:io';

// framework
import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

// packages
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as pathlib;

// app files
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/core.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_popup_menu.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/search.dart';
import 'package:googledriveclone_flutter/deviceexplorer/notifiers/preferences.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/create_dialog.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/file.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/folder.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/filesystem_utils.dart' as filesystem;
import 'package:googledriveclone_flutter/deviceexplorer//ui/widgets/context_dialog.dart';
import 'package:googledriveclone_flutter/deviceexplorer/helpers/io_extensions.dart';
import 'package:googledriveclone_flutter/deviceexplorer/ui/widgets/appbar_path_widget.dart';

class FolderListScreen extends StatefulWidget {
  final String path;
  const FolderListScreen({@required this.path}) : assert(path != null);
  @override
  _FolderListScreenState createState() => _FolderListScreenState();
}

class _FolderListScreenState extends State<FolderListScreen>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final preferences = Provider.of<PreferencesNotifier>(context);
    var coreNotifier = Provider.of<CoreNotifier>(context);
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 100))
                .then((_) => setState(() {}));
          },
          // It is better solution for `NestedScrollView` to be wrapped in `RefreshIndicator` widget
          child: NestedScrollView(
            headerSliverBuilder: (context, val) => [
              SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: Colors.white,
                brightness: Theme.of(context).brightness,

                leading: BackButton(
                    color: kPrimaryColor,
                    onPressed: () {
                  if (coreNotifier.currentPath.absolute.path ==
                      pathlib.separator) {
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  } else {
                    coreNotifier.navigateBackdward();
                  }
                }),
                title: Text('File Explorer'),
                centerTitle: true,
                actions: <Widget>[

                  IconButton(
                    icon: Icon(Icons.search, color: kPrimaryColor,),
                    onPressed: () => showSearch(
                        context: context, delegate: Search(path: widget.path)),
                  ),
                  AppBarPopupMenu(path: coreNotifier.currentPath.absolute.path)
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(4.0),
                      padding: EdgeInsets.only(left:10,bottom: 5),
                      child: AppBarPathWidget(
                        onDirectorySelected: (dir) {
                          coreNotifier.navigateToDirectory(dir.absolute.path);
                        },
                        path: coreNotifier.currentPath.absolute.path,
                      )),
                ),
              ),
            ],
            body:
            Consumer<CoreNotifier>(
              builder: (context, model, child) =>
                  StreamBuilder<List<FileSystemEntity>>(
                // This function Invoked every time user go back to the previous directory
                stream: filesystem.fileStream(model.currentPath.absolute.path,
                    keepHidden: preferences.hidden),

                builder: (BuildContext context,
                    AsyncSnapshot<List<FileSystemEntity>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(child: Text('Press button to start.'));
                    case ConnectionState.active:
                      return Container(width: 0.0, height: 0.0);
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        if (snapshot.error is FileSystemException) {
                          return Center(child: Text("Permission Denied"));
                        }
                      } else if (snapshot.data.length != 0) {
                        debugPrint(
                            "FolderListScreen -> Folder Grid: data length = ${snapshot.data.length} ");
                        return GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: _scrollController,
                            key: PageStorageKey(widget.path),
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              // folder
                              if (snapshot.data[index] is Directory) {
                                return FolderWidget(
                                    path: snapshot.data[index].path,
                                    name: snapshot.data[index].basename());
                                // file
                              } else if (snapshot.data[index] is File) {
                                return FileWidget(
                                  name: snapshot.data[index].basename(),
                                  onTap: () {
                                    _printFuture(OpenFile.open(
                                        snapshot.data[index].path));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => FileContextDialog(
                                              path: snapshot.data[index].path,
                                              name: snapshot.data[index]
                                                  .basename(),
                                            ));
                                  },
                                );
                              }
                              return Container();
                            });
                      } else {
                        return Center(
                          child: Text("Empty Directory!"),
                        );
                      }
                  }
                  return null; // unreachable
                },
              ),
            ),
          ),
        ),

        // check if the in app floating action button is activated in settings
        floatingActionButton: StreamBuilder<bool>(
          stream: preferences.showFloatingButton, //	a	Stream<int>	or	null
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasError) return Text('Error:	${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Select	lot');
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return FolderFloatingActionButton(
                  enabled: snapshot.data,
                  path: widget.path,
                );
              case ConnectionState.done:
                FolderFloatingActionButton(enabled: snapshot.data);
            }
            return null;
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

_printFuture(Future<String> open) async {
  print("Opening: " + await open);
}

class FolderFloatingActionButton extends StatelessWidget {
  final bool enabled;
  final String path;
  const FolderFloatingActionButton({Key key, this.enabled, this.path})
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
