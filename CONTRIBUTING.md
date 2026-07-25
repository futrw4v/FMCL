# 开发与贡献

感谢你对本项目的关注与支持！本项目欢迎任何形式的正向贡献！

## 参与贡献

### 提交 Issue

如果你发现了问题或有新的想法，欢迎提交 Issue：

- Bug 反馈：请尽可能提供复现步骤、运行环境以及相关日志
- 功能建议：请描述使用场景以及期望效果
- UI / 交互调整：涉及较大改动前，请先创建 Issue 讨论方案

### 提交 Pull Request

欢迎直接提交 Pull Request：

1. Fork 本仓库
2. 创建新的开发分支：

```bash
git checkout -b feature/your-feature
```
3. 提交你的修改并编写规范的 Commit 信息
4. 推送到你的 Fork 仓库
5. 在 GitHub 上发起 Pull Request，并在描述中关联对应的 Issue

---

## 本地构建

在自行编译或贡献代码前，请确保本地已配置好 Flutter 开发环境及对应的 IDE

### 构建步骤
1. **克隆仓库**
   ```bash
   git clone https://github.com/futrw4v/FMCL.git
   cd FMCL
   ```

2. **获取依赖**
   ```bash
   flutter pub get
   ```

3. **运行项目**
   ```bash
   flutter run
   ```

4. **构建发布版本**
   * **Windows**: `flutter build windows`
   * **macOS**: `flutter build macos`
   * **Linux**: `flutter build linux`

> **注意**：为了保证项目依赖一致性，本项目统一使用官方 `pub.dev` 作为 `pubspec.lock` 的下载源。如因网络原因需要临时使用中国镜像，**请勿将变更后的 `pubspec.lock` 提交至代码库**

**macOS / Linux:**
```bash
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

**Windows (PowerShell):**
```powershell
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

---

## 数据存储 (Shared Preferences)
应用使用 Shared Preferences 来实现本地持久化存储，以下为具体的键值

### 1. 全局及软件配置
| 键 | 值 | 类型 |
| -- | -- |-- |
| version | 软件版本(即将抛弃) | string |
| build | 软件构建号(即将抛弃) | int |
| themeColor | 自定义主题颜色 | int |
| themeMode | 是否跟随深色 | string |
| autoClearLog | 是否自动清理日志 | bool |
| logLevel | 日志等级(0:INFO, 1:WARNING, 2:ERROR) | int |
| SelectedAccountName | 选择的账号名称 | string |
| SelectedAccountType | 选择的账号类型(0:离线, 1:正版, 2:外置) | string |
| SelectedPath | 选择的文件夹 | string |
| SelectedGame | 选择的版本 | string |
| offline_accounts_list | 离线账号列表 | list(string) |
| online_accounts_list | 在线账号列表 | list(string) |
| external_accounts_list | 外置账号列表 | list(string) |
| PathList | 游戏文件夹列表 | list(string) |
| Path_$name | 版本路径 | string |
| Game_$name | 版本列表 | list(string) |
| javaSelectedPath | 所选Java路径 | string |
| javaRuntimes | Java运行时列表（以JSON格式存储） | string |

### 2. 用户账号
账号详细数据以特定格式的列表 `list(string)` 存储，键名为 `[账号类型]_account_$name`（其中 `$name` 为账户名）

#### 离线账号 (`offline_account_$name`)
| 序号 | 值 |
| -- | -- |
| 0 | 登录模式(0) |
| 1 | 生成UUID |
| 2 | 是否启用自定义UUID(1启用,0禁用) |
| 3 | 自定义UUID |

#### 正版登录账号 (`online_account_$name`)
| 序号 | 值 |
| -- | -- |
| 0 | 登录模式(1) |
| 1 | UUID |
| 2 | refreshToken |

#### 外置登录账号 (`external_account_$name`)
| 序号 | 值 |
| -- | -- |
| 0 | 登录模式(2) |
| 1 | UUID |
| 2 | 验证服务器URL |
| 3 | 服务器用户名 |
| 4 | 服务器密码 |
| 5 | accessToken |
| 6 | clientToken |

### 3.特定游戏版本配置 (`Config_${path}_$game`)
| 序号 | 值 |
| -- | -- |
| 0 | xmx |
| 1 | 是否启用全屏(1启用,0禁用) |
| 2 | 游戏宽度 |
| 3 | 游戏高度 |
| 4 | 模组加载器 |
