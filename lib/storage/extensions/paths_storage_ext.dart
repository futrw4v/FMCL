import 'package:fmcl/models/storage/configs/paths_config.dart';
import 'package:fmcl/models/storage/entities/dot_minecraft_folder.dart';
import 'package:fmcl/storage/json_storage.dart';

extension PathsStorageX on JsonStorage<PathsConfig> {
  Future<void> selectPath(String path) {
    return update(data.copyWith(selectedPath: path));
  }

  Future<void> addPath(DotMinecraftFolder newDotMinecraftFolder) {
    // 防止重复
    final exists = data.paths.any((f) => f.path == newDotMinecraftFolder.path);

    if (exists) {
      return selectPath(newDotMinecraftFolder.path);
    }

    final updatedList = [...data.paths, newDotMinecraftFolder];
    final newSelectedPath = data.selectedPath.isEmpty
        ? newDotMinecraftFolder.path
        : data.selectedPath;

    return update(
      data.copyWith(paths: updatedList, selectedPath: newSelectedPath),
    );
  }

  Future<void> removePath(String path) {
    final updatedList = data.paths.where((a) => a.path != path).toList();
    final newSelectedPath = data.selectedPath == path ? '' : data.selectedPath;

    return update(
      data.copyWith(paths: updatedList, selectedPath: newSelectedPath),
    );
  }
}
