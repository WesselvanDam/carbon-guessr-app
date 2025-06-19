// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoundModel _$RoundModelFromJson(Map<String, dynamic> json) => _RoundModel(
      roundNumber: (json['roundNumber'] as num).toInt(),
      itemA: ItemModel.fromJson(json['itemA'] as Map<String, dynamic>),
      itemB: ItemModel.fromJson(json['itemB'] as Map<String, dynamic>),
      correctRatio: (json['correctRatio'] as num).toDouble(),
      userEstimate: (json['userEstimate'] as num?)?.toDouble(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$RoundModelToJson(_RoundModel instance) =>
    <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'itemA': instance.itemA,
      'itemB': instance.itemB,
      'correctRatio': instance.correctRatio,
      'userEstimate': instance.userEstimate,
      'score': instance.score,
      'isCompleted': instance.isCompleted,
    };
