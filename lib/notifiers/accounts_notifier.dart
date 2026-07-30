import 'package:flutter/material.dart';
import 'package:fmcl/models/storage/configs/accounts_config.dart';
import 'package:fmcl/models/storage/entities/account.dart';
import 'package:fmcl/storage/storage_service.dart';

class AccountsNotifier extends ChangeNotifier {
  AccountsConfig get accountsConfig => StorageService.accountsConfig;

  Future<void> update(AccountsConfig newAccountsConfig) async {
    // 账号无变动时跳过更新
    if (newAccountsConfig == accountsConfig) {
      return;
    }

    await StorageService.accountsStorage.save(newAccountsConfig);

    // 通知 Widget 刷新界面
    notifyListeners();
  }

  /// 切换选中账号
  Future<void> selectAccount(String uuid) async {
    await update(accountsConfig.copyWith(selectedAccountUuid: uuid));
  }

  /// 添加一个新账号
  Future<void> addAccount(Account newAccount) async {
    final updatedList = [...accountsConfig.accounts, newAccount];

    final accountsConfigToUpdate = accountsConfig.copyWith(
      accounts: updatedList,
      // 如果当前未选中任何账号（或列表为空），自动将新添加的账号设为选中
      selectedAccountUuid: accountsConfig.selectedAccountUuid.isEmpty
          ? newAccount.uuid
          : accountsConfig.selectedAccountUuid,
    );

    await update(accountsConfigToUpdate);
  }

  /// 根据 UUID 删除指定账号
  Future<void> removeAccount(String uuid) async {
    final updatedList = accountsConfig.accounts
        .where((a) => a.uuid != uuid)
        .toList();

    // 更新选中账号
    final newSelectedUuid = accountsConfig.selectedAccountUuid == uuid
        ? ''
        : accountsConfig.selectedAccountUuid;

    final accountsConfigToUpdate = accountsConfig.copyWith(
      accounts: updatedList,
      selectedAccountUuid: newSelectedUuid,
    );

    await update(accountsConfigToUpdate);
  }
}
