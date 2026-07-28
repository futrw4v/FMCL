// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountsConfig _$AccountsConfigFromJson(Map<String, dynamic> json) =>
    _AccountsConfig(
      version: (json['version'] as num?)?.toInt() ?? 1,
      selectedAccountId: json['selectedAccountId'] as String? ?? '',
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AccountsConfigToJson(_AccountsConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'selectedAccountId': instance.selectedAccountId,
      'accounts': instance.accounts,
    };
