// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    _CollectionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as String,
      unit: json['unit'] as String,
      size: (json['size'] as num).toInt(),
      ratioBoundary: (json['ratioBoundary'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$CollectionModelToJson(_CollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tagline': instance.tagline,
      'description': instance.description,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'size': instance.size,
      'ratioBoundary': instance.ratioBoundary,
    };
