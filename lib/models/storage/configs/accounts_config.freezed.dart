// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountsConfig {

 int get version; String get selectedAccountUuid; List<Account> get accounts;
/// Create a copy of AccountsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsConfigCopyWith<AccountsConfig> get copyWith => _$AccountsConfigCopyWithImpl<AccountsConfig>(this as AccountsConfig, _$identity);

  /// Serializes this AccountsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsConfig&&(identical(other.version, version) || other.version == version)&&(identical(other.selectedAccountUuid, selectedAccountUuid) || other.selectedAccountUuid == selectedAccountUuid)&&const DeepCollectionEquality().equals(other.accounts, accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,selectedAccountUuid,const DeepCollectionEquality().hash(accounts));

@override
String toString() {
  return 'AccountsConfig(version: $version, selectedAccountUuid: $selectedAccountUuid, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $AccountsConfigCopyWith<$Res>  {
  factory $AccountsConfigCopyWith(AccountsConfig value, $Res Function(AccountsConfig) _then) = _$AccountsConfigCopyWithImpl;
@useResult
$Res call({
 int version, String selectedAccountUuid, List<Account> accounts
});




}
/// @nodoc
class _$AccountsConfigCopyWithImpl<$Res>
    implements $AccountsConfigCopyWith<$Res> {
  _$AccountsConfigCopyWithImpl(this._self, this._then);

  final AccountsConfig _self;
  final $Res Function(AccountsConfig) _then;

/// Create a copy of AccountsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? selectedAccountUuid = null,Object? accounts = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,selectedAccountUuid: null == selectedAccountUuid ? _self.selectedAccountUuid : selectedAccountUuid // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountsConfig].
extension AccountsConfigPatterns on AccountsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsConfig value)  $default,){
final _that = this;
switch (_that) {
case _AccountsConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  String selectedAccountUuid,  List<Account> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsConfig() when $default != null:
return $default(_that.version,_that.selectedAccountUuid,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  String selectedAccountUuid,  List<Account> accounts)  $default,) {final _that = this;
switch (_that) {
case _AccountsConfig():
return $default(_that.version,_that.selectedAccountUuid,_that.accounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  String selectedAccountUuid,  List<Account> accounts)?  $default,) {final _that = this;
switch (_that) {
case _AccountsConfig() when $default != null:
return $default(_that.version,_that.selectedAccountUuid,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountsConfig extends AccountsConfig {
  const _AccountsConfig({this.version = 1, this.selectedAccountUuid = '', final  List<Account> accounts = const []}): _accounts = accounts,super._();
  factory _AccountsConfig.fromJson(Map<String, dynamic> json) => _$AccountsConfigFromJson(json);

@override@JsonKey() final  int version;
@override@JsonKey() final  String selectedAccountUuid;
 final  List<Account> _accounts;
@override@JsonKey() List<Account> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of AccountsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsConfigCopyWith<_AccountsConfig> get copyWith => __$AccountsConfigCopyWithImpl<_AccountsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsConfig&&(identical(other.version, version) || other.version == version)&&(identical(other.selectedAccountUuid, selectedAccountUuid) || other.selectedAccountUuid == selectedAccountUuid)&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,selectedAccountUuid,const DeepCollectionEquality().hash(_accounts));

@override
String toString() {
  return 'AccountsConfig(version: $version, selectedAccountUuid: $selectedAccountUuid, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$AccountsConfigCopyWith<$Res> implements $AccountsConfigCopyWith<$Res> {
  factory _$AccountsConfigCopyWith(_AccountsConfig value, $Res Function(_AccountsConfig) _then) = __$AccountsConfigCopyWithImpl;
@override @useResult
$Res call({
 int version, String selectedAccountUuid, List<Account> accounts
});




}
/// @nodoc
class __$AccountsConfigCopyWithImpl<$Res>
    implements _$AccountsConfigCopyWith<$Res> {
  __$AccountsConfigCopyWithImpl(this._self, this._then);

  final _AccountsConfig _self;
  final $Res Function(_AccountsConfig) _then;

/// Create a copy of AccountsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? selectedAccountUuid = null,Object? accounts = null,}) {
  return _then(_AccountsConfig(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,selectedAccountUuid: null == selectedAccountUuid ? _self.selectedAccountUuid : selectedAccountUuid // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,
  ));
}


}

// dart format on
