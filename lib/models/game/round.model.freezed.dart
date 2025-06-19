// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'round.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoundModel {
  int get roundNumber;
  ItemModel get itemA;
  ItemModel get itemB;
  double get correctRatio;
  double? get userEstimate;
  int get score;
  bool get isCompleted;

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RoundModelCopyWith<RoundModel> get copyWith =>
      _$RoundModelCopyWithImpl<RoundModel>(this as RoundModel, _$identity);

  /// Serializes this RoundModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RoundModel &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.itemA, itemA) || other.itemA == itemA) &&
            (identical(other.itemB, itemB) || other.itemB == itemB) &&
            (identical(other.correctRatio, correctRatio) ||
                other.correctRatio == correctRatio) &&
            (identical(other.userEstimate, userEstimate) ||
                other.userEstimate == userEstimate) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roundNumber, itemA, itemB,
      correctRatio, userEstimate, score, isCompleted);

  @override
  String toString() {
    return 'RoundModel(roundNumber: $roundNumber, itemA: $itemA, itemB: $itemB, correctRatio: $correctRatio, userEstimate: $userEstimate, score: $score, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $RoundModelCopyWith<$Res> {
  factory $RoundModelCopyWith(
          RoundModel value, $Res Function(RoundModel) _then) =
      _$RoundModelCopyWithImpl;
  @useResult
  $Res call(
      {int roundNumber,
      ItemModel itemA,
      ItemModel itemB,
      double correctRatio,
      double? userEstimate,
      int score,
      bool isCompleted});

  $ItemModelCopyWith<$Res> get itemA;
  $ItemModelCopyWith<$Res> get itemB;
}

/// @nodoc
class _$RoundModelCopyWithImpl<$Res> implements $RoundModelCopyWith<$Res> {
  _$RoundModelCopyWithImpl(this._self, this._then);

  final RoundModel _self;
  final $Res Function(RoundModel) _then;

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundNumber = null,
    Object? itemA = null,
    Object? itemB = null,
    Object? correctRatio = null,
    Object? userEstimate = freezed,
    Object? score = null,
    Object? isCompleted = null,
  }) {
    return _then(_self.copyWith(
      roundNumber: null == roundNumber
          ? _self.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      itemA: null == itemA
          ? _self.itemA
          : itemA // ignore: cast_nullable_to_non_nullable
              as ItemModel,
      itemB: null == itemB
          ? _self.itemB
          : itemB // ignore: cast_nullable_to_non_nullable
              as ItemModel,
      correctRatio: null == correctRatio
          ? _self.correctRatio
          : correctRatio // ignore: cast_nullable_to_non_nullable
              as double,
      userEstimate: freezed == userEstimate
          ? _self.userEstimate
          : userEstimate // ignore: cast_nullable_to_non_nullable
              as double?,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res> get itemA {
    return $ItemModelCopyWith<$Res>(_self.itemA, (value) {
      return _then(_self.copyWith(itemA: value));
    });
  }

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res> get itemB {
    return $ItemModelCopyWith<$Res>(_self.itemB, (value) {
      return _then(_self.copyWith(itemB: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _RoundModel implements RoundModel {
  const _RoundModel(
      {required this.roundNumber,
      required this.itemA,
      required this.itemB,
      required this.correctRatio,
      this.userEstimate,
      this.score = 0,
      this.isCompleted = false});
  factory _RoundModel.fromJson(Map<String, dynamic> json) =>
      _$RoundModelFromJson(json);

  @override
  final int roundNumber;
  @override
  final ItemModel itemA;
  @override
  final ItemModel itemB;
  @override
  final double correctRatio;
  @override
  final double? userEstimate;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final bool isCompleted;

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RoundModelCopyWith<_RoundModel> get copyWith =>
      __$RoundModelCopyWithImpl<_RoundModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RoundModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RoundModel &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.itemA, itemA) || other.itemA == itemA) &&
            (identical(other.itemB, itemB) || other.itemB == itemB) &&
            (identical(other.correctRatio, correctRatio) ||
                other.correctRatio == correctRatio) &&
            (identical(other.userEstimate, userEstimate) ||
                other.userEstimate == userEstimate) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roundNumber, itemA, itemB,
      correctRatio, userEstimate, score, isCompleted);

  @override
  String toString() {
    return 'RoundModel(roundNumber: $roundNumber, itemA: $itemA, itemB: $itemB, correctRatio: $correctRatio, userEstimate: $userEstimate, score: $score, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class _$RoundModelCopyWith<$Res>
    implements $RoundModelCopyWith<$Res> {
  factory _$RoundModelCopyWith(
          _RoundModel value, $Res Function(_RoundModel) _then) =
      __$RoundModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int roundNumber,
      ItemModel itemA,
      ItemModel itemB,
      double correctRatio,
      double? userEstimate,
      int score,
      bool isCompleted});

  @override
  $ItemModelCopyWith<$Res> get itemA;
  @override
  $ItemModelCopyWith<$Res> get itemB;
}

/// @nodoc
class __$RoundModelCopyWithImpl<$Res> implements _$RoundModelCopyWith<$Res> {
  __$RoundModelCopyWithImpl(this._self, this._then);

  final _RoundModel _self;
  final $Res Function(_RoundModel) _then;

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roundNumber = null,
    Object? itemA = null,
    Object? itemB = null,
    Object? correctRatio = null,
    Object? userEstimate = freezed,
    Object? score = null,
    Object? isCompleted = null,
  }) {
    return _then(_RoundModel(
      roundNumber: null == roundNumber
          ? _self.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      itemA: null == itemA
          ? _self.itemA
          : itemA // ignore: cast_nullable_to_non_nullable
              as ItemModel,
      itemB: null == itemB
          ? _self.itemB
          : itemB // ignore: cast_nullable_to_non_nullable
              as ItemModel,
      correctRatio: null == correctRatio
          ? _self.correctRatio
          : correctRatio // ignore: cast_nullable_to_non_nullable
              as double,
      userEstimate: freezed == userEstimate
          ? _self.userEstimate
          : userEstimate // ignore: cast_nullable_to_non_nullable
              as double?,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res> get itemA {
    return $ItemModelCopyWith<$Res>(_self.itemA, (value) {
      return _then(_self.copyWith(itemA: value));
    });
  }

  /// Create a copy of RoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res> get itemB {
    return $ItemModelCopyWith<$Res>(_self.itemB, (value) {
      return _then(_self.copyWith(itemB: value));
    });
  }
}

// dart format on
