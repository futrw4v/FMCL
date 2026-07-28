import 'package:flutter/material.dart';
import 'package:fmcl/models/enums/google_translate_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
abstract class SettingsModel with _$SettingsModel {
  /// 构造函数，定义设置与其默认值
  const factory SettingsModel({
    // Colors.blue = 4280391411
    @Default(4280391411) int themeColor,

    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool autoClearLog,
    @Default(0) int logLevel,

    @Default(true) bool autoTranslate,
    @Default(true) bool enableGoogleTranslate,
    @Default(GoogleTranslateApi.at) GoogleTranslateApi googleTranslateApi,
  }) = _SettingsModel;

  // 反序列化JSON支持
  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
