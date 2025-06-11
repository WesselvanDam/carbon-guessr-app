// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameSession _$GameSessionFromJson(Map<String, dynamic> json) => _GameSession(
      collectionInfo: CollectionInfo.fromJson(
          json['collectionInfo'] as Map<String, dynamic>),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => GameRound.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: $enumDecode(_$GameModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$GameSessionToJson(_GameSession instance) =>
    <String, dynamic>{
      'collectionInfo': instance.collectionInfo,
      'rounds': instance.rounds,
      'mode': _$GameModeEnumMap[instance.mode]!,
    };

const _$GameModeEnumMap = {
  GameMode.simple: 'simple',
  GameMode.research: 'research',
};
