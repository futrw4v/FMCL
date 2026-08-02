import 'package:freezed_annotation/freezed_annotation.dart';

part 'dot_minecraft_path.freezed.dart';
part 'dot_minecraft_path.g.dart';

@freezed
abstract class DotMinecraftPath with _$DotMinecraftPath {
  const factory DotMinecraftPath({
    /// 唯一标识符
    @Default('') String id,

    /// UI 上显示的名称
    @Default('') String name,

    /// 本地物理绝对路径
    @Default('') String path,
  }) = _DotMinecraftPath;

  factory DotMinecraftPath.fromJson(Map<String, dynamic> json) =>
      _$DotMinecraftPathFromJson(json);
}
