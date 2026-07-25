import 'package:flutter/material.dart';

/// 全局统一卡片组件 [AppCard]
///
/// 基于 Material Design 3 规范封装的填充卡片容器，用于规范卡片的外观样式
/// 支持自定义内外边距、固定尺寸
class AppCard extends StatelessWidget {
  /// 卡片内部视图
  final Widget child;

  /// 卡片内边距
  final EdgeInsetsGeometry? padding;

  /// 卡片外边距
  final EdgeInsetsGeometry? margin;

  /// 左键点击/交互事件
  final VoidCallback? onTap;

  /// 右键点击
  final VoidCallback? onSecondaryTap;

  /// 卡片尺寸控制
  final double? width;
  final double? height;

  //卡片颜色
  final Color? color;

  final ShapeBorder? shape;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.onSecondaryTap,
    this.width,
    this.height,
    this.color,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    // 处理 Padding
    Widget cardChild = child;

    if (padding != null && padding != EdgeInsets.zero) {
      cardChild = Padding(padding: padding!, child: cardChild);
    }

    Widget content = Card.filled(
      shape: shape,

      color: color ?? Theme.of(context).colorScheme.surfaceContainer,

      // 确保 InkWell 不会超出卡片圆角
      clipBehavior: Clip.antiAlias,

      // 将外边距统一在最外层 Padding 防止重复添加外边距
      margin: EdgeInsets.zero,

      child: InkWell(
        // 添加左键点击与波纹
        onTap: onTap,

        // 添加右键点击
        onSecondaryTap: onSecondaryTap,

        child: cardChild,
      ),
    );

    // 使用 SizedBox 控制卡片的 width 和 height
    if (width != null || height != null) {
      content = SizedBox(width: width, height: height, child: content);
    }

    // 若有外边距 margin 则套一层 Padding
    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    return content;
  }
}
