import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/java/java_service.dart';
import 'package:fmcl/pages/download_page.dart';
import 'package:fmcl/pages/home_page.dart' show HomePage;
import 'package:fmcl/pages/online_page.dart';
import 'package:fmcl/pages/setting_page.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:url_launcher/url_launcher.dart';

class MainStartPage extends StatefulWidget {
  const MainStartPage({super.key});
  @override
  MainStartPageState createState() => MainStartPageState();
}

class MainStartPageState extends State<MainStartPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // 使页面仅被初始化一次
  final List<Widget> _mainPages = const [
    HomePage(),
    OnlinePage(),
    DownloadPage(),
    SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    // 初始化 AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // 渐变
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // 划入动画
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.03), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // 开始动画
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                  // 确保只在切换页面时更新
                  if (index != _selectedIndex) {
                    setState(() => _selectedIndex = index);

                    // 切换页面时更新动画
                    _animationController.forward(from: 0.0);
                  }
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
                // 叠加动画
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: LazyLoadIndexedStack(
                      index: _selectedIndex,
                      children: _mainPages,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

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
}
