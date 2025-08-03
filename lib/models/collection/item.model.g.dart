// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => _ItemModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      quantity: json['quantity'] as String,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      category: json['category'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      isItemA: json['isItemA'] as bool? ?? true,
    );

Map<String, dynamic> _$ItemModelToJson(_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'quantity': instance.quantity,
      'description': instance.description,
      'value': instance.value,
      'category': instance.category,
      'sources': instance.sources,
      'isItemA': instance.isItemA,
    };
