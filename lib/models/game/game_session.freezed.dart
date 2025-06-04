// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameSession {
  List<GameRound> get rounds;
  int get roundDurationSeconds;
  double get ratioBoundary;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameSessionCopyWith<GameSession> get copyWith =>
      _$GameSessionCopyWithImpl<GameSession>(this as GameSession, _$identity);

  /// Serializes this GameSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameSession &&
            const DeepCollectionEquality().equals(other.rounds, rounds) &&
            (identical(other.roundDurationSeconds, roundDurationSeconds) ||
                other.roundDurationSeconds == roundDurationSeconds) &&
            (identical(other.ratioBoundary, ratioBoundary) ||
                other.ratioBoundary == ratioBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rounds),
      roundDurationSeconds,
      ratioBoundary);

  @override
  String toString() {
    return 'GameSession(rounds: $rounds, roundDurationSeconds: $roundDurationSeconds, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class $GameSessionCopyWith<$Res> {
  factory $GameSessionCopyWith(
          GameSession value, $Res Function(GameSession) _then) =
      _$GameSessionCopyWithImpl;
  @useResult
  $Res call(
      {List<GameRound> rounds, int roundDurationSeconds, double ratioBoundary});
}

/// @nodoc
class _$GameSessionCopyWithImpl<$Res> implements $GameSessionCopyWith<$Res> {
  _$GameSessionCopyWithImpl(this._self, this._then);

  final GameSession _self;
  final $Res Function(GameSession) _then;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rounds = null,
    Object? roundDurationSeconds = null,
    Object? ratioBoundary = null,
  }) {
    return _then(_self.copyWith(
      rounds: null == rounds
          ? _self.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<GameRound>,
      roundDurationSeconds: null == roundDurationSeconds
          ? _self.roundDurationSeconds
          : roundDurationSeconds // ignore: cast_nullable_to_non_nullable
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
class _GameSession extends GameSession {
  const _GameSession(
      {required final List<GameRound> rounds,
      required this.roundDurationSeconds,
      required this.ratioBoundary})
      : _rounds = rounds,
        super._();
  factory _GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);

  final List<GameRound> _rounds;
  @override
  List<GameRound> get rounds {
    if (_rounds is EqualUnmodifiableListView) return _rounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rounds);
  }

  @override
  final int roundDurationSeconds;
  @override
  final double ratioBoundary;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameSessionCopyWith<_GameSession> get copyWith =>
      __$GameSessionCopyWithImpl<_GameSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GameSessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameSession &&
            const DeepCollectionEquality().equals(other._rounds, _rounds) &&
            (identical(other.roundDurationSeconds, roundDurationSeconds) ||
                other.roundDurationSeconds == roundDurationSeconds) &&
            (identical(other.ratioBoundary, ratioBoundary) ||
                other.ratioBoundary == ratioBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_rounds),
      roundDurationSeconds,
      ratioBoundary);

  @override
  String toString() {
    return 'GameSession(rounds: $rounds, roundDurationSeconds: $roundDurationSeconds, ratioBoundary: $ratioBoundary)';
  }
}

/// @nodoc
abstract mixin class _$GameSessionCopyWith<$Res>
    implements $GameSessionCopyWith<$Res> {
  factory _$GameSessionCopyWith(
          _GameSession value, $Res Function(_GameSession) _then) =
      __$GameSessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<GameRound> rounds, int roundDurationSeconds, double ratioBoundary});
}

/// @nodoc
class __$GameSessionCopyWithImpl<$Res> implements _$GameSessionCopyWith<$Res> {
  __$GameSessionCopyWithImpl(this._self, this._then);

  final _GameSession _self;
  final $Res Function(_GameSession) _then;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rounds = null,
    Object? roundDurationSeconds = null,
    Object? ratioBoundary = null,
  }) {
    return _then(_GameSession(
      rounds: null == rounds
          ? _self._rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<GameRound>,
      roundDurationSeconds: null == roundDurationSeconds
          ? _self.roundDurationSeconds
          : roundDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      ratioBoundary: null == ratioBoundary
          ? _self.ratioBoundary
          : ratioBoundary // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
