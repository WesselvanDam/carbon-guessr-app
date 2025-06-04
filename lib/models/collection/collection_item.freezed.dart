// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionItem {
  int get id;
  String get title;
  String get quantity;
  String get description;
  double get value;
  String get category;
  List<int> get sources;

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CollectionItemCopyWith<CollectionItem> get copyWith =>
      _$CollectionItemCopyWithImpl<CollectionItem>(
          this as CollectionItem, _$identity);

  /// Serializes this CollectionItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CollectionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other.sources, sources));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, quantity, description,
      value, category, const DeepCollectionEquality().hash(sources));

  @override
  String toString() {
    return 'CollectionItem(id: $id, title: $title, quantity: $quantity, description: $description, value: $value, category: $category, sources: $sources)';
  }
}

/// @nodoc
abstract mixin class $CollectionItemCopyWith<$Res> {
  factory $CollectionItemCopyWith(
          CollectionItem value, $Res Function(CollectionItem) _then) =
      _$CollectionItemCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String quantity,
      String description,
      double value,
      String category,
      List<int> sources});
}

/// @nodoc
class _$CollectionItemCopyWithImpl<$Res>
    implements $CollectionItemCopyWith<$Res> {
  _$CollectionItemCopyWithImpl(this._self, this._then);

  final CollectionItem _self;
  final $Res Function(CollectionItem) _then;

  /// Create a copy of CollectionItem
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CollectionItem implements CollectionItem {
  const _CollectionItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.description,
      required this.value,
      required this.category,
      required final List<int> sources})
      : _sources = sources;
  factory _CollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionItemFromJson(json);

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

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CollectionItemCopyWith<_CollectionItem> get copyWith =>
      __$CollectionItemCopyWithImpl<_CollectionItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CollectionItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CollectionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._sources, _sources));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, quantity, description,
      value, category, const DeepCollectionEquality().hash(_sources));

  @override
  String toString() {
    return 'CollectionItem(id: $id, title: $title, quantity: $quantity, description: $description, value: $value, category: $category, sources: $sources)';
  }
}

/// @nodoc
abstract mixin class _$CollectionItemCopyWith<$Res>
    implements $CollectionItemCopyWith<$Res> {
  factory _$CollectionItemCopyWith(
          _CollectionItem value, $Res Function(_CollectionItem) _then) =
      __$CollectionItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String quantity,
      String description,
      double value,
      String category,
      List<int> sources});
}

/// @nodoc
class __$CollectionItemCopyWithImpl<$Res>
    implements _$CollectionItemCopyWith<$Res> {
  __$CollectionItemCopyWithImpl(this._self, this._then);

  final _CollectionItem _self;
  final $Res Function(_CollectionItem) _then;

  /// Create a copy of CollectionItem
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
  }) {
    return _then(_CollectionItem(
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
    ));
  }
}

// dart format on
