import 'package:fmcl/models/storage/entities/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_config.freezed.dart';
part 'accounts_config.g.dart';

@freezed
abstract class AccountsConfig with _$AccountsConfig {
  const factory AccountsConfig({
    @Default(1) int version,

    @Default('') String selectedAccountId,

    @Default([]) List<Account> accounts,
  }) = _AccountsConfig;

  // JSON 反序列化支持
  factory AccountsConfig.fromJson(Map<String, dynamic> json) =>
      _$AccountsConfigFromJson(json);
}
