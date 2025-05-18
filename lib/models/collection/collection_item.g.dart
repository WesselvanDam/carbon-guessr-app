// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) =>
    _CollectionItem(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      category: json['category'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CollectionItemToJson(_CollectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'value': instance.value,
      'category': instance.category,
      'sources': instance.sources,
    };
