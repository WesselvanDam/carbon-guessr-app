// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemPair {
  CollectionItem get itemA;
  CollectionItem get itemB;

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ItemPairCopyWith<ItemPair> get copyWith =>
      _$ItemPairCopyWithImpl<ItemPair>(this as ItemPair, _$identity);

  /// Serializes this ItemPair to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ItemPair &&
            (identical(other.itemA, itemA) || other.itemA == itemA) &&
            (identical(other.itemB, itemB) || other.itemB == itemB));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemA, itemB);

  @override
  String toString() {
    return 'ItemPair(itemA: $itemA, itemB: $itemB)';
  }
}

/// @nodoc
abstract mixin class $ItemPairCopyWith<$Res> {
  factory $ItemPairCopyWith(ItemPair value, $Res Function(ItemPair) _then) =
      _$ItemPairCopyWithImpl;
  @useResult
  $Res call({CollectionItem itemA, CollectionItem itemB});

  $CollectionItemCopyWith<$Res> get itemA;
  $CollectionItemCopyWith<$Res> get itemB;
}

/// @nodoc
class _$ItemPairCopyWithImpl<$Res> implements $ItemPairCopyWith<$Res> {
  _$ItemPairCopyWithImpl(this._self, this._then);

  final ItemPair _self;
  final $Res Function(ItemPair) _then;

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemA = null,
    Object? itemB = null,
  }) {
    return _then(_self.copyWith(
      itemA: null == itemA
          ? _self.itemA
          : itemA // ignore: cast_nullable_to_non_nullable
              as CollectionItem,
      itemB: null == itemB
          ? _self.itemB
          : itemB // ignore: cast_nullable_to_non_nullable
              as CollectionItem,
    ));
  }

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionItemCopyWith<$Res> get itemA {
    return $CollectionItemCopyWith<$Res>(_self.itemA, (value) {
      return _then(_self.copyWith(itemA: value));
    });
  }

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionItemCopyWith<$Res> get itemB {
    return $CollectionItemCopyWith<$Res>(_self.itemB, (value) {
      return _then(_self.copyWith(itemB: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ItemPair implements ItemPair {
  const _ItemPair({required this.itemA, required this.itemB});
  factory _ItemPair.fromJson(Map<String, dynamic> json) =>
      _$ItemPairFromJson(json);

  @override
  final CollectionItem itemA;
  @override
  final CollectionItem itemB;

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ItemPairCopyWith<_ItemPair> get copyWith =>
      __$ItemPairCopyWithImpl<_ItemPair>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ItemPairToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemPair &&
            (identical(other.itemA, itemA) || other.itemA == itemA) &&
            (identical(other.itemB, itemB) || other.itemB == itemB));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemA, itemB);

  @override
  String toString() {
    return 'ItemPair(itemA: $itemA, itemB: $itemB)';
  }
}

/// @nodoc
abstract mixin class _$ItemPairCopyWith<$Res>
    implements $ItemPairCopyWith<$Res> {
  factory _$ItemPairCopyWith(_ItemPair value, $Res Function(_ItemPair) _then) =
      __$ItemPairCopyWithImpl;
  @override
  @useResult
  $Res call({CollectionItem itemA, CollectionItem itemB});

  @override
  $CollectionItemCopyWith<$Res> get itemA;
  @override
  $CollectionItemCopyWith<$Res> get itemB;
}

/// @nodoc
class __$ItemPairCopyWithImpl<$Res> implements _$ItemPairCopyWith<$Res> {
  __$ItemPairCopyWithImpl(this._self, this._then);

  final _ItemPair _self;
  final $Res Function(_ItemPair) _then;

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? itemA = null,
    Object? itemB = null,
  }) {
    return _then(_ItemPair(
      itemA: null == itemA
          ? _self.itemA
          : itemA // ignore: cast_nullable_to_non_nullable
              as CollectionItem,
      itemB: null == itemB
          ? _self.itemB
          : itemB // ignore: cast_nullable_to_non_nullable
              as CollectionItem,
    ));
  }

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionItemCopyWith<$Res> get itemA {
    return $CollectionItemCopyWith<$Res>(_self.itemA, (value) {
      return _then(_self.copyWith(itemA: value));
    });
  }

  /// Create a copy of ItemPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionItemCopyWith<$Res> get itemB {
    return $CollectionItemCopyWith<$Res>(_self.itemB, (value) {
      return _then(_self.copyWith(itemB: value));
    });
  }
}

// dart format on
