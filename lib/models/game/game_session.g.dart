// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameSession _$GameSessionFromJson(Map<String, dynamic> json) => _GameSession(
      id: json['id'] as String,
      mode: $enumDecode(_$GameModeEnumMap, json['mode']),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => GameRound.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentRoundIndex: (json['currentRoundIndex'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GameSessionToJson(_GameSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mode': _$GameModeEnumMap[instance.mode]!,
      'rounds': instance.rounds,
      'currentRoundIndex': instance.currentRoundIndex,
      'isCompleted': instance.isCompleted,
    };

const _$GameModeEnumMap = {
  GameMode.simple: 'simple',
  GameMode.research: 'research',
};
