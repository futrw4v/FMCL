import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fml/java/java_service.dart';
import 'package:fml/pages/home/start.dart';
import 'package:fml/utils/slide_page_route.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fml/constants.dart';
import 'package:fml/utils/log_util.dart';
import 'package:fml/pages/online/owner_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await initVersionInfo();
  // 设置窗口标题
  WindowOptions windowOptions = WindowOptions(
    center: true,
    title: "$kAppName v$gAppVersion ($gAppBuildNumber)",
    minimumSize: const Size(600, 600),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await initLogs();

  JavaService.initFuture = JavaService.init();

  runApp(const FMLBaseApp());
}

// 软件版本
Future<void> initVersionInfo() async {
  final packageInfo = await PackageInfo.fromPlatform();

  gAppVersion = packageInfo.version;
  gAppBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
  gAppDefaultUserAgent = 'FML/$gAppVersion';
  gAppModrinthUserAgent = 'lxdklp/FML/$gAppVersion (fml.lxdklp.top)';

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('version', gAppVersion);
  await prefs.setInt('build', gAppBuildNumber);
}

// 日志
Future<void> initLogs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool autoClearLog = prefs.getBool('autoClearLog') ?? true;
  if (autoClearLog) {
    await LogUtil.clearLogs();
  }

  await LogUtil.log(
    '启动FML, 平台:${Platform.operatingSystem}, 版本: $gAppVersion, 构建号: $gAppBuildNumber${kDebugMode ? ", debug模式" : ""}',
    level: 'INFO',
  );
}

class FMLBaseApp extends StatefulWidget {
  const FMLBaseApp({super.key});

  static FMLBaseAppState of(BuildContext context) =>
      context.findAncestorStateOfType<FMLBaseAppState>()!;

  @override
  FMLBaseAppState createState() => FMLBaseAppState();
}

class FMLBaseAppState extends State<FMLBaseApp> {
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

  // 可变字体权重
  TextTheme _withVariableWeights(TextTheme base) {
    TextStyle setW(TextStyle? s, double w) => (s ?? const TextStyle()).copyWith(
      fontFamily: 'NotoSans',
      fontVariations: [FontVariation('wght', w)],
    );
    return base.copyWith(
      bodySmall: setW(base.bodySmall, AppFontWeights.bodyWght),
      bodyMedium: setW(base.bodyMedium, AppFontWeights.bodyWght),
      bodyLarge: setW(base.bodyLarge, AppFontWeights.bodyWght),
      labelSmall: setW(base.labelSmall, AppFontWeights.labelWght),
      labelMedium: setW(base.labelMedium, AppFontWeights.labelWght),
      labelLarge: setW(base.labelLarge, AppFontWeights.labelWght),
      titleSmall: setW(base.titleSmall, AppFontWeights.titleWght),
      titleMedium: setW(base.titleMedium, AppFontWeights.titleWght),
      titleLarge: setW(base.titleLarge, AppFontWeights.titleWght),
      headlineSmall: setW(base.headlineSmall, AppFontWeights.headlineWght),
      headlineMedium: setW(base.headlineMedium, AppFontWeights.headlineWght),
      headlineLarge: setW(base.headlineLarge, AppFontWeights.headlineWght),
      displaySmall: setW(base.displaySmall, AppFontWeights.headlineWght),
      displayMedium: setW(base.displayMedium, AppFontWeights.headlineWght),
      displayLarge: setW(base.displayLarge, AppFontWeights.headlineWght),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _themeColor,
      brightness: brightness,
    );
    final baseTypography = Typography.material2021();
    final raw = brightness == Brightness.dark
        ? baseTypography.white
        : baseTypography.black;
    final textTheme = _withVariableWeights(raw);
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'NotoSans',
      colorScheme: scheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
        elevation: 0,
      ),
      navigationRailTheme: NavigationRailThemeData(
        selectedLabelTextStyle: textTheme.labelLarge,
        unselectedLabelTextStyle: textTheme.labelMedium,
      ),
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
