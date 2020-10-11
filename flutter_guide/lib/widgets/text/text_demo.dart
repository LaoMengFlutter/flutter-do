import 'package:flutter/material.dart';

///
/// des:
///
class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300,
        ),
        Text('老孟'),

        Text('老孟',style: TextStyle(color: Colors.blue,fontSize: 20),),

        Text('老孟',style: TextStyle(fontWeight: FontWeight.bold)),
        Text('老孟',style: TextStyle(fontStyle: FontStyle.italic,)),
        Text('老孟', style: TextStyle(fontFamily: 'maobi',)),
        Container(
          height: 100,
          width: 200,
          color: Colors.blue.withOpacity(.4),
          child: Text('老孟', textAlign: TextAlign.center),
        ),
        Container(
          height: 100,
          width: 200,
          color: Colors.blue.withOpacity(.4),
          child: Text('老孟，专注分享Flutter技术和应用实战',softWrap: true,),
        ),
        Container(
          height: 100,
          width: 200,
          color: Colors.blue.withOpacity(.4),
          child: Text('老孟，专注分享Flutter技术和应用实战',overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }
}
