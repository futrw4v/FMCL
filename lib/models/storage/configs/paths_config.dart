import 'package:fmcl/models/storage/entities/dot_minecraft_path.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paths_config.freezed.dart';
part 'paths_config.g.dart';

/// 与 configs/paths.json 对应
@freezed
abstract class PathsConfig with _$PathsConfig {
  const PathsConfig._();

  const factory PathsConfig({
    @Default(1) int version,

    @Default('') String selectedPathId,

    @Default([]) List<DotMinecraftPath> paths,
  }) = _PathsConfig;

  factory PathsConfig.fromJson(Map<String, dynamic> json) =>
      _$PathsConfigFromJson(json);

  DotMinecraftPath? get selectedPath {
    if (selectedPathId.isEmpty) return null;
    try {
      return paths.firstWhere((p) => p.id == selectedPathId);
    } catch (_) {
      return null;
    }
  }
}
