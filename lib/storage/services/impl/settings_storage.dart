import 'package:fmcl/models/storage/configs/settings_config.dart';
import 'package:fmcl/storage/services/abstract_json_storage.dart';

class SettingsStorage extends AbstractJsonStorage<SettingsConfig> {
  @override
  String get jsonPath => 'configs/settings.json';

  @override
  SettingsConfig createDefault() => const SettingsConfig();

  @override
  SettingsConfig fromJson(Map<String, dynamic> json) =>
      SettingsConfig.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsConfig data) => data.toJson();
}
