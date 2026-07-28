import 'package:flutter/material.dart';
import 'package:fmcl/models/storage/configs/settings_config.dart';
import 'package:fmcl/storage/storage_service.dart';

class SettingsNotifier extends ChangeNotifier {
  SettingsConfig get settings => StorageService.settings;

  Future<void> update(SettingsConfig newSettings) async {
    // 配置无变动时跳过更新
    if (newSettings == settings) {
      return;
    }

    await StorageService.settingsStorage.save(newSettings);

    // 通知 Widget 刷新界面
    notifyListeners();
  }
}
