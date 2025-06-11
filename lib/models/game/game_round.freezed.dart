// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_round.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameRound {
  int get roundNumber;
  ItemPair get itemPair;
  double get correctRatio;
  double? get userEstimate;
  int get score;
  bool get isCompleted;

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameRoundCopyWith<GameRound> get copyWith =>
      _$GameRoundCopyWithImpl<GameRound>(this as GameRound, _$identity);

  /// Serializes this GameRound to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameRound &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.itemPair, itemPair) ||
                other.itemPair == itemPair) &&
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
  int get hashCode => Object.hash(runtimeType, roundNumber, itemPair,
      correctRatio, userEstimate, score, isCompleted);

  @override
  String toString() {
    return 'GameRound(roundNumber: $roundNumber, itemPair: $itemPair, correctRatio: $correctRatio, userEstimate: $userEstimate, score: $score, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $GameRoundCopyWith<$Res> {
  factory $GameRoundCopyWith(GameRound value, $Res Function(GameRound) _then) =
      _$GameRoundCopyWithImpl;
  @useResult
  $Res call(
      {int roundNumber,
      ItemPair itemPair,
      double correctRatio,
      double? userEstimate,
      int score,
      bool isCompleted});

  $ItemPairCopyWith<$Res> get itemPair;
}

/// @nodoc
class _$GameRoundCopyWithImpl<$Res> implements $GameRoundCopyWith<$Res> {
  _$GameRoundCopyWithImpl(this._self, this._then);

  final GameRound _self;
  final $Res Function(GameRound) _then;

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundNumber = null,
    Object? itemPair = null,
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
      itemPair: null == itemPair
          ? _self.itemPair
          : itemPair // ignore: cast_nullable_to_non_nullable
              as ItemPair,
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

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemPairCopyWith<$Res> get itemPair {
    return $ItemPairCopyWith<$Res>(_self.itemPair, (value) {
      return _then(_self.copyWith(itemPair: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _GameRound implements GameRound {
  const _GameRound(
      {required this.roundNumber,
      required this.itemPair,
      required this.correctRatio,
      this.userEstimate,
      this.score = 0,
      this.isCompleted = false});
  factory _GameRound.fromJson(Map<String, dynamic> json) =>
      _$GameRoundFromJson(json);

  @override
  final int roundNumber;
  @override
  final ItemPair itemPair;
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

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameRoundCopyWith<_GameRound> get copyWith =>
      __$GameRoundCopyWithImpl<_GameRound>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GameRoundToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameRound &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.itemPair, itemPair) ||
                other.itemPair == itemPair) &&
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
  int get hashCode => Object.hash(runtimeType, roundNumber, itemPair,
      correctRatio, userEstimate, score, isCompleted);

  @override
  String toString() {
    return 'GameRound(roundNumber: $roundNumber, itemPair: $itemPair, correctRatio: $correctRatio, userEstimate: $userEstimate, score: $score, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class _$GameRoundCopyWith<$Res>
    implements $GameRoundCopyWith<$Res> {
  factory _$GameRoundCopyWith(
          _GameRound value, $Res Function(_GameRound) _then) =
      __$GameRoundCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int roundNumber,
      ItemPair itemPair,
      double correctRatio,
      double? userEstimate,
      int score,
      bool isCompleted});

  @override
  $ItemPairCopyWith<$Res> get itemPair;
}

/// @nodoc
class __$GameRoundCopyWithImpl<$Res> implements _$GameRoundCopyWith<$Res> {
  __$GameRoundCopyWithImpl(this._self, this._then);

  final _GameRound _self;
  final $Res Function(_GameRound) _then;

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roundNumber = null,
    Object? itemPair = null,
    Object? correctRatio = null,
    Object? userEstimate = freezed,
    Object? score = null,
    Object? isCompleted = null,
  }) {
    return _then(_GameRound(
      roundNumber: null == roundNumber
          ? _self.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      itemPair: null == itemPair
          ? _self.itemPair
          : itemPair // ignore: cast_nullable_to_non_nullable
              as ItemPair,
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

  /// Create a copy of GameRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemPairCopyWith<$Res> get itemPair {
    return $ItemPairCopyWith<$Res>(_self.itemPair, (value) {
      return _then(_self.copyWith(itemPair: value));
    });
  }
}

// dart format on
