// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameRound _$GameRoundFromJson(Map<String, dynamic> json) => _GameRound(
      roundNumber: (json['roundNumber'] as num).toInt(),
      itemPair: ItemPair.fromJson(json['itemPair'] as Map<String, dynamic>),
      correctRatio: (json['correctRatio'] as num).toDouble(),
      userEstimate: (json['userEstimate'] as num?)?.toDouble(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GameRoundToJson(_GameRound instance) =>
    <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'itemPair': instance.itemPair,
      'correctRatio': instance.correctRatio,
      'userEstimate': instance.userEstimate,
      'score': instance.score,
      'isCompleted': instance.isCompleted,
    };
