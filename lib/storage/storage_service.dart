import 'package:fmcl/models/storage/settings_model.dart';
import 'package:fmcl/storage/managers/file_manager.dart';
import 'package:fmcl/storage/managers/json_manager.dart';
import 'package:fmcl/utils/log_util.dart';

/// 全局存储服务
///
/// 负责应用所有数据的持久化存取与内存状态管理
class StorageService {
  /// 偏好设置文件的相对路径
  static const String kSettingsJsonPath = 'configs/settings.json';

  /// 内存中缓存的设置模型单例与对外接口
  static late SettingsModel _settingsModel;

  static SettingsModel get settings => _settingsModel;

  /// 初始化存储服务
  static Future<void> init() async {
    await FileManager.init();

    _settingsModel = SettingsModel();

    await loadSettings();
  }

  /// 从硬盘异步加载配置文件[kSettingsJsonPath]
  ///
  /// 若 JSON 读取成功，则反序列化并更新内存中的[_settingsModel]
  /// 若文件不存在或损坏，则自动创建一份默认配置
  static Future<void> loadSettings() async {
    // 读取文件
    final readResult = await JsonManager.readJson(kSettingsJsonPath);

    if (readResult == null) {
      await JsonManager.writeJson(kSettingsJsonPath, _settingsModel.toJson());
      return;
    }

    _settingsModel = SettingsModel.fromJson(readResult);
  }

  /// 更新并写入全局设置
  ///
  /// [newSettings] 修改后的新设置模型对象
  ///
  /// 更新内存中的[_settingsModel]，并异步原子写入至硬盘
  static Future<void> saveSettings(SettingsModel newSettings) async {
    _settingsModel = newSettings;

    final contentToWrite = _settingsModel.toJson();

    if (await JsonManager.writeJson(kSettingsJsonPath, contentToWrite)) {
      LogUtil.log('写入配置文件成功');
    }
  }
}
