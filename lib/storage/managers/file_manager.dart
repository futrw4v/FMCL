import 'dart:io';

import 'package:fmcl/utils/log_util.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// 一个简易的文件管理器，在初始化时获取程序运行所需要的目录
class FileManager {
  /// 存储数据的文件夹
  static late final Directory baseDirectory;

  /// 系统缓存文件夹
  static late final Directory temporaryDirectory;

  /// 可执行文件所在文件夹
  static late final Directory executableParentDirectory;

  /// 是否为便携模式
  static late final bool portableMode;

  /// 初始化 FileManager
  static Future<void> init() async {
    temporaryDirectory = await getTemporaryDirectory();

    // 获取当前可执行文件与父级目录
    final executablePath = Platform.resolvedExecutable;

    executableParentDirectory = File(executablePath).parent;

    // 获取同目录下的portable路径
    final portableDirectory = Directory(
      p.join(executableParentDirectory.path, 'portable'),
    );

    portableMode = await portableDirectory.exists();

    if (portableMode) {
      LogUtil.log('检测到同目录下存在 portable 路径，启用便携模式');
    }

    // 根据便携模式状态解析存储根目录
    baseDirectory = portableMode
        ? portableDirectory
        : await getApplicationSupportDirectory();

    // 确保目录存在
    if (!await baseDirectory.exists()) {
      await baseDirectory.create(recursive: true);
    }

    if (!await temporaryDirectory.exists()) {
      await temporaryDirectory.create(recursive: true);
    }
  }
}
