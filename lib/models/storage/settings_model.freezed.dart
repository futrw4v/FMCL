// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsModel {

// Colors.blue = 4280391411
 int get themeColor; ThemeMode get themeMode; bool get autoClearLog; int get logLevel; bool get autoTranslate; bool get enableGoogleTranslate; GoogleTranslateApi get googleTranslateApi;
/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsModelCopyWith<SettingsModel> get copyWith => _$SettingsModelCopyWithImpl<SettingsModel>(this as SettingsModel, _$identity);

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsModel&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.autoClearLog, autoClearLog) || other.autoClearLog == autoClearLog)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.autoTranslate, autoTranslate) || other.autoTranslate == autoTranslate)&&(identical(other.enableGoogleTranslate, enableGoogleTranslate) || other.enableGoogleTranslate == enableGoogleTranslate)&&(identical(other.googleTranslateApi, googleTranslateApi) || other.googleTranslateApi == googleTranslateApi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeColor,themeMode,autoClearLog,logLevel,autoTranslate,enableGoogleTranslate,googleTranslateApi);

@override
String toString() {
  return 'SettingsModel(themeColor: $themeColor, themeMode: $themeMode, autoClearLog: $autoClearLog, logLevel: $logLevel, autoTranslate: $autoTranslate, enableGoogleTranslate: $enableGoogleTranslate, googleTranslateApi: $googleTranslateApi)';
}


}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res>  {
  factory $SettingsModelCopyWith(SettingsModel value, $Res Function(SettingsModel) _then) = _$SettingsModelCopyWithImpl;
@useResult
$Res call({
 int themeColor, ThemeMode themeMode, bool autoClearLog, int logLevel, bool autoTranslate, bool enableGoogleTranslate, GoogleTranslateApi googleTranslateApi
});




}
/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  final SettingsModel _self;
  final $Res Function(SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeColor = null,Object? themeMode = null,Object? autoClearLog = null,Object? logLevel = null,Object? autoTranslate = null,Object? enableGoogleTranslate = null,Object? googleTranslateApi = null,}) {
  return _then(_self.copyWith(
themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as int,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,autoClearLog: null == autoClearLog ? _self.autoClearLog : autoClearLog // ignore: cast_nullable_to_non_nullable
as bool,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as int,autoTranslate: null == autoTranslate ? _self.autoTranslate : autoTranslate // ignore: cast_nullable_to_non_nullable
as bool,enableGoogleTranslate: null == enableGoogleTranslate ? _self.enableGoogleTranslate : enableGoogleTranslate // ignore: cast_nullable_to_non_nullable
as bool,googleTranslateApi: null == googleTranslateApi ? _self.googleTranslateApi : googleTranslateApi // ignore: cast_nullable_to_non_nullable
as GoogleTranslateApi,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsModel].
extension SettingsModelPatterns on SettingsModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _SettingsModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int themeColor,  ThemeMode themeMode,  bool autoClearLog,  int logLevel,  bool autoTranslate,  bool enableGoogleTranslate,  GoogleTranslateApi googleTranslateApi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.themeColor,_that.themeMode,_that.autoClearLog,_that.logLevel,_that.autoTranslate,_that.enableGoogleTranslate,_that.googleTranslateApi);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int themeColor,  ThemeMode themeMode,  bool autoClearLog,  int logLevel,  bool autoTranslate,  bool enableGoogleTranslate,  GoogleTranslateApi googleTranslateApi)  $default,) {final _that = this;
switch (_that) {
case _SettingsModel():
return $default(_that.themeColor,_that.themeMode,_that.autoClearLog,_that.logLevel,_that.autoTranslate,_that.enableGoogleTranslate,_that.googleTranslateApi);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int themeColor,  ThemeMode themeMode,  bool autoClearLog,  int logLevel,  bool autoTranslate,  bool enableGoogleTranslate,  GoogleTranslateApi googleTranslateApi)?  $default,) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.themeColor,_that.themeMode,_that.autoClearLog,_that.logLevel,_that.autoTranslate,_that.enableGoogleTranslate,_that.googleTranslateApi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsModel implements SettingsModel {
  const _SettingsModel({this.themeColor = 4280391411, this.themeMode = ThemeMode.system, this.autoClearLog = true, this.logLevel = 0, this.autoTranslate = true, this.enableGoogleTranslate = true, this.googleTranslateApi = GoogleTranslateApi.at});
  factory _SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

// Colors.blue = 4280391411
@override@JsonKey() final  int themeColor;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  bool autoClearLog;
@override@JsonKey() final  int logLevel;
@override@JsonKey() final  bool autoTranslate;
@override@JsonKey() final  bool enableGoogleTranslate;
@override@JsonKey() final  GoogleTranslateApi googleTranslateApi;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsModelCopyWith<_SettingsModel> get copyWith => __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsModel&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.autoClearLog, autoClearLog) || other.autoClearLog == autoClearLog)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.autoTranslate, autoTranslate) || other.autoTranslate == autoTranslate)&&(identical(other.enableGoogleTranslate, enableGoogleTranslate) || other.enableGoogleTranslate == enableGoogleTranslate)&&(identical(other.googleTranslateApi, googleTranslateApi) || other.googleTranslateApi == googleTranslateApi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeColor,themeMode,autoClearLog,logLevel,autoTranslate,enableGoogleTranslate,googleTranslateApi);

@override
String toString() {
  return 'SettingsModel(themeColor: $themeColor, themeMode: $themeMode, autoClearLog: $autoClearLog, logLevel: $logLevel, autoTranslate: $autoTranslate, enableGoogleTranslate: $enableGoogleTranslate, googleTranslateApi: $googleTranslateApi)';
}


}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res> implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(_SettingsModel value, $Res Function(_SettingsModel) _then) = __$SettingsModelCopyWithImpl;
@override @useResult
$Res call({
 int themeColor, ThemeMode themeMode, bool autoClearLog, int logLevel, bool autoTranslate, bool enableGoogleTranslate, GoogleTranslateApi googleTranslateApi
});




}
/// @nodoc
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeColor = null,Object? themeMode = null,Object? autoClearLog = null,Object? logLevel = null,Object? autoTranslate = null,Object? enableGoogleTranslate = null,Object? googleTranslateApi = null,}) {
  return _then(_SettingsModel(
themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as int,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,autoClearLog: null == autoClearLog ? _self.autoClearLog : autoClearLog // ignore: cast_nullable_to_non_nullable
as bool,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as int,autoTranslate: null == autoTranslate ? _self.autoTranslate : autoTranslate // ignore: cast_nullable_to_non_nullable
as bool,enableGoogleTranslate: null == enableGoogleTranslate ? _self.enableGoogleTranslate : enableGoogleTranslate // ignore: cast_nullable_to_non_nullable
as bool,googleTranslateApi: null == googleTranslateApi ? _self.googleTranslateApi : googleTranslateApi // ignore: cast_nullable_to_non_nullable
as GoogleTranslateApi,
  ));
}


}

// dart format on
