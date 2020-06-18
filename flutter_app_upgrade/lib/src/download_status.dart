
enum DownloadStatus{
  ///
  /// 未下载
  ///
  none,
  ///
  /// 准备开始下载，请求网络到下载第1个字节之间
  ///
  start,
  ///
  /// 正在下载
  ///
  downloading,
  ///
  /// 下载完成
  ///
  done,
  ///
  /// 下载异常
  ///
  error
}