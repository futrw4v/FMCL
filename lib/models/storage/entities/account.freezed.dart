// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Account _$AccountFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'offline':
          return OfflineAccount.fromJson(
            json
          );
                case 'microsoft':
          return MicrosoftAccount.fromJson(
            json
          );
                case 'external':
          return ExternalAccount.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Account',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Account {

 String get name; String get uuid; String get skin;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.name, name) || other.name == name)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.skin, skin) || other.skin == skin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,uuid,skin);

@override
String toString() {
  return 'Account(name: $name, uuid: $uuid, skin: $skin)';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 String name, String uuid, String skin
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? uuid = null,Object? skin = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,skin: null == skin ? _self.skin : skin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OfflineAccount value)?  offline,TResult Function( MicrosoftAccount value)?  microsoft,TResult Function( ExternalAccount value)?  external,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OfflineAccount() when offline != null:
return offline(_that);case MicrosoftAccount() when microsoft != null:
return microsoft(_that);case ExternalAccount() when external != null:
return external(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OfflineAccount value)  offline,required TResult Function( MicrosoftAccount value)  microsoft,required TResult Function( ExternalAccount value)  external,}){
final _that = this;
switch (_that) {
case OfflineAccount():
return offline(_that);case MicrosoftAccount():
return microsoft(_that);case ExternalAccount():
return external(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OfflineAccount value)?  offline,TResult? Function( MicrosoftAccount value)?  microsoft,TResult? Function( ExternalAccount value)?  external,}){
final _that = this;
switch (_that) {
case OfflineAccount() when offline != null:
return offline(_that);case MicrosoftAccount() when microsoft != null:
return microsoft(_that);case ExternalAccount() when external != null:
return external(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String uuid,  String skin)?  offline,TResult Function( String name,  String uuid,  String skin,  String refreshToken)?  microsoft,TResult Function( String name,  String uuid,  String skin,  String authServerUrl)?  external,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OfflineAccount() when offline != null:
return offline(_that.name,_that.uuid,_that.skin);case MicrosoftAccount() when microsoft != null:
return microsoft(_that.name,_that.uuid,_that.skin,_that.refreshToken);case ExternalAccount() when external != null:
return external(_that.name,_that.uuid,_that.skin,_that.authServerUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String uuid,  String skin)  offline,required TResult Function( String name,  String uuid,  String skin,  String refreshToken)  microsoft,required TResult Function( String name,  String uuid,  String skin,  String authServerUrl)  external,}) {final _that = this;
switch (_that) {
case OfflineAccount():
return offline(_that.name,_that.uuid,_that.skin);case MicrosoftAccount():
return microsoft(_that.name,_that.uuid,_that.skin,_that.refreshToken);case ExternalAccount():
return external(_that.name,_that.uuid,_that.skin,_that.authServerUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String uuid,  String skin)?  offline,TResult? Function( String name,  String uuid,  String skin,  String refreshToken)?  microsoft,TResult? Function( String name,  String uuid,  String skin,  String authServerUrl)?  external,}) {final _that = this;
switch (_that) {
case OfflineAccount() when offline != null:
return offline(_that.name,_that.uuid,_that.skin);case MicrosoftAccount() when microsoft != null:
return microsoft(_that.name,_that.uuid,_that.skin,_that.refreshToken);case ExternalAccount() when external != null:
return external(_that.name,_that.uuid,_that.skin,_that.authServerUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class OfflineAccount implements Account {
  const OfflineAccount(this.name, this.uuid, this.skin, {final  String? $type}): $type = $type ?? 'offline';
  factory OfflineAccount.fromJson(Map<String, dynamic> json) => _$OfflineAccountFromJson(json);

@override final  String name;
@override final  String uuid;
@override final  String skin;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineAccountCopyWith<OfflineAccount> get copyWith => _$OfflineAccountCopyWithImpl<OfflineAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineAccount&&(identical(other.name, name) || other.name == name)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.skin, skin) || other.skin == skin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,uuid,skin);

@override
String toString() {
  return 'Account.offline(name: $name, uuid: $uuid, skin: $skin)';
}


}

/// @nodoc
abstract mixin class $OfflineAccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory $OfflineAccountCopyWith(OfflineAccount value, $Res Function(OfflineAccount) _then) = _$OfflineAccountCopyWithImpl;
@override @useResult
$Res call({
 String name, String uuid, String skin
});




}
/// @nodoc
class _$OfflineAccountCopyWithImpl<$Res>
    implements $OfflineAccountCopyWith<$Res> {
  _$OfflineAccountCopyWithImpl(this._self, this._then);

  final OfflineAccount _self;
  final $Res Function(OfflineAccount) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? uuid = null,Object? skin = null,}) {
  return _then(OfflineAccount(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,null == skin ? _self.skin : skin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MicrosoftAccount implements Account {
  const MicrosoftAccount(this.name, this.uuid, this.skin, this.refreshToken, {final  String? $type}): $type = $type ?? 'microsoft';
  factory MicrosoftAccount.fromJson(Map<String, dynamic> json) => _$MicrosoftAccountFromJson(json);

@override final  String name;
@override final  String uuid;
@override final  String skin;
 final  String refreshToken;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MicrosoftAccountCopyWith<MicrosoftAccount> get copyWith => _$MicrosoftAccountCopyWithImpl<MicrosoftAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MicrosoftAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MicrosoftAccount&&(identical(other.name, name) || other.name == name)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.skin, skin) || other.skin == skin)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,uuid,skin,refreshToken);

@override
String toString() {
  return 'Account.microsoft(name: $name, uuid: $uuid, skin: $skin, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $MicrosoftAccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory $MicrosoftAccountCopyWith(MicrosoftAccount value, $Res Function(MicrosoftAccount) _then) = _$MicrosoftAccountCopyWithImpl;
@override @useResult
$Res call({
 String name, String uuid, String skin, String refreshToken
});




}
/// @nodoc
class _$MicrosoftAccountCopyWithImpl<$Res>
    implements $MicrosoftAccountCopyWith<$Res> {
  _$MicrosoftAccountCopyWithImpl(this._self, this._then);

  final MicrosoftAccount _self;
  final $Res Function(MicrosoftAccount) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? uuid = null,Object? skin = null,Object? refreshToken = null,}) {
  return _then(MicrosoftAccount(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,null == skin ? _self.skin : skin // ignore: cast_nullable_to_non_nullable
as String,null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExternalAccount implements Account {
  const ExternalAccount(this.name, this.uuid, this.skin, this.authServerUrl, {final  String? $type}): $type = $type ?? 'external';
  factory ExternalAccount.fromJson(Map<String, dynamic> json) => _$ExternalAccountFromJson(json);

@override final  String name;
@override final  String uuid;
@override final  String skin;
 final  String authServerUrl;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExternalAccountCopyWith<ExternalAccount> get copyWith => _$ExternalAccountCopyWithImpl<ExternalAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExternalAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExternalAccount&&(identical(other.name, name) || other.name == name)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.skin, skin) || other.skin == skin)&&(identical(other.authServerUrl, authServerUrl) || other.authServerUrl == authServerUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,uuid,skin,authServerUrl);

@override
String toString() {
  return 'Account.external(name: $name, uuid: $uuid, skin: $skin, authServerUrl: $authServerUrl)';
}


}

/// @nodoc
abstract mixin class $ExternalAccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory $ExternalAccountCopyWith(ExternalAccount value, $Res Function(ExternalAccount) _then) = _$ExternalAccountCopyWithImpl;
@override @useResult
$Res call({
 String name, String uuid, String skin, String authServerUrl
});




}
/// @nodoc
class _$ExternalAccountCopyWithImpl<$Res>
    implements $ExternalAccountCopyWith<$Res> {
  _$ExternalAccountCopyWithImpl(this._self, this._then);

  final ExternalAccount _self;
  final $Res Function(ExternalAccount) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? uuid = null,Object? skin = null,Object? authServerUrl = null,}) {
  return _then(ExternalAccount(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,null == skin ? _self.skin : skin // ignore: cast_nullable_to_non_nullable
as String,null == authServerUrl ? _self.authServerUrl : authServerUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
