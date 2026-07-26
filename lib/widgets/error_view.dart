import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';

class ErrorView extends StatelessWidget {
  /// 显示的标题，默认为 加载出错
  final String title;

  /// 显示的正文
  final String body;

  /// 点击重试按钮时所执行的操作，当为空时不显示重试按钮
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.title = '加载出错',
    required this.body,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // 居中 & 添加左右间距
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 4),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          spacing: kDefaultPadding,

          children: [
            // 图标
            Flexible(
              child: Image.asset(
                'assets/img/icon/error_transparent.png',
                height: 150,
              ),
            ),

            // 标题
            Text(title, style: Theme.of(context).textTheme.titleMedium),

            // 在正文左右添加间距
            Text(
              body,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            // 重试按钮
            if (onRetry != null)
              FilledButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
