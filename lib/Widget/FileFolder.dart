import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledriveclone_flutter/Models/Files.dart';
import 'package:googledriveclone_flutter/Widget/ConditionalImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
class FileFolderTile extends StatelessWidget {
  final Files files;
  const FileFolderTile(this.files);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          /*  Stack(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    files.fileImage,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(Icons.more_vert),

                )
              ],
            ),*/
            SizedBox(height: 8),
            Row (
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              files.isFolder? Icon(Icons.folder) : ConditionalImage.ImageFile(files.fileType),
                AutoSizeText(files.fileName,  maxLines: 3,
                  overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12),),
            ],),
            SizedBox(height: 8),
            Row (
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${files.numofrecord} Files'),
                Text('${files.size}'),
              ],),




          ],
        ),
      ),
    );
  }
}