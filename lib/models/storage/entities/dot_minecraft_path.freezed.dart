// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dot_minecraft_path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DotMinecraftPath {

/// 唯一标识符
 String get id;/// UI 上显示的名称
 String get name;/// 本地物理绝对路径
 String get path;
/// Create a copy of DotMinecraftPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotMinecraftPathCopyWith<DotMinecraftPath> get copyWith => _$DotMinecraftPathCopyWithImpl<DotMinecraftPath>(this as DotMinecraftPath, _$identity);

  /// Serializes this DotMinecraftPath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotMinecraftPath&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,path);

@override
String toString() {
  return 'DotMinecraftPath(id: $id, name: $name, path: $path)';
}


}

/// @nodoc
abstract mixin class $DotMinecraftPathCopyWith<$Res>  {
  factory $DotMinecraftPathCopyWith(DotMinecraftPath value, $Res Function(DotMinecraftPath) _then) = _$DotMinecraftPathCopyWithImpl;
@useResult
$Res call({
 String id, String name, String path
});




}
/// @nodoc
class _$DotMinecraftPathCopyWithImpl<$Res>
    implements $DotMinecraftPathCopyWith<$Res> {
  _$DotMinecraftPathCopyWithImpl(this._self, this._then);

  final DotMinecraftPath _self;
  final $Res Function(DotMinecraftPath) _then;

/// Create a copy of DotMinecraftPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? path = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DotMinecraftPath].
extension DotMinecraftPathPatterns on DotMinecraftPath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotMinecraftPath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotMinecraftPath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotMinecraftPath value)  $default,){
final _that = this;
switch (_that) {
case _DotMinecraftPath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotMinecraftPath value)?  $default,){
final _that = this;
switch (_that) {
case _DotMinecraftPath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotMinecraftPath() when $default != null:
return $default(_that.id,_that.name,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String path)  $default,) {final _that = this;
switch (_that) {
case _DotMinecraftPath():
return $default(_that.id,_that.name,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String path)?  $default,) {final _that = this;
switch (_that) {
case _DotMinecraftPath() when $default != null:
return $default(_that.id,_that.name,_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DotMinecraftPath implements DotMinecraftPath {
  const _DotMinecraftPath({this.id = '', this.name = '', this.path = ''});
  factory _DotMinecraftPath.fromJson(Map<String, dynamic> json) => _$DotMinecraftPathFromJson(json);

/// 唯一标识符
@override@JsonKey() final  String id;
/// UI 上显示的名称
@override@JsonKey() final  String name;
/// 本地物理绝对路径
@override@JsonKey() final  String path;

/// Create a copy of DotMinecraftPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotMinecraftPathCopyWith<_DotMinecraftPath> get copyWith => __$DotMinecraftPathCopyWithImpl<_DotMinecraftPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DotMinecraftPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotMinecraftPath&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,path);

@override
String toString() {
  return 'DotMinecraftPath(id: $id, name: $name, path: $path)';
}


}

/// @nodoc
abstract mixin class _$DotMinecraftPathCopyWith<$Res> implements $DotMinecraftPathCopyWith<$Res> {
  factory _$DotMinecraftPathCopyWith(_DotMinecraftPath value, $Res Function(_DotMinecraftPath) _then) = __$DotMinecraftPathCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String path
});




}
/// @nodoc
class __$DotMinecraftPathCopyWithImpl<$Res>
    implements _$DotMinecraftPathCopyWith<$Res> {
  __$DotMinecraftPathCopyWithImpl(this._self, this._then);

  final _DotMinecraftPath _self;
  final $Res Function(_DotMinecraftPath) _then;

/// Create a copy of DotMinecraftPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? path = null,}) {
  return _then(_DotMinecraftPath(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
