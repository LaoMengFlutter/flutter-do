import 'package:flutter/material.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/entry/collection_info.dart';
import 'package:flutter_fly/widgets/custom_web_view.dart';

///
/// des:收藏页面
///
class CollectionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionState();
}

class _CollectionState extends State<CollectionsPage> {
  List<CollectionInfo> _list = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    await CollectionDb().initDb();
    _list = await CollectionDb().findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${_list[index].title}'),
              onTap: () {
                toWebView(context, _list[index].title, _list[index].url);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: _list.length),
    );
  }
}
