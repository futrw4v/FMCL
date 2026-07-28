import 'package:flutter/material.dart' hide LicensePage;
import 'package:fmcl/constants.dart';
import 'package:fmcl/widgets/app_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          kDefaultPadding * 2,
          0,
          kDefaultPadding * 2,
          kDefaultPadding,
        ),

        child: SingleChildScrollView(
          child: Column(
            spacing: kDefaultPadding,

            children: [
              // 最上层卡片
              AppCard(
                // 内边距
                padding: const EdgeInsets.all(kDefaultPadding),

                child: Column(
                  spacing: kDefaultPadding / 2,

                  children: [
                    // 上方两张图片
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Flexible(
                          child: Image.asset(
                            'assets/img/icon/logo_transparent.png',
                            height: 150,
                          ),
                        ),

                        const SizedBox(width: 70),

                        Flexible(
                          child: Image.asset(
                            'assets/img/logo/flutter.png',
                            height: 150,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      '$kAppName v$gAppVersion',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      'FMCL 基于 FML (by lxdklp) 二次开发\n'
                      'Copyright © 2026 futrw4v. Licensed under GPL v3',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              _buildCardWithListTile(
                title: 'GitHub',
                subtitle: AppUrls.githubProject,
                onTap: () => _launchURL(AppUrls.githubProject),
              ),

              _buildCardWithListTile(
                title: 'BUG反馈与建议',
                subtitle: '${AppUrls.githubProject}/issues',
                onTap: () => _launchURL('${AppUrls.githubProject}/issues'),
              ),

              _buildCardWithListTile(
                title: '许可',
                subtitle: '感谢各位依赖库的贡献者',
                onTap: () => showLicensePage(context: context),
              ),

              AppCard(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('鸣谢'),
                      subtitle: Text('排名不分先后顺序'),
                    ),

                    ListTile(
                      title: const Text('lxdklp'),
                      subtitle: const Text('FML作者\nhttps://github.com/lxdklp/'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL('https://github.com/lxdklp/'),
                    ),

                    ListTile(
                      title: const Text('bangbang93'),
                      subtitle: const Text(
                        '下载源 BMCLAPI 维护者\nhttps://bmclapidoc.bangbang93.com',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://bmclapidoc.bangbang93.com'),
                    ),

                    ListTile(
                      title: const Text('MCIM'),
                      subtitle: const Text(
                        '资源简介翻译\nhttps://github.com/mcmod-info-mirror',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://github.com/mcmod-info-mirror'),
                    ),

                    ListTile(
                      title: const Text('gh-proxy.com'),
                      subtitle: const Text('GitHub 加速下载\nhttps://gh-proxy.com'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL('https://gh-proxy.com'),
                    ),

                    ListTile(
                      title: const Text('Modrinth'),
                      subtitle: const Text('资源下载\nhttps://modrinth.com'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL('https://modrinth.com'),
                    ),

                    ListTile(
                      title: const Text('Sawaratsuki'),
                      subtitle: const Text(
                        '重绘制的 Flutter Logo \nhttps://github.com/SAWARATSUKI',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL('https://github.com/SAWARATSUKI'),
                    ),

                    ListTile(
                      title: const Text('Noto CJK fonts'),
                      subtitle: const Text(
                        '字体\nhttps://github.com/notofonts/noto-cjk',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://github.com/notofonts/noto-cjk'),
                    ),

                    ListTile(
                      title: const Text('authlib-injector'),
                      subtitle: const Text(
                        '外置登录\nhttps://github.com/yushijinhun/authlib-injector',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL(
                        'https://github.com/yushijinhun/authlib-injector',
                      ),
                    ),

                    ListTile(
                      title: const Text('EasyTier'),
                      subtitle: const Text('异地组网\nhttps://easytier.cn/'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL('https://easytier.cn/'),
                    ),

                    ListTile(
                      title: const Text('Scaffolding-MC'),
                      subtitle: const Text(
                        '联机协议\nhttps://github.com/Scaffolding-MC/Scaffolding-MC',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL(
                        'https://github.com/Scaffolding-MC/Scaffolding-MC',
                      ),
                    ),

                    ListTile(
                      title: const Text('Terracotta'),
                      subtitle: const Text(
                        '联机实现参考\nhttps://github.com/burningtnt/Terracotta',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchURL(
                        'https://github.com/burningtnt/Terracotta',
                      ),
                    ),

                    ListTile(
                      title: const Text('HMCL'),
                      subtitle: const Text(
                        '部分功能实现参考\nhttps://github.com/HMCL-dev/HMCL',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://github.com/HMCL-dev/HMCL'),
                    ),

                    ListTile(
                      title: const Text('PCL'),
                      subtitle: const Text(
                        '部分功能实现参考\nhttps://github.com/Meloong-Git/PCL',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://github.com/Meloong-Git/PCL'),
                    ),

                    ListTile(
                      title: const Text('Google 翻译'),
                      subtitle: const Text(
                        'https://translate.google.com/about',
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () =>
                          _launchURL('https://translate.google.com/about'),
                    ),

                    const ListTile(
                      title: Text('图标'),
                      subtitle: Text(
                        '画师不愿透露',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardWithListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return AppCard(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.open_in_new),
        onTap: onTap,
      ),
    );
  }

  ///
  /// 打开URL
  ///
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('无法打开链接: $url')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('发生错误: $e')));
    }
  }
}
