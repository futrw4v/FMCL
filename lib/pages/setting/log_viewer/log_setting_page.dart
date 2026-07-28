import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/widgets/app_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogSettingPage extends StatefulWidget {
  const LogSettingPage({super.key});

  @override
  LogSettingPageState createState() => LogSettingPageState();
}

class LogSettingPageState extends State<LogSettingPage> {
  int _logLevel = 0;

  // 读取日志配置信息
  Future<void> _readLogConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int logLevel = prefs.getInt('logLevel') ?? 0;

    setState(() {
      _logLevel = logLevel;
    });
  }

  // 保存日志等级配置
  Future<void> _saveLogLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('logLevel', _logLevel);
  }

  @override
  void initState() {
    super.initState();
    _readLogConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日志设置')),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2,
          vertical: kDefaultPadding,
        ),

        child: Column(
          spacing: kDefaultPadding,

          children: [
            AppCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text('日志等级', style: Theme.of(context).textTheme.bodyLarge),

                    const Spacer(),

                    SizedBox(
                      width: 120,
                      child: DropdownButton<int>(
                        hint: const Text('日志等级'),
                        value: _logLevel,

                        elevation: 0,
                        underline: const SizedBox.shrink(),

                        items: [
                          DropdownMenuItem(value: 0, child: const Text('INFO')),

                          DropdownMenuItem(
                            value: 1,
                            child: const Text('WARNING'),
                          ),

                          DropdownMenuItem(
                            value: 2,
                            child: const Text('ERROR'),
                          ),
                        ],

                        onChanged: (int? value) {
                          setState(() {
                            _logLevel = value!;
                          });

                          _saveLogLevel();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
