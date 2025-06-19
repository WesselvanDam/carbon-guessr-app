// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameModel {
  List<RoundModel> get rounds;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameModelCopyWith<GameModel> get copyWith =>
      _$GameModelCopyWithImpl<GameModel>(this as GameModel, _$identity);

  /// Serializes this GameModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameModel &&
            const DeepCollectionEquality().equals(other.rounds, rounds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(rounds));

  @override
  String toString() {
    return 'GameModel(rounds: $rounds)';
  }
}

/// @nodoc
abstract mixin class $GameModelCopyWith<$Res> {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) _then) =
      _$GameModelCopyWithImpl;
  @useResult
  $Res call({List<RoundModel> rounds});
}

/// @nodoc
class _$GameModelCopyWithImpl<$Res> implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._self, this._then);

  final GameModel _self;
  final $Res Function(GameModel) _then;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rounds = null,
  }) {
    return _then(_self.copyWith(
      rounds: null == rounds
          ? _self.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<RoundModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GameModel extends GameModel {
  const _GameModel({required final List<RoundModel> rounds})
      : _rounds = rounds,
        super._();
  factory _GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  final List<RoundModel> _rounds;
  @override
  List<RoundModel> get rounds {
    if (_rounds is EqualUnmodifiableListView) return _rounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rounds);
  }

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameModelCopyWith<_GameModel> get copyWith =>
      __$GameModelCopyWithImpl<_GameModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GameModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameModel &&
            const DeepCollectionEquality().equals(other._rounds, _rounds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rounds));

  @override
  String toString() {
    return 'GameModel(rounds: $rounds)';
  }
}

/// @nodoc
abstract mixin class _$GameModelCopyWith<$Res>
    implements $GameModelCopyWith<$Res> {
  factory _$GameModelCopyWith(
          _GameModel value, $Res Function(_GameModel) _then) =
      __$GameModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<RoundModel> rounds});
}

/// @nodoc
class __$GameModelCopyWithImpl<$Res> implements _$GameModelCopyWith<$Res> {
  __$GameModelCopyWithImpl(this._self, this._then);

  final _GameModel _self;
  final $Res Function(_GameModel) _then;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rounds = null,
  }) {
    return _then(_GameModel(
      rounds: null == rounds
          ? _self._rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<RoundModel>,
    ));
  }
}

// dart format on
