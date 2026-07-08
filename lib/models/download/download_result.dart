/// 下载任务结果
class DownloadResult {
  final List<Map<String, String>> failedList;
  final bool success;
  final int totalCount;
  final int completedCount;

  DownloadResult({
    required this.failedList,
    required this.success,
    required this.totalCount,
    required this.completedCount,
  });
}
