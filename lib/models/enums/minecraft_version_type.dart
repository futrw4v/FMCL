import 'package:fmcl/utils/log_util.dart';

enum MinecraftVersionType {
  release,
  snapshot,
  oldBeta,
  oldAlpha,
  unknown;

  ///
  /// 从字符串解析出对应的VersionType
  ///
  static MinecraftVersionType fromString(String name) {
    final normalizedName = name.toLowerCase().replaceAll('_', '');

    try {
      return values.firstWhere(
        (type) => type.name.toLowerCase() == normalizedName,
      );
    } catch (e) {
      LogUtil.log("无法将 '$name' 解析为 VersionType!", level: 'ERROR');
      return MinecraftVersionType.unknown;
    }
  }

  ///
  /// 确保输出的字符串与Mojang API返回的格式匹配
  ///
  @override
  String toString() {
    switch (this) {
      case MinecraftVersionType.oldBeta:
        return 'old_beta';
      case MinecraftVersionType.oldAlpha:
        return 'old_alpha';
      default:
        return name;
    }
  }

  ///
  /// 用于UI上的标签
  ///
  String getVersionTypeLabel() {
    switch (this) {
      case MinecraftVersionType.release:
        return '正式版';
      case MinecraftVersionType.snapshot:
        return '快照版';
      case MinecraftVersionType.oldBeta:
        return '远古Beta版';
      case MinecraftVersionType.oldAlpha:
        return '远古Alpha版';
      case MinecraftVersionType.unknown:
        return '未知';
    }
  }
}
