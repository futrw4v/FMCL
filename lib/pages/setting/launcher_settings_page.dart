import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' show BlockPicker;
import 'package:fmcl/constants.dart';
import 'package:fmcl/models/enums/google_translate_api.dart';
import 'package:fmcl/models/storage/configs/settings_config.dart';
import 'package:fmcl/storage/json_storage.dart';
import 'package:fmcl/widgets/app_card.dart';
import 'package:provider/provider.dart';

class LauncherSettingsPage extends StatelessWidget {
  const LauncherSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = context.watch<JsonStorage<SettingsConfig>>();
    final settings = settingsNotifier.data;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
        vertical: kDefaultPadding,
      ),

      children: [
        // 大标题
        Text('启动器设置', style: textTheme.headlineMedium),

        const SizedBox(height: kDefaultPadding),

        Text('外观', style: textTheme.titleMedium),
        const SizedBox(height: kDefaultPadding / 2),
        AppCard(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,

                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),

                  child: SegmentedButton<ThemeMode>(
                    style: SegmentedButton.styleFrom(side: BorderSide.none),

                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto_outlined, size: 18),
                        label: Text('跟随系统'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_outlined, size: 18),
                        label: Text('浅色'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_outlined, size: 18),
                        label: Text('深色'),
                      ),
                    ],
                    selected: {settings.themeMode},

                    onSelectionChanged: (Set<ThemeMode> newSelection) {
                      settingsNotifier.update(
                        settings.copyWith(themeMode: newSelection.first),
                      );
                    },
                  ),
                ),
              ),

              // 主题色选择
              ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: const Text('主题配色'),
                subtitle: const Text('点击选择软件全局配色方案'),
                trailing: CircleAvatar(
                  backgroundColor: Color(settings.themeColor),
                  radius: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                onTap: () => _selectColor(context, settingsNotifier),
              ),
            ],
          ),
        ),

        const SizedBox(height: kDefaultPadding * 1.5),

        Text('翻译', style: textTheme.titleMedium),

        const SizedBox(height: kDefaultPadding / 2),

        AppCard(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('自动翻译资源简介'),
                subtitle: const Text('关闭可提高加载速度，由 mcmod-info-mirror 提供'),

                value: settings.autoTranslate,

                onChanged: (bool value) {
                  settingsNotifier.update(
                    settings.copyWith(autoTranslate: value),
                  );
                },
              ),

              SwitchListTile(
                title: const Text('Google 翻译详细信息'),
                subtitle: const Text('使用 Cloudflare 代理节点翻译 Mod'),

                value: settings.enableGoogleTranslate,

                onChanged: (bool value) {
                  settingsNotifier.update(
                    settings.copyWith(enableGoogleTranslate: value),
                  );
                },
              ),

              if (settings.enableGoogleTranslate) ...[
                ListTile(
                  title: const Text('Google 翻译客户端'),
                  subtitle: const Text('若出现翻译失败可尝试更换接口节点'),

                  trailing: DropdownButton<GoogleTranslateApi>(
                    value: settings.googleTranslateApi,

                    underline: const SizedBox(),

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
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// 颜色选择弹窗
  void _selectColor(
    BuildContext context,
    JsonStorage<SettingsConfig> settingsStorage,
  ) {
    final settings = settingsStorage.data;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('选择主题配色'),
          content: BlockPicker(
            pickerColor: Color(settings.themeColor),
            availableColors: Colors.primaries,
            itemBuilder: (color, isCurrentColor, changeColor) {
              return GestureDetector(
                onTap: changeColor,
                child: Container(
                  margin: const EdgeInsets.all(kDefaultPadding / 4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: isCurrentColor
                        ? Border.all(color: Colors.black54, width: 3)
                        : null,
                  ),
                  width: 40,
                  height: 40,
                ),
              );
            },
            onColorChanged: (Color color) {
              settingsStorage.update(
                settings.copyWith(themeColor: color.toARGB32()),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
