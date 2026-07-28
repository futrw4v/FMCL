import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const factory Account.offline(String name, String uuid, String skin) =
      OfflineAccount;

  const factory Account.microsoft(
    String name,
    String uuid,
    String skin,
    String refreshToken,
  ) = MicrosoftAccount;

  const factory Account.external(
    String name,
    String uuid,
    String skin,
    String authServerUrl,
  ) = ExternalAccount;

  // 反序列化JSON支持
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
