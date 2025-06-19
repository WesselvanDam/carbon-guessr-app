// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameModel _$GameModelFromJson(Map<String, dynamic> json) => _GameModel(
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => RoundModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(_GameModel instance) =>
    <String, dynamic>{
      'rounds': instance.rounds,
    };
