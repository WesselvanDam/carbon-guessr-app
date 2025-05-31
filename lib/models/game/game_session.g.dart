// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameSession _$GameSessionFromJson(Map<String, dynamic> json) => _GameSession(
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => GameRound.fromJson(e as Map<String, dynamic>))
          .toList(),
      roundDurationSeconds: (json['roundDurationSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$GameSessionToJson(_GameSession instance) =>
    <String, dynamic>{
      'rounds': instance.rounds,
      'roundDurationSeconds': instance.roundDurationSeconds,
    };
