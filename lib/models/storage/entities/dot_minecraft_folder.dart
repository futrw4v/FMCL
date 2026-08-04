import 'package:freezed_annotation/freezed_annotation.dart';

part 'dot_minecraft_folder.freezed.dart';
part 'dot_minecraft_folder.g.dart';

@freezed
abstract class DotMinecraftFolder with _$DotMinecraftFolder {
  const factory DotMinecraftFolder({
    /// UI 上显示的名称
    @Default('') String name,

    /// 本地物理绝对路径
    @Default('') String path,
  }) = _DotMinecraftFolder;

  factory DotMinecraftFolder.fromJson(Map<String, dynamic> json) =>
      _$DotMinecraftFolderFromJson(json);
}
