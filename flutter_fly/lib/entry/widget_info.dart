import 'package:json_annotation/json_annotation.dart';

part 'widget_info.g.dart';

///
/// des:
///
List<WidgetInfo> getWidgetInfoList(List<dynamic> list) {
  List<WidgetInfo> result = [];
  list.forEach((item) {
    result.add(WidgetInfo.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class WidgetInfo extends Object {
  ///
  /// 控件信息 title
  ///
  @JsonKey(name: 'title')
  String title;

  ///
  /// 控件描述
  ///
  @JsonKey(name: 'desc')
  String desc;

  ///
  /// 点击跳转到web，加载 url
  ///
  @JsonKey(name: 'url')
  String url;

  ///
  /// 标签，用于搜索,多个使用","隔开
  ///
  @JsonKey(name: 'tags')
  String tags;


  WidgetInfo(
      {this.title, this.desc, this.url, this.tags});

  factory WidgetInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$WidgetInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WidgetInfoToJson(this);
}
