// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineAccount _$OfflineAccountFromJson(Map<String, dynamic> json) =>
    OfflineAccount(
      json['name'] as String,
      json['uuid'] as String,
      json['skin'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$OfflineAccountToJson(OfflineAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'skin': instance.skin,
      'runtimeType': instance.$type,
    };

MicrosoftAccount _$MicrosoftAccountFromJson(Map<String, dynamic> json) =>
    MicrosoftAccount(
      json['name'] as String,
      json['uuid'] as String,
      json['skin'] as String,
      json['refreshToken'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MicrosoftAccountToJson(MicrosoftAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'skin': instance.skin,
      'refreshToken': instance.refreshToken,
      'runtimeType': instance.$type,
    };

ExternalAccount _$ExternalAccountFromJson(Map<String, dynamic> json) =>
    ExternalAccount(
      json['name'] as String,
      json['uuid'] as String,
      json['skin'] as String,
      json['authServerUrl'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ExternalAccountToJson(ExternalAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'skin': instance.skin,
      'authServerUrl': instance.authServerUrl,
      'runtimeType': instance.$type,
    };
