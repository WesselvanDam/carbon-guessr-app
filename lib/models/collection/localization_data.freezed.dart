// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizationData {
  int get id;
  String get title;
  String get description;

  /// Create a copy of LocalizationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocalizationDataCopyWith<LocalizationData> get copyWith =>
      _$LocalizationDataCopyWithImpl<LocalizationData>(
          this as LocalizationData, _$identity);

  /// Serializes this LocalizationData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocalizationData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  @override
  String toString() {
    return 'LocalizationData(id: $id, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class $LocalizationDataCopyWith<$Res> {
  factory $LocalizationDataCopyWith(
          LocalizationData value, $Res Function(LocalizationData) _then) =
      _$LocalizationDataCopyWithImpl;
  @useResult
  $Res call({int id, String title, String description});
}

/// @nodoc
class _$LocalizationDataCopyWithImpl<$Res>
    implements $LocalizationDataCopyWith<$Res> {
  _$LocalizationDataCopyWithImpl(this._self, this._then);

  final LocalizationData _self;
  final $Res Function(LocalizationData) _then;

  /// Create a copy of LocalizationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LocalizationData implements LocalizationData {
  const _LocalizationData(
      {required this.id, required this.title, required this.description});
  factory _LocalizationData.fromJson(Map<String, dynamic> json) =>
      _$LocalizationDataFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;

  /// Create a copy of LocalizationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocalizationDataCopyWith<_LocalizationData> get copyWith =>
      __$LocalizationDataCopyWithImpl<_LocalizationData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LocalizationDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocalizationData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  @override
  String toString() {
    return 'LocalizationData(id: $id, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$LocalizationDataCopyWith<$Res>
    implements $LocalizationDataCopyWith<$Res> {
  factory _$LocalizationDataCopyWith(
          _LocalizationData value, $Res Function(_LocalizationData) _then) =
      __$LocalizationDataCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title, String description});
}

/// @nodoc
class __$LocalizationDataCopyWithImpl<$Res>
    implements _$LocalizationDataCopyWith<$Res> {
  __$LocalizationDataCopyWithImpl(this._self, this._then);

  final _LocalizationData _self;
  final $Res Function(_LocalizationData) _then;

  /// Create a copy of LocalizationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_LocalizationData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
