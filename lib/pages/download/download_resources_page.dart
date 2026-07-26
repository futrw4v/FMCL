import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fmcl/constants.dart';
import 'package:fmcl/pages/download/modrinth/info_page.dart';
import 'package:fmcl/utils/dio_client.dart';
import 'package:fmcl/utils/log_util.dart';
import 'package:fmcl/utils/slide_page_route.dart';
import 'package:fmcl/widgets/app_card.dart';
import 'package:fmcl/widgets/error_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadResources extends StatefulWidget {
  const DownloadResources({super.key});

  @override
  DownloadResourcesState createState() => DownloadResourcesState();
}

class DownloadResourcesState extends State<DownloadResources> {
  List<dynamic> _projectsList = [];

  bool _isLoading = true;
  bool _showScrollToTop = false;
  bool _isSearching = false;

  String? _error;
  String? _modrinthProjectType;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  static const int minecraftGameId = 432;

  final Map<String, String> modrinthProjectTypes = {
    'mod': '模组',
    'modpack': '整合包',
    'resourcepack': '资源包',
    'shader': '光影',
  };

  @override
  void initState() {
    super.initState();

    _fetchProjects();

    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = ErrorView(
        body: _error!,
        onRetry: () {
          if (_isSearching) {
            _searchProjects(_searchController.text);
          } else {
            _fetchProjects();
          }
        },
      );
    } else if (_projectsList.isEmpty) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('未找到相关项目'),
            const SizedBox(height: 20),
            FilledButton(onPressed: _clearSearch, child: const Text('清除搜索')),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: () => _isSearching
            ? _searchProjects(_searchController.text)
            : _fetchProjects(),

        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: kDefaultPadding);
          },

          controller: _scrollController,
          itemCount: _projectsList.length + 1,

          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildSearchBar();
            }

            final project = _projectsList[index - 1];
            return _buildProjectAppCard(context, project);
          },
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding * 2,
          right: kDefaultPadding * 2,
          bottom: kDefaultPadding,
        ),

        child: body,
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          if (_showScrollToTop)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: FloatingActionButton(
                heroTag: 'scrollToTopButton',
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward),
              ),
            ),

          if (!_isLoading)
            FloatingActionButton(
              heroTag: 'refreshButton',
              onPressed: _clearSearch,
              child: const Icon(Icons.refresh),
            ),
        ],
      ),
    );
  }

  // 滚动到顶部
  Future<void> _scrollToTop() async {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // 随机项目
  Future<void> _fetchProjects() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      LogUtil.log('开始请求随机项目', level: 'INFO');
      final response = await DioClient().dio.get(
        'https://api.modrinth.com/v2/projects_random?count=50',
        options: Options(headers: {'User-Agent': gAppUserAgent}),
      );

      if (response.statusCode == 200) {
        LogUtil.log('成功获取项目', level: 'INFO');
        _projectsList = response.data;
        await _applyTranslations();
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      } else {
        LogUtil.log('请求失败：状态码 ${response.statusCode}', level: 'ERROR');
        setState(() {
          _error = '请求失败：服务器返回状态码 ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      LogUtil.log('请求出错: $e', level: 'ERROR');

      if (mounted) {
        setState(() {
          _error = '网络请求失败: $e';
          _isLoading = false;
        });
      }
    }
  }

  // 搜索
  Future<void> _searchProjects(String query) async {
    if (query.isEmpty && _modrinthProjectType == null) {
      _fetchProjects();
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _error = null;
        _isSearching = true;
      });

      final Map<String, dynamic> queryParams = {'query': query};

      if (_modrinthProjectType != null) {
        queryParams['facets'] = '[["project_type:$_modrinthProjectType"]]';
      }

      LogUtil.log(
        '搜索Modrinth项目: $query, 类型: $_modrinthProjectType',
        level: 'INFO',
      );

      final response = await DioClient().dio.get(
        'https://api.modrinth.com/v2/search',
        options: Options(headers: {'User-Agent': gAppUserAgent}),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        LogUtil.log('成功获取搜索结果', level: 'INFO');
        _projectsList = response.data['hits'] ?? [];
        await _applyTranslations();
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      } else {
        LogUtil.log('搜索失败：状态码 ${response.statusCode}', level: 'ERROR');
        setState(() {
          _error = '搜索失败：服务器返回状态码 ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      LogUtil.log('搜索出错: $e', level: 'ERROR');
      if (mounted) {
        setState(() {
          _error = '搜索失败: $e';
          _isLoading = false;
        });
      }
    }
  }

  // 调度翻译
  Future<void> _applyTranslations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool autoTranslate = prefs.getBool('autoTranslate') ?? true;
    if (!autoTranslate) return;

    if (_projectsList.isEmpty) return;

    try {
      final ids = _projectsList
          .map((p) => (p['id'] ?? p['project_id'])?.toString())
          .where((id) => id != null)
          .toList();

      if (ids.isEmpty) return;

      LogUtil.log('正在批量获取翻译', level: 'INFO');

      final transResponse = await DioClient().dio.post(
        'https://mod.mcimirror.top/translate/modrinth',
        data: {'project_ids': ids},
        options: Options(
          headers: {'User-Agent': gAppUserAgent},
          validateStatus: (status) => status != null,
        ),
      );

      if (transResponse.statusCode == 200 && transResponse.data is List) {
        final Map<String, String> transMap = {};

        for (final t in transResponse.data as List) {
          if (t['project_id'] != null && t['translated'] != null) {
            transMap[t['project_id'].toString()] = t['translated'].toString();
          }
        }

        if (transMap.isEmpty) return;

        for (final project in _projectsList) {
          final id = (project['id'] ?? project['project_id'])?.toString();
          if (id != null && transMap.containsKey(id)) {
            project['description'] = transMap[id];
          }
        }

        LogUtil.log('Modrinth批量翻译应用成功', level: 'INFO');
      }
    } catch (e) {
      LogUtil.log('Modrinth批量翻译失败: $e', level: 'WARNING');
    }
  }

  // 清除搜索
  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _modrinthProjectType = null;
      _isSearching = false;
    });
    _fetchProjects();
  }

  // 类型标签
  Widget _buildTypeChip(String type) {
    // 使用Container代替Chip来自定义内边距
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 5),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),

      // 文本
      child: Text(
        modrinthProjectTypes[type] ?? "未知类型",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  // 搜索框
  Widget _buildSearchBar() {
    return AppCard(
      padding: const EdgeInsets.all(kDefaultPadding),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: kDefaultPadding,

        children: [
          // 搜索框
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: '在Modrinth中搜索',
              prefixIcon: const Icon(Icons.search),

              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                  : null,
            ),

            onSubmitted: (value) => _searchProjects(value),
            textInputAction: TextInputAction.search,
          ),

          // 项目类型选择
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text('类型', style: Theme.of(context).textTheme.bodyLarge),

              const Spacer(),

              SizedBox(
                width: 160,
                child: DropdownButtonFormField<String>(
                  hint: const Text('选择项目类型'),
                  initialValue: _modrinthProjectType,

                  decoration: InputDecoration(border: OutlineInputBorder()),

                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('全部类型'),
                    ),
                    ...modrinthProjectTypes.entries.map(
                      (entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    ),
                  ],

                  onChanged: (String? newValue) {
                    if (newValue == _modrinthProjectType) return;

                    setState(() {
                      _modrinthProjectType = newValue;
                    });

                    _searchProjects(_searchController.text);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 项目卡片
  Widget _buildProjectAppCard(BuildContext context, dynamic project) {
    final iconUrl = project['icon_url'];
    final type = project['project_type'];
    final title = project['title'];
    final description = project['description'];
    final categories = project['categories'];
    final slug = project['slug'];

    final loaders = project['loaders'];
    final downloads = project['downloads'];
    final dateModified = project['date_modified'];
    final gameVersions = project['game_versions'];
    final timeUpdated = project['updated'];

    final theme = Theme.of(context);

    return AppCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),

        onTap: () => Navigator.push(
          context,
          SlidePageRoute(
            page: InfoPage(slug: slug ?? '', projectInfo: project),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            spacing: kDefaultPadding,

            children: [
              _buildProjectIcon(context, iconUrl),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    // 标题与标签
                    Row(
                      children: [
                        if (type != null)
                          Padding(
                            // Type右侧间距
                            padding: const EdgeInsets.only(right: 6.0),
                            child: _buildTypeChip(type),
                          ),

                        Expanded(
                          child: Text(
                            title ?? 'Unknown Title',
                            style: theme.textTheme.titleMedium,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4.0),

                    // 简介描述
                    Text(
                      description ?? 'No description available',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(),
                    ),

                    const SizedBox(height: 2),

                    // 分类标签
                    if (categories != null &&
                        (categories as List).isNotEmpty) ...[
                      const SizedBox(height: 6.0),

                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (loaders != null && (loaders as List).isNotEmpty)
                            _buildMetaBadge(
                              context,
                              icon: Icons.construction,
                              // 合并多个loaders
                              text: (loaders)
                                  .take(2)
                                  .map((loader) {
                                    final str = loader.toString();
                                    if (str.isEmpty) return '';
                                    // 首字母大写
                                    return '${str[0].toUpperCase()}${str.substring(1)}';
                                  })
                                  .join(' / '),
                            ),

                          // 游戏版本（取最新版）
                          if (gameVersions != null &&
                              (gameVersions as List).isNotEmpty)
                            _buildMetaBadge(
                              context,
                              icon: Icons.sports_esports_outlined,
                              text: (gameVersions).last.toString(),
                            ),

                          // 下载量
                          if (downloads != null)
                            _buildMetaBadge(
                              context,
                              icon: Icons.file_download_outlined,
                              text: _formatDownloads(downloads),
                            ),

                          // 更新日期
                          if (dateModified ?? timeUpdated != null)
                            _buildMetaBadge(
                              context,
                              icon: Icons.schedule_outlined,
                              text: _formatDate(dateModified ?? timeUpdated),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaBadge(
    BuildContext context, {
    IconData? icon,
    required String text,
    Color? color,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 4, right: 5, top: 2, bottom: 4),
      decoration: BoxDecoration(
        color: color != null
            ? color.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          if (icon != null) ...[
            // 往下移动 1px
            Transform.translate(
              offset: Offset(0, 1),
              child: Icon(icon, size: 15),
            ),

            // 图标右侧空隙
            const SizedBox(width: 4),
          ],

          Text(
            text,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 13,
              height: 1.0,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ],
      ),
    );
  }

  // 构建项目图标
  Widget _buildProjectIcon(BuildContext context, String? iconUrl) {
    const double iconSize = 80.0;

    // 添加圆角
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),

      child: SizedBox(
        width: iconSize,
        height: iconSize,

        child: iconUrl != null && iconUrl.isNotEmpty
            ? Image.network(
                iconUrl,
                fit: BoxFit.cover,

                // 透明渐入
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;

                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                    child: child,
                  );
                },

                // 加载时转圈
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },

                // 异常时返回占位符
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.extension, size: 28),
                ),
              )
            : Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.extension, size: 28),
              ),
      ),
    );
  }

  String _formatDownloads(dynamic downloads) {
    final num? count = num.tryParse(downloads.toString());
    if (count == null) return '0';

    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return '$count';
  }

  String _formatDate(dynamic isoString) {
    if (isoString == null) return '';
    try {
      final dt = DateTime.parse(isoString.toString());
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}
