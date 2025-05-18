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
  String get id;
  GameMode get mode;
  List<GameRound> get rounds;
  int get currentRoundIndex;
  bool get isCompleted;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(other.rounds, rounds) &&
            (identical(other.currentRoundIndex, currentRoundIndex) ||
                other.currentRoundIndex == currentRoundIndex) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      mode,
      const DeepCollectionEquality().hash(rounds),
      currentRoundIndex,
      isCompleted);

  @override
  String toString() {
    return 'GameSession(id: $id, mode: $mode, rounds: $rounds, currentRoundIndex: $currentRoundIndex, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $GameSessionCopyWith<$Res> {
  factory $GameSessionCopyWith(
          GameSession value, $Res Function(GameSession) _then) =
      _$GameSessionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      GameMode mode,
      List<GameRound> rounds,
      int currentRoundIndex,
      bool isCompleted});
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
    Object? id = null,
    Object? mode = null,
    Object? rounds = null,
    Object? currentRoundIndex = null,
    Object? isCompleted = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      rounds: null == rounds
          ? _self.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<GameRound>,
      currentRoundIndex: null == currentRoundIndex
          ? _self.currentRoundIndex
          : currentRoundIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GameSession implements GameSession {
  const _GameSession(
      {required this.id,
      required this.mode,
      required final List<GameRound> rounds,
      required this.currentRoundIndex,
      this.isCompleted = false})
      : _rounds = rounds;
  factory _GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);

  @override
  final String id;
  @override
  final GameMode mode;
  final List<GameRound> _rounds;
  @override
  List<GameRound> get rounds {
    if (_rounds is EqualUnmodifiableListView) return _rounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rounds);
  }

  @override
  final int currentRoundIndex;
  @override
  @JsonKey()
  final bool isCompleted;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(other._rounds, _rounds) &&
            (identical(other.currentRoundIndex, currentRoundIndex) ||
                other.currentRoundIndex == currentRoundIndex) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      mode,
      const DeepCollectionEquality().hash(_rounds),
      currentRoundIndex,
      isCompleted);

  @override
  String toString() {
    return 'GameSession(id: $id, mode: $mode, rounds: $rounds, currentRoundIndex: $currentRoundIndex, isCompleted: $isCompleted)';
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
      {String id,
      GameMode mode,
      List<GameRound> rounds,
      int currentRoundIndex,
      bool isCompleted});
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
    Object? id = null,
    Object? mode = null,
    Object? rounds = null,
    Object? currentRoundIndex = null,
    Object? isCompleted = null,
  }) {
    return _then(_GameSession(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      rounds: null == rounds
          ? _self._rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<GameRound>,
      currentRoundIndex: null == currentRoundIndex
          ? _self.currentRoundIndex
          : currentRoundIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
