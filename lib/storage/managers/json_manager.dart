import 'dart:convert';
import 'dart:io';

import 'package:fmcl/storage/managers/file_manager.dart';
import 'package:fmcl/utils/log_util.dart';
import 'package:path/path.dart' as p;

class JsonManager {
  /// 读取一个JSON文件
  ///
  /// [relativePath] 相对于配置根目录的相对路径（如 configs/settings.json）
  ///
  /// 返回值: 内存字典（为空/出错则为null）
  static Future<Map<String, dynamic>?> readJson(String relativePath) async {
    // 获取文件
    final targetPath = p.join(FileManager.baseDirectory.path, relativePath);
    final targetFile = File(targetPath);

    try {
      // 检查文件是否存在
      if (!await targetFile.exists()) {
        return null;
      }

      // 读取文件
      final content = await targetFile.readAsString();

      if (content.trim().isEmpty) {
        return null;
      }

      // 反序列化 JSON
      return jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      LogUtil.log('读取 JSON 文件失败 [$relativePath]: $e');

      return null;
    }
  }

  /// 原子写入一个JSON文件
  ///
  /// [relativePath] 相对于配置根目录的相对路径（如 configs/settings.json）
  /// [data] 要写入的 Map 字典
  ///
  /// 返回值: 保存是否成功
  static Future<bool> writeJson(
    String relativePath,
    Map<String, dynamic> data,
  ) async {
    // 获取文件
    final targetPath = p.join(FileManager.baseDirectory.path, relativePath);
    final tempPath = '$targetPath.tmp';
    final tempFile = File(tempPath);

    try {
      // 确保目标父文件夹存在
      if (!await tempFile.parent.exists()) {
        await tempFile.parent.create(recursive: true);
      }

      // 写入JSON到.tmp文件
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      await tempFile.writeAsString(jsonString);

      // 原子重命名
      await tempFile.rename(targetPath);

      return true;
    } catch (e) {
      LogUtil.log('写入 JSON 文件失败 [$relativePath]: $e');

      return false;
    } finally {
      // 删掉残余.tmp文件
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}
