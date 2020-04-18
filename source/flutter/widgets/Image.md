---
title: 'Image'
description: '控件介绍'
type: widgets

---



# 1、加载网络图片

```
Image.network(
          'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg',
          width: 200,
          height: 200,
        )
```
# 2、加载本地图片
## 1、设置pubspec.yaml 
![在这里插入图片描述](https://img-blog.csdnimg.cn/20181210210748635.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)

在pubspec.yaml 文件中添加assets，如上图，注意images的路径。
如果我有100张图片pubspec.yaml 要设置100次？当然不需要，只需写图片目录即可，注意后面加上"/"，如下：
```
assets:
    - images/
```

## 2、Image.asset 加载

```
Image.asset('images/1.png',
        width: 300,
        height: 160,)
```
# 3、加载sd卡上的图片
## 1、通过path_provider获取本地路径 
path_provider是第三方库，在 pubspec.yaml中添加依赖：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2018121021281587.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)
添加后点击右上角的Packages get.

path_provider有2个接口：

```
Directory tempDir = await getTemporaryDirectory();
String tempPath = tempDir.path;

Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path;

String storageDir = (await getExternalStorageDirectory()).path;
```
对于android来说：
appDocDir：/data/user/0/com.example.fluttersample/app_flutter
tempDir：/data/user/0/com.example.fluttersample/cache
storageDir：/storage/emulated/0/
storageDir就是sd卡的路径,加载sd卡图片需要读写权限，在AndroidManifest.xml中添加：

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```
如图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2018121022242457.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)
添加成功后用Android studio单独打开android 工程，build->rebuild project，由于flutter没有添加获取权限的功能，在设置界面手动打开读写权限，在sd卡根目录下放一张图片加载

```
Image.file(
          File('$_storageDir/1.png'),
          width: 300,
          height: 160,
        )
```

完整的代码：

```
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageFileDemo();
  }
}

class ImageFileDemo extends State<ImageDemo> {
  String _storageDir = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _getLocalFile();
    return Column(
      children: <Widget>[
        Image.network(
          'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg',
          width: 200,
          height: 200,
        ),
        Image.asset(
          'images/1.png',
          width: 300,
          height: 160,
        ),
        Image.asset(
          'images/2.png',
          width: 300,
          height: 160,
        ),
        Image.file(
          File('$_storageDir/1.png'),
          width: 300,
          height: 160,
        ),
      ],
    );
  }

  _getLocalFile() async {
    String appDir = (await getApplicationDocumentsDirectory()).path;
    String tempDir = (await getTemporaryDirectory()).path;
    String storageDir = (await getExternalStorageDirectory()).path;
    setState(() {
      _storageDir = storageDir;
    });
    return storageDir;
  }
}

```
此时将会加载出sd卡上的图片
注意getExternalStorageDirectory 在ios设备上是抛出异常的，下面是path_provider的getExternalStorageDirectory方法源码：

```
Future<Directory> getExternalStorageDirectory() async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final String path = await _channel.invokeMethod('getStorageDirectory');
  if (path == null) {
    return null;
  }
  return new Directory(path);
}

```

# 4、几个常用的属性
## 1、fit
参考Android imageview 的scaleType
||  |
|--|--|
| fill | 完全填充，宽高比可能会变 |
| contain | 等比拉伸，直到一边填充满 |
| cover | 等比拉伸，直到2边都填充满，此时一边可能超出范围 |
|fitWidth  | 等比拉伸，宽填充满 |
|fitHeight  | 等比拉伸，高填充满 |
|  none|  不拉伸，超出范围截取|
|  scaleDown| 只缩小，等比 |

## 2、colorBlendMode

和color做融合，感觉用到的机会不多，用到的时候在看具体说明:[https://docs.flutter.io/flutter/dart-ui/BlendMode-class.html










