// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionInfo {
  String get id;
  String get title;
  String get tagline;
  String get description;
  String get quantity;
  String get unit;
  int get size;
  double get ratioBoundary;

  /// Create a copy of CollectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CollectionInfoCopyWith<CollectionInfo> get copyWith =>
      _$CollectionInfoCopyWithImpl<CollectionInfo>(
          this as CollectionInfo, _$identity);

  /// Serializes this CollectionInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CollectionInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.ratioBoundary, ratioBoundary) ||
                other.ratioBoundary == ratioBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, tagline, description,
      quantity, unit, size, ratioBoundary);

  @override
  String toString() {
    return 'CollectionInfo(id: $id, title: $title, tagline: $tagline, description: $description, quantity: $quantity, unit: $unit, size: $size, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class $CollectionInfoCopyWith<$Res> {
  factory $CollectionInfoCopyWith(
          CollectionInfo value, $Res Function(CollectionInfo) _then) =
      _$CollectionInfoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String tagline,
      String description,
      String quantity,
      String unit,
      int size,
      double ratioBoundary});
}

/// @nodoc
class _$CollectionInfoCopyWithImpl<$Res>
    implements $CollectionInfoCopyWith<$Res> {
  _$CollectionInfoCopyWithImpl(this._self, this._then);

  final CollectionInfo _self;
  final $Res Function(CollectionInfo) _then;

  /// Create a copy of CollectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tagline = null,
    Object? description = null,
    Object? quantity = null,
    Object? unit = null,
    Object? size = null,
    Object? ratioBoundary = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tagline: null == tagline
          ? _self.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      ratioBoundary: null == ratioBoundary
          ? _self.ratioBoundary
          : ratioBoundary // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CollectionInfo implements CollectionInfo {
  const _CollectionInfo(
      {required this.id,
      required this.title,
      required this.tagline,
      required this.description,
      required this.quantity,
      required this.unit,
      required this.size,
      this.ratioBoundary = 1});
  factory _CollectionInfo.fromJson(Map<String, dynamic> json) =>
      _$CollectionInfoFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String tagline;
  @override
  final String description;
  @override
  final String quantity;
  @override
  final String unit;
  @override
  final int size;
  @override
  @JsonKey()
  final double ratioBoundary;

  /// Create a copy of CollectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CollectionInfoCopyWith<_CollectionInfo> get copyWith =>
      __$CollectionInfoCopyWithImpl<_CollectionInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CollectionInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CollectionInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.ratioBoundary, ratioBoundary) ||
                other.ratioBoundary == ratioBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, tagline, description,
      quantity, unit, size, ratioBoundary);

  @override
  String toString() {
    return 'CollectionInfo(id: $id, title: $title, tagline: $tagline, description: $description, quantity: $quantity, unit: $unit, size: $size, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class _$CollectionInfoCopyWith<$Res>
    implements $CollectionInfoCopyWith<$Res> {
  factory _$CollectionInfoCopyWith(
          _CollectionInfo value, $Res Function(_CollectionInfo) _then) =
      __$CollectionInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String tagline,
      String description,
      String quantity,
      String unit,
      int size,
      double ratioBoundary});
}

/// @nodoc
class __$CollectionInfoCopyWithImpl<$Res>
    implements _$CollectionInfoCopyWith<$Res> {
  __$CollectionInfoCopyWithImpl(this._self, this._then);

  final _CollectionInfo _self;
  final $Res Function(_CollectionInfo) _then;

  /// Create a copy of CollectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tagline = null,
    Object? description = null,
    Object? quantity = null,
    Object? unit = null,
    Object? size = null,
    Object? ratioBoundary = null,
  }) {
    return _then(_CollectionInfo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tagline: null == tagline
          ? _self.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      ratioBoundary: null == ratioBoundary
          ? _self.ratioBoundary
          : ratioBoundary // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
