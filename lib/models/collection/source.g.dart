// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Source _$SourceFromJson(Map<String, dynamic> json) => _Source(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      mla: json['mla'] as String,
      url: json['url'] as String,
      citedBy: (json['citedBy'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$SourceToJson(_Source instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'mla': instance.mla,
      'url': instance.url,
      'citedBy': instance.citedBy,
    };
