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
            ElevatedButton(onPressed: _clearSearch, child: const Text('清除搜索')),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: () => _isSearching
            ? _searchProjects(_searchController.text)
            : _fetchProjects(),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _projectsList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildSearchBar();
            }
            final project = _projectsList[index - 1];
            return _buildProjectAppCard(project);
          },
        ),
      );
    }

    return Scaffold(
      body: body,
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

    await _search(query);
  }

  // Modrinth 搜索
  Future<void> _search(String query) async {
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

    await _applyModrinthTranslations();
  }

  // 批量翻译
  Future<void> _applyModrinthTranslations() async {
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
  Widget _buildTypeChip(String? type) {
    String? displayName;
    displayName = modrinthProjectTypes[type];

    if (displayName == null) {
      return const SizedBox.shrink();
    }
    return Chip(
      label: Text(displayName),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelStyle: const TextStyle(fontSize: 10),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  // 搜索框
  Widget _buildSearchBar() {
    return AppCard(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 数据源选择
            Row(
              children: [
                const Text(
                  '数据源',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 12.0),

            // 搜索框
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '在Modrinth搜索',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
              onSubmitted: (value) => _searchProjects(value),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 12.0),
            // 项目类型选择
            const Text(
              '项目类型',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4.0),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('选择项目类型'),
              value: _modrinthProjectType,
              underline: Container(height: 1),
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
                setState(() {
                  _modrinthProjectType = newValue;
                });
                _searchProjects(_searchController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Modrinth 项目卡片
  Widget _buildProjectAppCard(dynamic project) {
    return AppCard(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: project['icon_url'] != null
            ? Image.network(
                project['icon_url'],
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.extension, size: 50),
              )
            : const Icon(Icons.extension, size: 50),
        title: Row(
          children: [
            if (project['project_type'] != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildTypeChip(project['project_type']),
              ),
            Expanded(
              child: Text(
                project['title'] ?? 'Unknown Title',
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project['description'] ?? 'No description available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: [
                ...?project['categories']?.map<Widget>(
                  (category) => Chip(
                    label: Text(category),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    labelStyle: const TextStyle(fontSize: 10),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () => Navigator.push(
          context,
          SlidePageRoute(
            page: InfoPage(slug: project['slug'] ?? '', projectInfo: project),
          ),
        ),
      ),
    );
  }
}
