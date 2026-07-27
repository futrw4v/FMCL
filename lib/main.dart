import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/java/java_service.dart';
import 'package:fmcl/pages/home/main_start_page.dart';
import 'package:fmcl/pages/online/owner_page.dart';
import 'package:fmcl/utils/log_util.dart';
import 'package:fmcl/utils/slide_page_route.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initVersionInfo();

  await initWindow();

  await initLogs();

  JavaService.initFuture = JavaService.init();

  runApp(const FMCLBaseApp());
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

// 日志
Future<void> initLogs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool autoClearLog = prefs.getBool('autoClearLog') ?? true;
  if (autoClearLog) {
    await LogUtil.clearLogs();
  }

  final mode = kDebugMode ? 'Debug' : 'Release';

  LogUtil.log(
    '启动 $kAppNameAbb [$mode], 平台: ${Platform.operatingSystem}, 版本: v$gAppVersion+$gAppBuildNumber',
  );
}

class FMCLBaseApp extends StatefulWidget {
  const FMCLBaseApp({super.key});

  static FMCLBaseAppState of(BuildContext context) =>
      context.findAncestorStateOfType<FMCLBaseAppState>()!;

  @override
  FMCLBaseAppState createState() => FMCLBaseAppState();
}

class FMCLBaseAppState extends State<FMCLBaseApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _themeColor = Colors.blue;

  ThemeMode get themeMode => _themeMode;
  Color get themeColor => _themeColor;

  @override
  void initState() {
    super.initState();
    _loadThemePrefs();
  }

  // 加载主题
  Future<void> _loadThemePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final modeStr = prefs.getString('themeMode');
    final colorInt = prefs.getInt('themeColor');
    if (colorInt != null) {
      // 从存储的整数值创建颜色对象
      _themeColor = Color.fromARGB(
        (colorInt >> 24) & 0xFF,
        (colorInt >> 16) & 0xFF,
        (colorInt >> 8) & 0xFF,
        colorInt & 0xFF,
      );
    }
    if (modeStr != null) {
      switch (modeStr) {
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
    }
    if (mounted) setState(() {});
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    setState(() {
      _themeMode = themeMode;
    });
    final prefs = await SharedPreferences.getInstance();
    String modeStr;
    switch (themeMode) {
      case ThemeMode.dark:
        modeStr = 'dark';
        break;
      case ThemeMode.light:
        modeStr = 'light';
        break;
      default:
        modeStr = 'system';
    }
    await prefs.setString('themeMode', modeStr);
  }

  Future<void> changeThemeColor(Color color) async {
    setState(() {
      _themeColor = color;
    });

    final prefs = await SharedPreferences.getInstance();

    int colorValue =
        (((color.a * 255.0).round() & 0xFF) << 24) |
        (((color.r * 255.0).round() & 0xFF) << 16) |
        (((color.g * 255.0).round() & 0xFF) << 8) |
        ((color.b * 255.0).round() & 0xFF);

    await prefs.setInt('themeColor', colorValue);
  }

  ThemeData _buildTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _themeColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'NotoSans',
      colorScheme: scheme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _themeMode,
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
}
