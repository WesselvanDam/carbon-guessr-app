// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemModel {
  int get id;
  String get title;
  String get quantity;
  String get description;
  double get value;
  String get category;
  List<int> get sources;
  bool get isItemA;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<ItemModel> get copyWith =>
      _$ItemModelCopyWithImpl<ItemModel>(this as ItemModel, _$identity);

  /// Serializes this ItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other.sources, sources) &&
            (identical(other.isItemA, isItemA) || other.isItemA == isItemA));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, quantity, description,
      value, category, const DeepCollectionEquality().hash(sources), isItemA);

  @override
  String toString() {
    return 'ItemModel(id: $id, title: $title, quantity: $quantity, description: $description, value: $value, category: $category, sources: $sources, isItemA: $isItemA)';
  }
}

/// @nodoc
abstract mixin class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) _then) =
      _$ItemModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String quantity,
      String description,
      double value,
      String category,
      List<int> sources,
      bool isItemA});
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res> implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._self, this._then);

  final ItemModel _self;
  final $Res Function(ItemModel) _then;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? quantity = null,
    Object? description = null,
    Object? value = null,
    Object? category = null,
    Object? sources = null,
    Object? isItemA = null,
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
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _self.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isItemA: null == isItemA
          ? _self.isItemA
          : isItemA // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ItemModel implements ItemModel {
  const _ItemModel(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.description,
      required this.value,
      required this.category,
      required final List<int> sources,
      this.isItemA = true})
      : _sources = sources;
  factory _ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String quantity;
  @override
  final String description;
  @override
  final double value;
  @override
  final String category;
  final List<int> _sources;
  @override
  List<int> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  @JsonKey()
  final bool isItemA;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ItemModelCopyWith<_ItemModel> get copyWith =>
      __$ItemModelCopyWithImpl<_ItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(other.isItemA, isItemA) || other.isItemA == isItemA));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, quantity, description,
      value, category, const DeepCollectionEquality().hash(_sources), isItemA);

  @override
  String toString() {
    return 'ItemModel(id: $id, title: $title, quantity: $quantity, description: $description, value: $value, category: $category, sources: $sources, isItemA: $isItemA)';
  }
}

/// @nodoc
abstract mixin class _$ItemModelCopyWith<$Res>
    implements $ItemModelCopyWith<$Res> {
  factory _$ItemModelCopyWith(
          _ItemModel value, $Res Function(_ItemModel) _then) =
      __$ItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String quantity,
      String description,
      double value,
      String category,
      List<int> sources,
      bool isItemA});
}

/// @nodoc
class __$ItemModelCopyWithImpl<$Res> implements _$ItemModelCopyWith<$Res> {
  __$ItemModelCopyWithImpl(this._self, this._then);

  final _ItemModel _self;
  final $Res Function(_ItemModel) _then;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? quantity = null,
    Object? description = null,
    Object? value = null,
    Object? category = null,
    Object? sources = null,
    Object? isItemA = null,
  }) {
    return _then(_ItemModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _self._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isItemA: null == isItemA
          ? _self.isItemA
          : isItemA // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
