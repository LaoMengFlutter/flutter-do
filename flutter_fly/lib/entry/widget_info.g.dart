// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetInfo _$WidgetInfoFromJson(Map<String, dynamic> json) {
  return WidgetInfo(
    title: json['title'] as String,
    desc: json['desc'] as String,
    url: json['url'] as String,
    tags: json['tags'] as String
  );
}

Map<String, dynamic> _$WidgetInfoToJson(WidgetInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'url': instance.url,
      'tags': instance.tags
    };
