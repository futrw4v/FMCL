import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fml/constants.dart';
import 'package:fml/java/java_service.dart';
import 'package:fml/pages/download_page.dart';
import 'package:fml/pages/home_page.dart' show HomePage;
import 'package:fml/pages/online_page.dart';
import 'package:fml/pages/setting_page.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:url_launcher/url_launcher.dart';

class MainStartPage extends StatefulWidget {
  const MainStartPage({super.key});
  @override
  MainStartPageState createState() => MainStartPageState();
}

class MainStartPageState extends State<MainStartPage> {
  int _selectedIndex = 0;

  // 使页面仅被初始化一次
  final List<Widget> _mainPages = const [
    HomePage(),
    OnlinePage(),
    DownloadPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // 主界面内容
    Widget mainContent = FutureBuilder(
      future: JavaService.initFuture,

      builder: (context, snapshot) {
        // 在初始化未完成时显示CircularProgressIndicator
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 加载完成但没有Java，显示Dialog
        if (JavaService.javaRuntimes.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('未检测到 Java'),
                content: const Text(
                  '未检测到 Java 环境或者 Java 环境未正确配置，请先安装 Java 后再打开启动器',
                ),
                actions: [
                  TextButton(
                    onPressed: () => _launchURL(AppUrls.javaDownload),
                    child: const Text('打开Java下载页面'),
                  ),
                ],
              ),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(title: const Text(kAppName)),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() => _selectedIndex = index);
                },
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.play_arrow),
                    label: Text('启动'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.hub),
                    label: Text('联机'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.download),
                    label: Text('下载'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('设置'),
                  ),
                ],
              ),
              // 显示当前页面
              Expanded(
                child: LazyLoadIndexedStack(
                  index: _selectedIndex,
                  children: _mainPages,
                ),
              ),
            ],
          ),
        );
      },
    );

    // macOS 菜单栏
    if (Platform.isMacOS) {
      return PlatformMenuBar(
        menus: [
          // FML 菜单
          PlatformMenu(
            label: kAppName,
            menus: [
              PlatformMenuItem(
                label: '关于',
                onSelected: () => _showAboutDialog(context),
              ),
              PlatformMenuItem(
                label: '设置',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.comma,
                  meta: true,
                ),
                onSelected: () => setState(() => _selectedIndex = 3),
              ),
              PlatformMenuItem(
                label: '退出',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyQ,
                  meta: true,
                ),
                onSelected: () => SystemNavigator.pop(),
              ),
            ],
          ),
          // 导航菜单
          PlatformMenu(
            label: '导航',
            menus: [
              PlatformMenuItem(
                label: '启动',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.digit1,
                  meta: true,
                ),
                onSelected: () => setState(() => _selectedIndex = 0),
              ),
              PlatformMenuItem(
                label: '联机',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.digit2,
                  meta: true,
                ),
                onSelected: () => setState(() => _selectedIndex = 1),
              ),
              PlatformMenuItem(
                label: '下载',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.digit3,
                  meta: true,
                ),
                onSelected: () => setState(() => _selectedIndex = 2),
              ),
              PlatformMenuItem(
                label: '设置',
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.digit4,
                  meta: true,
                ),
                onSelected: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
          // 帮助菜单
          PlatformMenu(
            label: '帮助',
            menus: [
              PlatformMenuItem(
                label: '访问 GitHub',
                onSelected: () => _launchURL(AppUrls.githubProject),
              ),
            ],
          ),
        ],
        child: mainContent,
      );
    }
    return mainContent;
  }

  // 打开URL
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('无法打开链接: $url')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('发生错误: $e')));
    }
  }

  // 显示关于对话框
  Future<void> _showAboutDialog(BuildContext context) async {
    const channel = MethodChannel(kNativeMethodChannel);
    await channel.invokeMethod('showAboutPanel');
  }
}
