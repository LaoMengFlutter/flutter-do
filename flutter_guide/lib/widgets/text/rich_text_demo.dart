import 'package:flutter/material.dart';

///
/// des:
///
class RichTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <InlineSpan>[
              TextSpan(text: '老孟', style: TextStyle(color: Colors.red)),
              TextSpan(text: '，'),
              TextSpan(text: '专注分享Flutter技术和应用实战'),
            ]),
      ),
    );
  }
}
