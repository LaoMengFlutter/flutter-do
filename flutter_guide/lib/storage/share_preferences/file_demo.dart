import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///
/// des:
///
class FileDemo extends StatefulWidget {
  @override
  _FileDemoState createState() => _FileDemoState();
}

class _FileDemoState extends State<FileDemo> {
  String _content = '';

  _createDir() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}${Platform.pathSeparator}dirName';
    var dir = Directory(path);
    var exist = dir.existsSync();
    if (exist) {
      print('当前文件夹已经存在');
    } else {
      var result = await dir.create();
      print('$result');
    }

    var dir2 = await Directory(
            '${documentsDirectory.path}${Platform.pathSeparator}dir1${Platform.pathSeparator}dir2${Platform.pathSeparator}')
        .create(recursive: true);
    print('$dir2');
  }

  _dirList() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}${Platform.pathSeparator}dirName';

    Stream<FileSystemEntity> fileList = Directory(path).list();

    await for (FileSystemEntity fileSystemEntity in fileList) {
      print('$fileSystemEntity');
      FileSystemEntityType type =
          FileSystemEntity.typeSync(fileSystemEntity.path);
    }
  }

  _dirRename() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}${Platform.pathSeparator}dirName';
    var dir = Directory(path);
    var dir3 = await dir
        .rename('${dir.parent.absolute.path}${Platform.pathSeparator}dir3');
  }

  _deleteDir() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}${Platform.pathSeparator}dir3';
    var dir = await Directory(path).delete();
  }

  _createFile() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =
        '${documentsDirectory.path}${Platform.pathSeparator}dirName${Platform.pathSeparator}file.txt';

    var file = await File(path).create(recursive: true);

//    file.writeAsString('老孟 Flutter');

//    file.writeAsBytes(Utf8Encoder().convert("老孟 Flutter bytes 格式"));

//    file.openWrite(mode: FileMode.append).write('老孟 Flutter 追加到末尾');

    List<String> lines = await file.readAsLines();
    lines.forEach((element) {
      print('$element');
    });

//    Utf8Decoder().convert(await file.readAsBytes());

    file.delete();
  }

  _loadAsset(BuildContext context) async{
    var jsonStr = await DefaultAssetBundle.of(context)
        .loadString('assets/json/data.json');
    var list = json.decode(jsonStr);
    list.forEach((element) {
      print('$element');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            maxLines: 10,
          ),
          RaisedButton(
            child: Text('写入文件'),
            onPressed: () {
              _createFile();
            },
          ),
          RaisedButton(
            child: Text('读取文件'),
            onPressed: () {
              _loadAsset(context);
            },
          ),
          Text('$_content'),
        ],
      ),
    );
  }
}
