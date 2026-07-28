import 'package:flutter/material.dart';
import 'package:fmcl/models/storage/settings_model.dart';
import 'package:fmcl/storage/storage_service.dart';

class SettingsNotifier extends ChangeNotifier {
  SettingsModel get settings => StorageService.settings;

  Future<void> update(SettingsModel newSettings) async {
    // 配置无变动时跳过更新
    if (newSettings == settings) {
      return;
    }

    await StorageService.saveSettings(newSettings);

    // 通知 Widget 刷新界面
    notifyListeners();
  }
}
