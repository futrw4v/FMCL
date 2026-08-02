// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paths_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PathsConfig _$PathsConfigFromJson(Map<String, dynamic> json) => _PathsConfig(
  version: (json['version'] as num?)?.toInt() ?? 1,
  selectedPathId: json['selectedPathId'] as String? ?? '',
  paths:
      (json['paths'] as List<dynamic>?)
          ?.map((e) => DotMinecraftPath.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PathsConfigToJson(_PathsConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'selectedPathId': instance.selectedPathId,
      'paths': instance.paths,
    };
