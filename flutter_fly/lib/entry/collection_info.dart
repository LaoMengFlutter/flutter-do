///
/// des:
///
class CollectionInfo {
  CollectionInfo({this.title, this.desc, this.url, this.tags});

  ///
  /// 控件信息 title
  ///
  final String title;

  ///
  /// 控件描述
  ///
  final String desc;

  ///
  /// 点击跳转到web，加载 url
  ///
  final String url;

  ///
  /// 标签，用于搜索,多个使用","隔开
  ///
  final String tags;
}
