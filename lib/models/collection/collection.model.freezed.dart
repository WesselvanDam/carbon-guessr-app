// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionModel {
  String get id;
  String get title;
  String get tagline;
  String get description;
  String get quantity;
  String get unit;
  int get size;
  double get ratioBoundary;

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CollectionModelCopyWith<CollectionModel> get copyWith =>
      _$CollectionModelCopyWithImpl<CollectionModel>(
          this as CollectionModel, _$identity);

  /// Serializes this CollectionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CollectionModel &&
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
    return 'CollectionModel(id: $id, title: $title, tagline: $tagline, description: $description, quantity: $quantity, unit: $unit, size: $size, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class $CollectionModelCopyWith<$Res> {
  factory $CollectionModelCopyWith(
          CollectionModel value, $Res Function(CollectionModel) _then) =
      _$CollectionModelCopyWithImpl;
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
class _$CollectionModelCopyWithImpl<$Res>
    implements $CollectionModelCopyWith<$Res> {
  _$CollectionModelCopyWithImpl(this._self, this._then);

  final CollectionModel _self;
  final $Res Function(CollectionModel) _then;

  /// Create a copy of CollectionModel
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
class _CollectionModel implements CollectionModel {
  const _CollectionModel(
      {required this.id,
      required this.title,
      required this.tagline,
      required this.description,
      required this.quantity,
      required this.unit,
      required this.size,
      this.ratioBoundary = 1});
  factory _CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

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

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CollectionModelCopyWith<_CollectionModel> get copyWith =>
      __$CollectionModelCopyWithImpl<_CollectionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CollectionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CollectionModel &&
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
    return 'CollectionModel(id: $id, title: $title, tagline: $tagline, description: $description, quantity: $quantity, unit: $unit, size: $size, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class _$CollectionModelCopyWith<$Res>
    implements $CollectionModelCopyWith<$Res> {
  factory _$CollectionModelCopyWith(
          _CollectionModel value, $Res Function(_CollectionModel) _then) =
      __$CollectionModelCopyWithImpl;
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
class __$CollectionModelCopyWithImpl<$Res>
    implements _$CollectionModelCopyWith<$Res> {
  __$CollectionModelCopyWithImpl(this._self, this._then);

  final _CollectionModel _self;
  final $Res Function(_CollectionModel) _then;

  /// Create a copy of CollectionModel
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
    return _then(_CollectionModel(
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
