// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    _SettingsModel(
      themeColor: (json['themeColor'] as num?)?.toInt() ?? 4280391411,
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      autoClearLog: json['autoClearLog'] as bool? ?? true,
      logLevel: (json['logLevel'] as num?)?.toInt() ?? 0,
      autoTranslate: json['autoTranslate'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsModelToJson(_SettingsModel instance) =>
    <String, dynamic>{
      'themeColor': instance.themeColor,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'autoClearLog': instance.autoClearLog,
      'logLevel': instance.logLevel,
      'autoTranslate': instance.autoTranslate,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
