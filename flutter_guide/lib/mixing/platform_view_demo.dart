import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// desc:
///

class PlatformViewDemo extends StatefulWidget {
  @override
  _PlatformViewDemoState createState() => _PlatformViewDemoState();
}

class _PlatformViewDemoState extends State<PlatformViewDemo> {
  var platforms = [];
  var platform = MethodChannel('com.flutter.guide.MyFlutterView');
  var _data = '获取数据';

  @override
  Widget build(BuildContext context) {
    Widget platformView() {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return AndroidView(
          viewType: 'plugins.flutter.io/custom_platform_view',
          onPlatformViewCreated: (viewId) {
            print('viewId:$viewId');
            platforms
                .add(MethodChannel('com.flutter.guide.MyFlutterView_$viewId'));
          },
          creationParams: {'text': 'Flutter传给AndroidTextView的参数'},
          creationParamsCodec: StandardMessageCodec(),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return UiKitView(
          viewType: 'plugins.flutter.io/custom_platform_view',
          onPlatformViewCreated: (viewId) {
            print('viewId:$viewId');
            platforms
                .add(MethodChannel('com.flutter.guide.MyFlutterView_$viewId'));
          },
          creationParams: {'text': 'Flutter传给IOSTextView的参数'},
          creationParamsCodec: StandardMessageCodec(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Row(
          children: [
            RaisedButton(
              child: Text('传递参数给原生View'),
              onPressed: () {
                platforms[0]
                    .invokeMethod('setText', {'name': 'laomeng', 'age': 18});
//                platform.invokeMethod('setText', {'name': 'laomeng', 'age': 18});
              },
            ),
            RaisedButton(
              child: Text('$_data'),
              onPressed: () async {
                var result = await platform
                    .invokeMethod('getData', {'name': 'laomeng', 'age': 18});
                setState(() {
                  _data = '${result['name']},${result['age']}';
                });
              },
            ),
          ],
        ),
        Expanded(child: Container(color: Colors.red, child: platformView())),
        Expanded(child: Container(color: Colors.blue, child: platformView())),
        Expanded(child: Container(color: Colors.yellow, child: platformView())),
      ]),
    );
  }
}
