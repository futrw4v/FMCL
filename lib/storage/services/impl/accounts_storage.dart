import 'package:fmcl/models/storage/configs/accounts_config.dart';
import 'package:fmcl/storage/services/abstract_json_storage.dart';

class AccountsStorage extends AbstractJsonStorage<AccountsConfig> {
  @override
  String get jsonPath => 'configs/accounts.json';

  @override
  AccountsConfig createDefault() => const AccountsConfig();

  @override
  AccountsConfig fromJson(Map<String, dynamic> json) =>
      AccountsConfig.fromJson(json);

  @override
  Map<String, dynamic> toJson(AccountsConfig data) => data.toJson();
}
