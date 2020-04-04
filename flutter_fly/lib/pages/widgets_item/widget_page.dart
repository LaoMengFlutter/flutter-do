import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fly/db/widget_db.dart';
import 'package:flutter_fly/entry/widget_info.dart';
import 'package:flutter_fly/http/http_factory.dart';
import 'package:flutter_fly/pages/widgets_item/widget_info_suspension.dart';
import 'package:flutter_fly/widgets/az_list/az_common.dart';
import 'package:flutter_fly/widgets/az_list/az_listview.dart';
import 'package:flutter_fly/widgets/custom_web_view.dart';
import 'package:lpinyin/lpinyin.dart';

///
/// des:控件页面
///
class WidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  List<WidgetInfoSuspension> _widgetList = List();
  List<WidgetInfo> widgetInfoList = [];
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await WidgetDb().initDb();
    widgetInfoList = await WidgetDb().findAll();
    if (widgetInfoList.length <= 150) {
      var jsonStr = await DefaultAssetBundle.of(context)
          .loadString('assets/json/widgets.json');
      List<dynamic> jsonData = json.decode(jsonStr);
      widgetInfoList = getWidgetInfoList(jsonData);
      _saveDb(widgetInfoList);
    }

    widgetInfoList.forEach((f) {
      _widgetList.add(WidgetInfoSuspension(widgetInfo: f));
    });

    _handleList(_widgetList);
    _suspensionTag = _widgetList[0].getSuspensionTag();
    setState(() {});
  }

  _saveDb(List<WidgetInfo> list) async {
    await WidgetDb().save(list);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(WidgetInfoSuspension model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: _buildWidgetItem(model.widgetInfo),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  _buildWidgetItem(WidgetInfo info) {
    return ListTile(
      title: Text(info.title),
      onTap: () {
        toWebView(context, info.title, 'http://laomengit.com/${info.url}',
            desc: info.desc, tags: info.tags);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: AzListView(
              data: _widgetList,
              itemBuilder: (context, model) => _buildListItem(model),
              suspensionWidget: _buildSusWidget(_suspensionTag),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: _onSusTagChanged,
            )),
      ],
    );
  }

  ///
  /// 根据A-Z排序
  ///
  void _handleList(List<WidgetInfoSuspension> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].widgetInfo.title);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }
}
