// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemPair _$ItemPairFromJson(Map<String, dynamic> json) => _ItemPair(
      itemA: CollectionItem.fromJson(json['itemA'] as Map<String, dynamic>),
      itemB: CollectionItem.fromJson(json['itemB'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemPairToJson(_ItemPair instance) => <String, dynamic>{
      'itemA': instance.itemA,
      'itemB': instance.itemB,
    };
