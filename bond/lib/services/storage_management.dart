import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

class StorageManagement {
  static Future<String> makeDirectory({required String dirName}) async {
    final Directory? directory = await getExternalStorageDirectory();

    final _formattedDirName = '/$dirName/';

    final Directory _newDir =
    await Directory(directory!.path + _formattedDirName).create();

    return _newDir.path;
  }

  static get getAudioDir async => await makeDirectory(dirName: 'recordings');


  //val timeStamp = SimpleDateFormat("yyyyMMDD_HHmmss", Locale.US).format(Date())
  //val imageFileName = "JPEG_${timeStamp}_"
  static String createRecordAudioPath({required String dirPath, required String fileName}) {
    String timeStamp = DateTime.now().toString().replaceAll(" ", "_");
    return """$dirPath${fileName.substring(0, min(fileName.length, 100))}_${timeStamp}.aac""";
  }
}