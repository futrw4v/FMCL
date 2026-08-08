import 'dart:io';

import 'package:fmcl/constants.dart';
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

  /// 应用程序文件夹
  static late final Directory appDataDirectory;

  /// 是否为便携模式
  static late final bool portableMode;

  /// Minecraft文件夹 在 macOS 上使用 'minecraft'，在 Windows/Linux 上使用 '.minecraft'
  static final dotMinecraftFolderName = Platform.isMacOS
      ? 'minecraft'
      : '.minecraft';

  /// 当前启动器可执行文件夹下的.minecraft绝对路径
  static String get defaultMinecraftPath =>
      p.join(executableParentDirectory.path, dotMinecraftFolderName);

  /// 官方启动器的.minecraft绝对路径
  static String get officialMinecraftPath =>
      p.join(appDataDirectory.path, dotMinecraftFolderName);

  /// 初始化 FileManager
  static Future<void> init() async {
    temporaryDirectory = await getTemporaryDirectory();

    // 获取应用程序文件夹
    if (Platform.isWindows) {
      appDataDirectory = Directory(Platform.environment['APPDATA'] ?? '');
    } else if (Platform.isMacOS) {
      String home = Platform.environment['HOME'] ?? '';
      home = '$home/Library/Application Support';

      appDataDirectory = Directory(home);
    } else if (Platform.isLinux) {
      appDataDirectory = Directory(Platform.environment['HOME'] ?? '');
    }

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

    final appDataPath = p.join(
      (await getApplicationSupportDirectory())
          .parent
          .parent
          .path, // ★ 必须加 .path！
      kAppNameAbb,
    );

    // 根据便携模式状态解析存储根目录
    baseDirectory = portableMode ? portableDirectory : Directory(appDataPath);

    // 确保目录存在
    if (!await baseDirectory.exists()) {
      await baseDirectory.create(recursive: true);
    }

    if (!await temporaryDirectory.exists()) {
      await temporaryDirectory.create(recursive: true);
    }
  }
}
