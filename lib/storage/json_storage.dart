import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fmcl/storage/managers/json_manager.dart';
import 'package:fmcl/utils/log_util.dart';

class JsonStorage<T> extends ChangeNotifier {
  /// 目标 JSON 文件的相对路径
  final String jsonPath;

  /// 内存中缓存的数据模型
  T? _data;

  T get data => _data ?? createDefault();

  /// 读写 JSON
  final T Function(Map<String, dynamic> json) fromJson;

  final Map<String, dynamic> Function(T data) toJson;

  // 创建初始化默认对象的方法
  final T Function() createDefault;

  /// 防抖
  Timer? _debounceTimer;
  static const int kDefaultDebounceMilliseconds = 500;

  /// 构造函数
  JsonStorage({
    required this.jsonPath,
    required this.fromJson,
    required this.toJson,
    required this.createDefault,
  });

  /// 全局初始化
  Future<void> load() async {
    // 读取文件
    final readResult = await JsonManager.readJson(jsonPath);

    if (readResult == null) {
      // 文件不存在或损坏，使用默认对象并写入
      _data = createDefault();
      await JsonManager.writeJson(jsonPath, toJson(_data as T));
      return;
    }

    try {
      // 反序列化
      _data = fromJson(readResult);
    } catch (e) {
      LogUtil.log("解析 '$jsonPath' 失败，使用默认配置: $e");
      _data = createDefault();
    }
  }

  Future<void> update(T newData) async {
    // 若有正在倒计时的定时器则取消它
    _debounceTimer?.cancel();

    _data = newData;

    // 立刻通知 Listeners
    notifyListeners();

    // 开启一个新的延时任务来实现防抖
    _debounceTimer = Timer(
      const Duration(milliseconds: kDefaultDebounceMilliseconds),
      () async {
        final contentToWrite = toJson(_data as T);

        if (await JsonManager.writeJson(jsonPath, contentToWrite)) {
          LogUtil.log("写入 '$jsonPath' 成功");
        }
      },
    );
  }
}
