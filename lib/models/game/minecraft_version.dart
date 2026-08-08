import 'package:fmcl/models/enums/minecraft_version_type.dart';
import 'package:fmcl/utils/log_util.dart';

/// 从API解析出来的Minecraft版本
/// 示例 :
/// {
///   "id": "1.20.1",
///   "type": "release",
///   "url": "https://piston-meta.mojang.com/v1/packages/0e416921378f6d442c057499ba3e5dcbd36f80a9/1.20.1.json",
///   "time": "2025-08-05T06:42:15+00:00",
///   "releaseTime": "2023-06-12T13:25:51+00:00"
/// }
class MinecraftVersion {
  final String id, url, time, releaseTime;
  final MinecraftVersionType type;
  const MinecraftVersion({
    required this.id,
    required this.type,
    required this.url,
    required this.time,
    required this.releaseTime,
  });

  ///
  /// 工厂构造函数，用于从JSON对象创建实例
  ///
  factory MinecraftVersion.fromJson(Map<String, dynamic> json) {
    try {
      return MinecraftVersion(
        id: json['id'] as String,
        type: MinecraftVersionType.fromString(json['type'] as String),
        url: json['url'] as String,
        time: json['time'] as String,
        releaseTime: json['releaseTime'] as String,
      );
    } catch (e) {
      LogUtil.log('无效的版本 JSON: $json', level: 'ERROR');
      throw FormatException('无效的版本JSON: $json', e);
    }
  }

  @override
  String toString() {
    return 'MinecraftVersion(id: $id, type: $type, url: $url, time: $time, releaseTime: $releaseTime)';
  }
}
