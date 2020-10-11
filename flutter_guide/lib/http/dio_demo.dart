import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

///
/// desc:
///

class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  String _data;

  getData() async {
    CancelToken cancelToken = CancelToken();

//    Response response=await Dio().get('https://xxx.com/test?name=\'laomeng\'&page=1');

//    Response response = await Dio().post("https://xxx.com/test",
//        queryParameters: {'name': 'laomeng', 'page': 1},
//        cancelToken: cancelToken);

    cancelToken.cancel();
    var formData = FormData.fromMap({
      'name': 'laomeng',
      'file':
          await MultipartFile.fromFile("./text.txt", filename: "upload.txt"),
      'files': [
        await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
        await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
      ]
    });

    Response response = await Dio().post(
      'https://xxx.com/test',
      data: formData,
    );

    response = await Dio().post(
      'https://xxx.com/test',
      data: formData,
      onSendProgress: (int sent, int total) {
        print("$sent $total");
      },
    );

    print(response.data.toString());

    setState(() {
      _data = response.data.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DioDemo'),
      ),
      body: Center(
        child: Text('$_data'),
      ),
    );
  }
}
