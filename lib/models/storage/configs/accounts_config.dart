import 'package:fmcl/models/storage/entities/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_config.freezed.dart';
part 'accounts_config.g.dart';

@freezed
abstract class AccountsConfig with _$AccountsConfig {
  const AccountsConfig._();

  const factory AccountsConfig({
    @Default(1) int version,

    @Default('') String selectedAccountUuid,

    @Default([]) List<Account> accounts,
  }) = _AccountsConfig;

  /// 获取当前所选账号
  Account? get selectedAccount {
    if (selectedAccountUuid.isEmpty) return null;

    try {
      return accounts.firstWhere(
        (account) => account.uuid == selectedAccountUuid,
      );
    } catch (_) {
      return null;
    }
  }

  /// JSON 反序列化支持
  factory AccountsConfig.fromJson(Map<String, dynamic> json) =>
      _$AccountsConfigFromJson(json);
}
