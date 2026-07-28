import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/notifiers/settings_notifier.dart';
import 'package:fmcl/widgets/app_card.dart';
import 'package:provider/provider.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  TranslatePageState createState() => TranslatePageState();
}

class TranslatePageState extends State<TranslatePage> {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = context.watch<SettingsNotifier>();
    final settings = settingsNotifier.settings;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
        vertical: kDefaultPadding,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: kDefaultPadding,

        children: [
          Text('翻译', style: Theme.of(context).textTheme.headlineMedium),

          AppCard(
            margin: EdgeInsets.only(top: kDefaultPadding),
            child: SwitchListTile(
              title: const Text('自动翻译资源简介'),
              subtitle: const Text('关闭可以提高资源页加载速度, 翻译内容由 mcmod-info-mirror 提供'),
              value: settings.autoTranslate,

              onChanged: (bool value) {
                settingsNotifier.update(
                  settings.copyWith(autoTranslate: value),
                );
              },
            ),
          ),

          AppCard(
            child: SwitchListTile(
              title: const Text('使用 Google 翻译进行翻译资源详细信息'),
              subtitle: const Text('Google 翻译服务使用 Cloudflare 进行代理'),
              value: settings.enableGoogleTranslate,
              onChanged: (bool value) {
                settingsNotifier.update(
                  settings.copyWith(enableGoogleTranslate: value),
                );
              },
            ),
          ),

          if (settings.enableGoogleTranslate) ...[
            AppCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Google 翻译客户端 (如不能翻译再修改)',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    DropdownButton<GoogleTranslateApi>(
                      value: settings.googleTranslateApi,

                      // 根据枚举生成选项
                      items: GoogleTranslateApi.values.map((api) {
                        return DropdownMenuItem(
                          value: api,
                          child: Text(api.label),
                        );
                      }).toList(),

                      onChanged: (newApi) {
                        if (newApi != null) {
                          settingsNotifier.update(
                            settings.copyWith(googleTranslateApi: newApi),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum GoogleTranslateApi {
  at('at (默认)'),
  gtx('gtx'),
  t('t'),
  webapp('webapp');

  final String label;

  const GoogleTranslateApi(this.label);
}
