import 'package:fmcl/models/storage/configs/accounts_config.dart';
import 'package:fmcl/models/storage/entities/account.dart';
import 'package:fmcl/storage/json_storage.dart';

extension AccountStorageX on JsonStorage<AccountsConfig> {
  Future<void> selectAccount(String uuid) {
    return update(data.copyWith(selectedAccountUuid: uuid));
  }

  Future<void> addAccount(Account newAccount) {
    final updatedList = [...data.accounts, newAccount];
    final newSelectedUuid = data.selectedAccountUuid.isEmpty
        ? newAccount.uuid
        : data.selectedAccountUuid;

    return update(
      data.copyWith(
        accounts: updatedList,
        selectedAccountUuid: newSelectedUuid,
      ),
    );
  }

  Future<void> removeAccount(String uuid) {
    final updatedList = data.accounts.where((a) => a.uuid != uuid).toList();
    final newSelectedUuid = data.selectedAccountUuid == uuid
        ? ''
        : data.selectedAccountUuid;

    return update(
      data.copyWith(
        accounts: updatedList,
        selectedAccountUuid: newSelectedUuid,
      ),
    );
  }
}
