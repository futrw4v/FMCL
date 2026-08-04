import 'dart:async';

import 'package:fmcl/models/storage/configs/accounts_config.dart';
import 'package:fmcl/models/storage/configs/settings_config.dart';
import 'package:fmcl/storage/json_storage.dart';
import 'package:fmcl/storage/managers/file_manager.dart';

/// 全局存储服务
///
/// 负责应用所有数据的持久化存取与内存状态管理
class StorageService {
  /// 内存中缓存的设置模型单例与对外接口
  static final accountsStorage = JsonStorage<AccountsConfig>(
    jsonPath: 'configs/accounts.json',
    toJson: (data) => data.toJson(),
    fromJson: AccountsConfig.fromJson,
    createDefault: () => const AccountsConfig(),
  );

  static final settingsStorage = JsonStorage<SettingsConfig>(
    jsonPath: 'configs/settings.json',
    toJson: (data) => data.toJson(),
    fromJson: SettingsConfig.fromJson,
    createDefault: () => const SettingsConfig(),
  );

  static SettingsConfig get settingsConfig => settingsStorage.data;
  static AccountsConfig get accountsConfig => accountsStorage.data;

  /// 初始化存储服务
  static Future<void> init() async {
    await FileManager.init();

    // 加载所有子配置文件
    await Future.wait([settingsStorage.load(), accountsStorage.load()]);
  }
}
