// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Source {
  int get id;
  String get title;
  String get mla;
  String get url;
  List<int> get citedBy;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SourceCopyWith<Source> get copyWith =>
      _$SourceCopyWithImpl<Source>(this as Source, _$identity);

  /// Serializes this Source to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.mla, mla) || other.mla == mla) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other.citedBy, citedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, mla, url,
      const DeepCollectionEquality().hash(citedBy));

  @override
  String toString() {
    return 'Source(id: $id, title: $title, mla: $mla, url: $url, citedBy: $citedBy)';
  }
}

/// @nodoc
abstract mixin class $SourceCopyWith<$Res> {
  factory $SourceCopyWith(Source value, $Res Function(Source) _then) =
      _$SourceCopyWithImpl;
  @useResult
  $Res call({int id, String title, String mla, String url, List<int> citedBy});
}

/// @nodoc
class _$SourceCopyWithImpl<$Res> implements $SourceCopyWith<$Res> {
  _$SourceCopyWithImpl(this._self, this._then);

  final Source _self;
  final $Res Function(Source) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? mla = null,
    Object? url = null,
    Object? citedBy = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mla: null == mla
          ? _self.mla
          : mla // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      citedBy: null == citedBy
          ? _self.citedBy
          : citedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Source implements Source {
  const _Source(
      {required this.id,
      required this.title,
      required this.mla,
      required this.url,
      required final List<int> citedBy})
      : _citedBy = citedBy;
  factory _Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String mla;
  @override
  final String url;
  final List<int> _citedBy;
  @override
  List<int> get citedBy {
    if (_citedBy is EqualUnmodifiableListView) return _citedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_citedBy);
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SourceCopyWith<_Source> get copyWith =>
      __$SourceCopyWithImpl<_Source>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SourceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Source &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.mla, mla) || other.mla == mla) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._citedBy, _citedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, mla, url,
      const DeepCollectionEquality().hash(_citedBy));

  @override
  String toString() {
    return 'Source(id: $id, title: $title, mla: $mla, url: $url, citedBy: $citedBy)';
  }
}

/// @nodoc
abstract mixin class _$SourceCopyWith<$Res> implements $SourceCopyWith<$Res> {
  factory _$SourceCopyWith(_Source value, $Res Function(_Source) _then) =
      __$SourceCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title, String mla, String url, List<int> citedBy});
}

/// @nodoc
class __$SourceCopyWithImpl<$Res> implements _$SourceCopyWith<$Res> {
  __$SourceCopyWithImpl(this._self, this._then);

  final _Source _self;
  final $Res Function(_Source) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? mla = null,
    Object? url = null,
    Object? citedBy = null,
  }) {
    return _then(_Source(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mla: null == mla
          ? _self.mla
          : mla // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      citedBy: null == citedBy
          ? _self._citedBy
          : citedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
