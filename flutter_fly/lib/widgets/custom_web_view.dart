import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fly/db/browse_db.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/entry/collection_info.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// des: webview
///

///
/// 跳转到详情
///
toWebView(BuildContext context, String title, String url,
    {String desc = '', String tags = ''}) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return CustomWebView(
      title,
      url,
      desc: desc,
      tags: tags,
    );
  }));
}

class CustomWebView extends StatefulWidget {
  CustomWebView(this.title, this.url, {this.desc = '', this.tags = ''});

  final String url;

  final String title;
  final String desc;
  final String tags;

  @override
  State<StatefulWidget> createState() => _CustomWebView();
}

class _CustomWebView extends State<CustomWebView>
    with SingleTickerProviderStateMixin {
  bool _showLoading = true;
  bool _collection = false;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _controller.forward();
    _initData();
    super.initState();
  }

  _initData() async {
    await CollectionDb().initDb();
    CollectionInfo info = await CollectionDb().find(widget.title);
    if (info != null && info.title != null) {
      setState(() {
        _collection = true;
      });
    }
    await BrowseDb().initDb();
    await BrowseDb().save(widget.title,
        url: widget.url, desc: widget.desc, tags: widget.tags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              IconData(0xe613, fontFamily: 'appIconFonts'),
              color: _collection ? Colors.red : Colors.black,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              updateCollection();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (v) {
              setState(() {
                _showLoading = false;
              });
            },
          ),
          _showLoading
              ? _buildLoading()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  _buildLoading() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        var _value = _animation.value;
        if (_value >= 0.9) {
          _value = 0.9;
        }
        return Container(
          height: 3,
          child: LinearProgressIndicator(
            value: _value,
          ),
        );
      },
    );
  }

  updateCollection() async {
    await CollectionDb().initDb();
    setState(() {
      _collection = !_collection;
    });
    if (_collection) {
      await CollectionDb().save(CollectionInfo(
          title: widget.title,
          url: widget.url,
          desc: widget.desc,
          tags: widget.tags));
    } else {
      await CollectionDb().delete(widget.title);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
