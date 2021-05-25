import 'package:folder_file_saver/folder_file_saver.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:dio/dio.dart';

class fileOrgnizer {
  String progress = "0";
  bool _isLoading = false;
   var urlVideo =
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      urlImage =
          'https://images.unsplash.com/photo-1576039716094-066beef36943?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  urlDoc ;
  Dio dio;
  fileOrgnizer(this.progress, this._isLoading, this.urlImage, this.urlVideo, this.urlDoc);

  void _saveImage() async {
    try {


      // 0 permission is PERMISSION_GRANTED
      // 1 permission is PERMISSION_DENIED
      // 2 permission is PERMISSION_DENIED wuth (don't ask again)
      final resultPermission = await FolderFileSaver.requestPermission();

      if (resultPermission == 2) {
        // Do Something Info Here To User
        // await FolderFileSaver.openSetting;
      }

      // Permission Granted
      if (resultPermission == 0) {
        await _doSaveImage();
      }
    } catch (e) {
      print(e.toString());
    } finally {

    }
  }

  void _saveFolderFileExt() async {
    try {

      // if you want check permission user
      // use like that
      // if return 0 permission is PERMISSION_GRANTED
      // if return 1 permission is PERMISSION_IS_DENIED
      // if return 2 permission is PERMISSION_IS_DENIED with click don't ask again
      final resultPermission = await FolderFileSaver.requestPermission();

      // 2 permission is PERMISSION_IS_DENIED with click don't ask again
      if (resultPermission == 2) {
        // Do Something Info Here To User
        // await FolderFileSaver.openSetting;
      }

      // 1 permission is PERMISSION_IS_DENIED
      if (resultPermission == 1) {
        // Do Something Here
      }

      // 0 permission is PERMISSION_GRANTED
      if (resultPermission == 0) {
        await _doSave();
      }
    } catch (e) {
      print(e.toString());
    } finally {

    }
  }

  Future<void> _doSaveImage() async {
    final dir = await p.getTemporaryDirectory();
    final pathImage = dir.path + ('example_image.png');
    await dio.download(urlImage, pathImage, onReceiveProgress: (rec, total) {
      //setState(() {
      //  progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      //});
    });
    // if you want to get original of Image
    // don't give a value of width or height
    // cause default is return width = 0, height = 0
    // which will make it to get the original image
    // just write like this
    final result = await FolderFileSaver.saveImage(pathImage: pathImage);
    print(result);
  }

  Future<void> _doSave() async {
    final dir = await p.getTemporaryDirectory();
    // prepare the file and type extension that you want to download
    final filePath = dir.path + ('example_video.mp4');
    await dio.download(urlVideo, filePath, onReceiveProgress: (rec, total) {
      //setState(() {
       // progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
     // });
    });
    final result = await FolderFileSaver.saveFileToFolderExt(filePath);
    print(result);
  }

  // Don't forget to check
  // device permission
  void saveFile() async {
    String result;
    final dir = await p.getTemporaryDirectory();
    // prepare the file and type extension that you want to download
    final filePath = dir.path + ('example_video.mp4');
    try {
      await dio.download(urlVideo, filePath);
      result = await FolderFileSaver.saveFileToFolderExt(filePath);
    } catch (e) {
      result = e;
    }
    print(result);
  }

  // Don't foreget check your permission
  void copyFileToNewFolder() async {
    //setState(() {
    //  _isLoading = true;
  //  });
    // get your path from your device your device
    final fileToCopy = '/storage/emulated/0/DCIM/Camera/20200102_202226.jpg';
    try {
      await FolderFileSaver.saveFileToFolderExt(fileToCopy);
    } catch (e) {
      print(e);
    }
    //setState(() {
     // _isLoading = false;
    //});
  }
}
