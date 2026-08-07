import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/java/java_service.dart';
import 'package:fmcl/models/storage/configs/settings_config.dart';
import 'package:fmcl/pages/home/main_start_page.dart';
import 'package:fmcl/pages/online/owner_page.dart';
import 'package:fmcl/storage/json_storage.dart';
import 'package:fmcl/storage/storage_service.dart';
import 'package:fmcl/utils/log_util.dart';
import 'package:fmcl/utils/slide_page_route.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initVersionInfo();

  final mode = kDebugMode ? 'Debug' : 'Release';

  LogUtil.log(
    '启动 $kAppNameAbb [$mode], 平台: ${Platform.operatingSystem}, 版本: v$gAppVersion+$gAppBuildNumber',
  );

  await initWindow();

  await StorageService.init();

  JavaService.initFuture = JavaService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: StorageService.settingsJson),
        ChangeNotifierProvider.value(value: StorageService.accountsJson),
      ],
      child: const FMCLBaseApp(),
    ),
  );
}

// 初始化窗口
Future<void> initWindow() async {
  await windowManager.ensureInitialized();

  double screenWidth = 1280.0;
  double screenHeight = 720.0;

  // 获取物理显示器信息
  if (PlatformDispatcher.instance.displays.isNotEmpty) {
    final display = PlatformDispatcher.instance.displays.first;
    final double dpi = display.devicePixelRatio;

    // 用显示器的物理尺寸除以缩放比例
    screenWidth = display.size.width / dpi;
    screenHeight = display.size.height / dpi;
  }

  // 动态计算窗口大小/最小尺寸，限制窗口的最大和最小边界
  double minWidth = screenWidth < 800.0 ? (screenWidth * 0.9) : 800.0;
  double minHeight = screenHeight < 450.0 ? (screenHeight * 0.9) : 450.0;
  double windowWidth = (screenWidth * 0.67).clamp(minWidth, 1400.0);
  double windowHeight = (screenHeight * 0.67).clamp(minHeight, 787.5);

  // 设置窗口
  WindowOptions windowOptions = WindowOptions(
    size: Size(windowWidth, windowHeight),
    minimumSize: Size(minWidth, minHeight),
    center: true,
    title: "$kAppName v$gAppVersion ($gAppBuildNumber)",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

// 软件版本
Future<void> initVersionInfo() async {
  final packageInfo = await PackageInfo.fromPlatform();

  gAppVersion = packageInfo.version;
  gAppBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
  gAppUserAgent = '$kAppNameAbb/$gAppVersion';
}

class FMCLBaseApp extends StatefulWidget {
  const FMCLBaseApp({super.key});

  static FMCLBaseAppState of(BuildContext context) =>
      context.findAncestorStateOfType<FMCLBaseAppState>()!;

  @override
  FMCLBaseAppState createState() => FMCLBaseAppState();
}

class FMCLBaseAppState extends State<FMCLBaseApp> {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = context.watch<JsonStorage<SettingsConfig>>();
    final settings = settingsNotifier.data;
    final seedColor = Color(settings.themeColor);

    return MaterialApp(
      title: kAppName,
      theme: _buildTheme(seedColor, Brightness.light),
      darkTheme: _buildTheme(seedColor, Brightness.dark),

      themeMode: settings.themeMode,

      home: const MainStartPage(),

      onGenerateRoute: (settings) {
        if (settings.name == kOnlineOwnerRoute) {
          final int port = settings.arguments as int;
          final String etServer = settings.arguments as String;

          return SlidePageRoute(
            page: OwnerPage(port: port, etServer: etServer),
          );
        }
        return null;
      },
    );
  }

  ThemeData _buildTheme(Color seedColor, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'NotoSans',
      colorScheme: scheme,
    );
  }
}
